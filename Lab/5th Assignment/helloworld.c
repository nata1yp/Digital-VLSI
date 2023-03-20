#include<stdlib.h>
#include "array_input.h"
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xparameters_ps.h"
#include "xaxidma.h"
#include "xtime_l.h"
#define N 1024

#define TX_DMA_ID                 XPAR_PS2PL_DMA_DEVICE_ID
#define TX_DMA_MM2S_LENGTH_ADDR  (XPAR_PS2PL_DMA_BASEADDR + 0x28) // Reports actual number of bytes transferred from PS->PL (use Xil_In32 for report)

#define RX_DMA_ID                 XPAR_PL2PS_DMA_DEVICE_ID
#define RX_DMA_S2MM_LENGTH_ADDR  (XPAR_PL2PS_DMA_BASEADDR + 0x58) // Reports actual number of bytes transferred from PL->PS (use Xil_In32 for report)

#define TX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x10000000) // 0 + 256MByte
#define RX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x18000000) // 0 + 384MByte


		int R[N][N],G[N][N],B[N][N];

		int border(int i,int j){
			if(i>=0 && i<N && j>=0 && j<N)
				return(array[i][j]);
			else
				return(0);
		}

		void fun_r(int i,int j){
			R[i][j] = array[i][j];
			G[i][j] = (int) ( ( border(i-1,j) + border(i+1,j) + border(i,j-1) + border(i,j+1) ) / 4 );
			B[i][j] = (int) ( ( border(i-1,j-1) + border(i+1,j-1) + border(i-1,j+1) + border(i+1,j+1) ) / 4 );
		}

		void fun_g1(int i,int j){
			R[i][j] = (int)((border(i-1,j) + border(i+1,j))/2);
			G[i][j] = array[i][j];
			B[i][j] = (int)((border(i,j-1) + border(i,j+1))/2);
		}

		void fun_g2(int i,int j){
			R[i][j] = (int)((border(i,j-1) + border(i,j+1))/2);
			G[i][j] = array[i][j];
			B[i][j] = (int)((border(i-1,j) + border(i+1,j))/2);
		}

		void fun_b(int i,int j){
			R[i][j] = (int) ( ( border(i-1,j-1) + border(i+1,j-1) + border(i-1,j+1) + border(i+1,j+1) ) / 4 );
			G[i][j] = (int) ( ( border(i-1,j) + border(i+1,j) + border(i,j-1) + border(i,j+1) ) / 4 );
			B[i][j] = array[i][j];
		}

		int decToBin(int dec){
			for (int c = 7; c >= 0; c--){
				int k = dec >> c;
				if (k & 1)
					printf("1");
				else
					printf("0");
			}
		}

/* User application global variables & defines */
int main()
{
	Xil_DCacheDisable();

	XTime preExecCyclesFPGA = 0;
	XTime postExecCyclesFPGA = 0;
	XTime preExecCyclesSW = 0;
	XTime postExecCyclesSW = 0;

	print("HELLO 1\r\n");
	// User application local variables
	XAxiDma_Config *CfgPtr_RX;
	XAxiDma_Config *CfgPtr_TX;
	int Status_TX;
	int Status_RX;
	int Tries = NUMBER_OF_TRANSFERS;
	int Index;
	u8 *TxBufferPtr;
	u8 *RxBufferPtr;
	//u8 Value;

	TxBufferPtr = (u8 *)TX_BUFFER;
	RxBufferPtr = (u8 *)RX_BUFFER;


	init_platform();

    // Step 1: Initialize TX-DMA Device (PS->PL)
	CfgPtr_TX = XAxiDma_LookupConfig(TX_DMA_ID);
		if (!CfgPtr_TX) {
			xil_printf("No config found for %d\r\n", TX_DMA_ID);
			return XST_FAILURE;
		}

		Status_TX = XAxiDma_CfgInitialize(&AxiDma, CfgPtr_TX);
		if (Status_TX != XST_SUCCESS) {
			xil_printf("Initialization failed %d\r\n", Status_TX);
			return XST_FAILURE;
		}

		if(XAxiDma_HasSg(&AxiDma)){
			xil_printf("Device configured as SG mode \r\n");
			return XST_FAILURE;
		}
		
    // Step 2: Initialize RX-DMA Device (PL->PS)
	CfgPtr_RX = XAxiDma_LookupConfig(RX_DMA_ID);
	if (!CfgPtr_RX) {
		xil_printf("No config found for %d\r\n", RX_DMA_ID);
		return XST_FAILURE;
	}

	Status_RX = XAxiDma_CfgInitialize(&AxiDma, CfgPtr_RX);
	if (Status_RX != XST_SUCCESS) {
		xil_printf("Initialization failed %d\r\n", Status_RX);
		return XST_FAILURE;
	}

	if(XAxiDma_HasSg(&AxiDma)){
		xil_printf("Device configured as SG mode \r\n");
		return XST_FAILURE;
	}

	/* Disable interrupts, we use polling mode
	 */
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);


    XTime_GetTime(&preExecCyclesFPGA);
    // Step 3 : Perform FPGA processing
    //      3a: Setup RX-DMA transaction
    //      3b: Setup TX-DMA transaction

    for(Index = 0; Index < Tries; Index ++) {


		Status_RX = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR) RxBufferPtr,
				RX_DMA_S2MM_LENGTH_ADDR, XAXIDMA_DEVICE_TO_DMA);

		if (Status_RX != XST_SUCCESS) {
			return XST_FAILURE;
		}

		Status_TX = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR) TxBufferPtr,
				TX_DMA_MM2S_LENGTH_ADDR, XAXIDMA_DMA_TO_DEVICE);

		if (Status_TX != XST_SUCCESS) {
			return XST_FAILURE;
		}

		while ((XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA)) ||
			(XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE))) {
				/* Wait */
		}

	}
    //      3c: Wait for TX-DMA & RX-DMA to finish
    XTime_GetTime(&postExecCyclesFPGA);

    XTime_GetTime(&preExecCyclesSW);
    // Step 4: Perform SW processing
		
			for(int i=0;i<N;i++){
				for(int j=0;j<N;j++){
					if(i%2==0 && j%2==0)
						fun_g1(i,j);
					else if(i%2==0 && j%2==1)
						fun_b(i,j);
					else if(i%2==1 && j%2==0)
						fun_r(i,j);
					else
						fun_g2(i,j);
				}
			

			printf("RGB\n");
			for(int i=0;i<N;i++){
				for(int j=0;j<N;j++){
					decToBin(0);
					decToBin(R[i][j]);
					//printf("%d", R[i][j]);
					decToBin(G[i][j]);
					//printf("%d",G[i][j]);
					decToBin(B[i][j]);
					//printf("%d", B[i][j]);
					printf("\n");
				}
			}
		}

    XTime_GetTime(&postExecCyclesSW);

    // Step 6: Compare FPGA and SW results
    //     6a: Report total percentage error
    //     6b: Report FPGA execution time in cycles (use preExecCyclesFPGA and postExecCyclesFPGA)
    //     6c: Report SW execution time in cycles (use preExecCyclesSW and postExecCyclesSW)
    //     6d: Report speedup (SW_execution_time / FPGA_exection_time)

    cleanup_platform();
    return 0;
}

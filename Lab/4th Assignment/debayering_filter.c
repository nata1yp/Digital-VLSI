#include<stdio.h>
#include<stdlib.h>
#include "filter_array.h"

#define N 1024

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

int main(){
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
    }

    // printf("R\n");
    // for(int i=0;i<N;i++){
    //     for(int j=0;j<N;j++){
    //         printf("%d ",R[i][j]);
    //     }
    //     printf("\n");
    // }

    // printf("G\n");
    // for(int i=0;i<N;i++){
    //     for(int j=0;j<N;j++){
    //         printf("%d ",G[i][j]);
    //     }
    //     printf("\n");
    // }

    // printf("B\n");
    // for(int i=0;i<N;i++){
    //     for(int j=0;j<N;j++){
    //         printf("%d ",B[i][j]);
    //     }
    //     printf("\n");
    // }

    printf("RGB\n");
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            decToBin(0);
            decToBin(R[i][j]);
            // printf(" ");
            decToBin(G[i][j]);
            // printf(" ");
            decToBin(B[i][j]);
            printf("\n");
        }
    }
}
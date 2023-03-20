// gcc filename.c -o filename
// ./filename

#include<stdio.h>
#include<stdlib.h>

#define N 1024

// using namespace std;


int main(){
    FILE *fout = fopen("filter_array.h", "w");
    fprintf(fout, "int array[%d][%d] = {\n",N,N);
    for(int i=0;i<N;i++){
        fprintf(fout, "{");
        for(int j=0;j<N;j++){
            int num = j%256;
            if(j<N-1)
                fprintf(fout, "%d, ",num);
            else
                fprintf(fout, "%d",num);
        }
        if(i<N-1)
            fprintf(fout, "},\n");
        else
            fprintf(fout, "}\n");
    }
    fprintf(fout, "};");
}

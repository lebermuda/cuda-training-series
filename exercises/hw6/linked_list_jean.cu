#include <cstdio>
#include <cstdlib>

#include <cuda.h>
#include <cuda_runtime.h>
#include <helper_cuda.h>


struct list_elem {
    int key;
    list_elem *next;
};



__global__ void gpu_kernel(double* matrix,int n){
    int i =threadIdx.x+blockDim.x*blockIdx.x;
    int j= threadIdx.y+blockDim.y*blockIdx.y;
    int index = i*n+j;
    matrix[index]=index;
}

void printMatrix(double* matrix){
    int index;
    for (int i = 0;i<num_elem;i++){
        for (int j = 0;j<num_elem;j++){
            index=i*num_elem+j;
            printf("%f ",matrix[index]);
        }
        printf("\n");
    }
}

const int num_elem = 5;
int main(){

    double* matrix ;

    cudaMallocManaged(&matrix,num_elem*num_elem*sizeof(double));


    gpu_kernel<<<5,5>>>(matrix);
    cudaDeviceSynchronize();

    printMatrix(matrix);

    free(matrix);

}

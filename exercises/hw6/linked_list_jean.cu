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

void printMatrix(double* matrix,int n){
    int index;
    for (int i = 0;i<n;i++){
        for (int j = 0;j<n;j++){
            index=i*n+j;
            printf("%f ",matrix[index]);
        }
        printf("\n");
    }
}

void addElement(double* matrix, int n, int i_start,int j_start){
    int index;
    for (int i = i_start;i<n;i++){
        for (int j = j_start;j<n;j++){
            index=i*n+j;
            matrix[index]=1;
        }
    }
}

const int num_elem = 5;
int main(){

    double* matrix ;

    cudaMallocManaged(&matrix,num_elem*num_elem*sizeof(double));

    dim3 dimGrid (1,1,1);
    dim3 dimBlock (num_elem-2,num_elem,1);
    gpu_kernel<<<dimGrid,dimBlock>>>(matrix,num_elem);

    cudaDeviceSynchronize();

    addElement(matrix,num_elem,num_elem-2,0);


    printMatrix(matrix,num_elem);

    cudaFree(matrix);

}

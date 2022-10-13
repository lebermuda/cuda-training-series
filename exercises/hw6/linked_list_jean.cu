#include <cstdio>
#include <cstdlib>

#include <cuda.h>
#include <cuda_runtime.h>
#include <helper_cuda.h>


struct list_elem {
    int key;
    list_elem *next;
};

template <typename T>
void alloc_bytes(T &ptr, size_t num_bytes){

    //ptr = (T)malloc(num_bytes);
    cudaMallocManaged(&ptr,num_bytes);
}

__host__ __device__
void print_element(list_elem *list, int ele_num) {
    list_elem *elem = list;
    for (int i = 0; i < ele_num; i++) {
        elem = elem->next;
        printf("key = %d\n", elem->key);
    }
}

__global__ void gpu_print_element(list_elem *list, int ele_num){
    print_element(list, ele_num);
}
const int ele = 3;



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

//    double* matrix ;
//
//    cudaMallocManaged(&matrix,num_elem*num_elem*sizeof(double));
//
//    dim3 dimGrid (1,1,1);
//    dim3 dimBlock (num_elem-2,num_elem,1);
//    gpu_kernel<<<dimGrid,dimBlock>>>(matrix,num_elem);
//
//    //MARCHE PAS EN PARALLEL
//    //addElement(matrix,num_elem,num_elem-2,0);
//
//    cudaDeviceSynchronize();
//
//    //MARCHE EN SEQUENTIEL
//    //addElement(matrix,num_elem,num_elem-2,0);
//
//
//    printMatrix(matrix,num_elem);
//
//    cudaFree(matrix);

    list_elem *list_base, *list;
    alloc_bytes(list_base, sizeof(list_elem));
    list = list_base;
    for (int i = 0; i < num_elem; i++){
        list->key = i;
        alloc_bytes(list->next, sizeof(list_elem));
        list = list->next;}
    print_element(list_base, ele);
    gpu_print_element<<<1,1>>>(list_base, ele);
    cudaDeviceSynchronize();

    cudaFree(list_base);
}

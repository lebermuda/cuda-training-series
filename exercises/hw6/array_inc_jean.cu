#include <cstdio>
#include <cstdlib>

#include <cuda.h>
#include <cuda_runtime.h>
#include <helper_cuda.h>

template <typename T>
void alloc_bytes(T &ptr, size_t num_bytes){

  ptr = (T)malloc(num_bytes);
}

__global__ void inc(int *array, size_t n){
  size_t idx = threadIdx.x+blockDim.x*blockIdx.x;
  while (idx < n){
    array[idx]++;
    idx += blockDim.x*gridDim.x; // grid-stride loop
    }
}

__global__ void kernel_changeChar(char* data,int index, char caractere){
    data[index]=caractere;
}

const size_t  ds = 32ULL*1024ULL*1024ULL;

int main(){
    char* data;
    cudaMallocManaged(&data,2*sizeof(char));

    kernel_changeChar<<<1,1>>>(data,1,"k");
    data[0]="O";

    //cudaDeviceSynchronize();
    //printf("%d\n",data);

    cudaFree(data);

//    int *h_array;
//    cudaMallocManaged(&h_array, ds*sizeof(d_array[0]));
//
//    memset(h_array, 0, ds*sizeof(h_array[0]));
//
//    inc<<<256, 256>>>(h_array, ds);
//    cudaDeviceSynchronize();
//
//    for (int i = 0; i < ds; i++)
//        if (h_array[i] != 1) {printf("mismatch at %d, was: %d, expected: %d\n", i, h_array[i], 1); cudaFree(h_array); return -1;}
//    printf("success!\n");
//    cudaFree(h_array);
//    return 0;

//  int *h_array, *d_array;
//  alloc_bytes(h_array, ds*sizeof(h_array[0]));
//  cudaMalloc(&d_array, ds*sizeof(d_array[0]));
//  //cudaCheckErrors("cudaMalloc Error");
//  memset(h_array, 0, ds*sizeof(h_array[0]));
//  cudaMemcpy(d_array, h_array, ds*sizeof(h_array[0]), cudaMemcpyHostToDevice);
//  //cudaCheckErrors("cudaMemcpy H->D Error");
//  inc<<<256, 256>>>(d_array, ds);
//  //cudaCheckErrors("kernel launch error");
//  cudaMemcpy(h_array, d_array, ds*sizeof(h_array[0]), cudaMemcpyDeviceToHost);
//  //cudaCheckErrors("kernel execution or cudaMemcpy D->H Error");
//  for (int i = 0; i < ds; i++)
//    if (h_array[i] != 1) {printf("mismatch at %d, was: %d, expected: %d\n", i, h_array[i], 1); return -1;}
//  printf("success!\n");
//  return 0;
}

CC=gcc

CUDA_HOME=/usr/local/cuda
CUDASDK=/usr/local/cuda/samples
CUDANVIDIA=/usr/lib64/nvidia
NVCC=$(CUDA_HOME)/bin/nvcc

NVCFLAGS= -I $(CUDA_HOME)/include -I$(CUDASDK)/common/inc

CFLAGS= -L $(CUDA_HOME)/lib64 -L $(CUDANVIDIA)

linked_list: linked_list.o
	$(NVCC) -arch=sm_35 $(CFLAGS)  -o $@ $^

array_inc: array_inc.o
	$(NVCC) -arch=sm_35 $(CFLAGS)  -o $@ $^

clean:
	rm -f *.o *.linkinfo

%.o: %.cu
	$(NVCC) -arch=sm_35 $(NVCFLAGS) -c -o $@ $<

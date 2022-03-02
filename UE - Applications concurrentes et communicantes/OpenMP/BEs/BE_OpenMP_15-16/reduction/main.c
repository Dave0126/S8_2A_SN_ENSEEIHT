#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "omp.h"
#include "aux.h"

int sequential_reduction(int *x, int n);
int parallel_reduction(int *x, int n);


int main(int argc, char **argv){
  int  n, i, result;
  long t_start, t_end;
  int  *x;
  
  // Command line argument: array length
  if ( argc == 2 ) {
    n = atoi(argv[1]);    /* the length of the pref */
  } else {
    printf("Usage:\n\n ./main n\n\nwhere n is the length of the array to be used.\n");
    return 1;
  }


  x=(int *)malloc(sizeof(int)*n);

  
  /* Fill the array with random numbers */
  srand(1);
  for (i = 0; i < n; i++) 
    x[i] = rand() % n;

  /* Sequential reduction */
  t_start = usecs();
  result = sequential_reduction(x, n);
  t_end = usecs();
  printf("Sequential time : %8.2f msec.  ---  Result: %d\n",((double)t_end-t_start)/1000.0, result);
  



  /* Fill the array with random numbers */
  srand(1);
  for (i = 0; i < n; i++) 
    x[i] = rand() % n;

  /* Parallel reduction */
  t_start = usecs();
  result = parallel_reduction(x, n);
  t_end = usecs();
  printf("Parallel   time : %8.2f msec.  ---  Result: %d\n",((double)t_end-t_start)/1000.0, result);

  
  return 0;
}



int sequential_reduction(int *x, int n){
  int i;

  for(i=1; i<n; i++)
    operator(x, x+i);

  return x[0];
}

int parallel_reduction(int *x, int n) {
    int result;
    #pragma omp parallel num_threads(4)
    {
      #pragma omp single
      {
        result = parallel_reduction_rec(x, n);
      }
    }
    
    return result;
}

int parallel_reduction_rec(int *x, int n){
  int i;

  int half_size = n/2; // 按 *”结合律”与右边相邻的操作数组成一组* 后的数组长度
  int min_op = 2; // 最小的组的个数

  // 当两两结合后的数组长度小于最小的组的个数，即原长度小于4时
  if (half_size < min_op) {
    for(int j=1; j<n; j++)
    operator(x, x+j);
    return x[0]; // 与串行算法相同
  }
/*------------------- 并行区代码(原长度 >= 4)-------------------*/
// 前半段
  #pragma omp task if (half_size >= min_op)
  parallel_reduction_rec(x, half_size); //递归调用

// 后半段
  #pragma omp task if (half_size >= min_op)
  parallel_reduction_rec(x+half_size, n-half_size); //递归调用

// 等待之前的所有的task执行完毕，将 前一半 和 后一半 的结果op
  #pragma omp taskwait
  operator(x, x+half_size);
  
  return x[0];
}


/*
  Result:
  ./main 30 
  Sequential time :   290.00 msec.  ---  Result: 409
  Parallel   time :   290.38 msec.  ---  Result: 409 (1 thread)
  Parallel   time :   150.58 msec.  ---  Result: 409 (2 threads)
  Parallel   time :    90.51 msec.  ---  Result: 409 (4 threads)

  首先，原串行算法不能并行化，因为其只能串行执行，有数据依赖。如下图：

  *串行化*
  X   X   X   X   X   X   X   计算次数
  |---|   |   |   |   |   |   1
  X-------|   |   |   |   |
  |           |   |   |   |   2
  X-----------|   |   |   |
  |               |   |   |   3
  X---------------|   |   |
  |                   |   |   4
  X-------------------|   |
  |                       |   5
  X-----------------------|
  |                           6
  X

  *并行化*  (t代表task)
  X   X   X   X   X   X   X
  |-t-|   |-t-|   |-t-|   |   3
  X       X       X       X
  |---t---|       |---t---|   2
  X               X
  |-------t-------|           1
  X

*/

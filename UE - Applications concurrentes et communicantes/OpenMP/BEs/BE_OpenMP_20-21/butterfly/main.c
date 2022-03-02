#include "aux.h"
#define NUM_THREADS 4

void butterfly_seq(int n, int l, int *array);
void butterfly_par(int n, int l, int *array);

int main(int argc, char **argv){
  long   t_start, t_end;
  int    i, n, l, res;
  int    *array_seq, *array_par;

  if ( argc == 2 ) {
    l = atoi(argv[1]); 
  } else {
    printf("Usage:\n\n ./main l\n\nwhere l defines the size of the array  n=2^l.\n");
    return 1;
  }

  n = pow(2,l);
  
  printf("\nGenerating an array with %d elements\n",n);
  generate_array(n, &array_seq, &res);

  array_par = (int*)malloc(n*sizeof(int));
  for(i=0; i<n; i++)
    array_par[i] = array_seq[i];
    
  if(n<=32){
    printf("array_seq=[");
    for(i=0; i<n; i++){
      printf("%d ",array_seq[i]);
    }
    printf("]\n");
  }
  printf("The expected result is : %d\n\n\n\n",res);

  
  t_start = usecs();
  butterfly_seq(n, l, array_seq);
  t_end = usecs();
  
  printf("Sequential time : %8.2f msec.\n",((double)t_end-t_start)/1000.0);

  if(n<=32){
    printf("The result of the sequential reduction is\n");
    printf("array_seq=[");
    for(i=0; i<n; i++)
      printf("%d ",array_seq[i]);
    printf("]\n");
  }
  printf("\n\n\n");
  
  
  t_start = usecs();
  butterfly_par(n, l, array_par);
  t_end = usecs();
  
  printf("Parallel   time : %8.2f msec.\n",((double)t_end-t_start)/1000.0);
  
  if(n<=32){
    printf("The result of the parallel reduction is\n");
    printf("array_par=[");
    for(i=0; i<n; i++)
      printf("%d ",array_par[i]);
    printf("]\n\n");
  }
  
  check_result(n, array_par, res);
  
}
  
void butterfly_seq(int n, int l, int *array){

  int p, i, j, s;

  p = 0;
  
  while(p<l){
    s = pow(2,p);
    for(i=0; i<n; i+=2*s){
      for(j=0; j<s; j++){
        int r = operator(array[i+j],array[i+j+s]);
        array[i+j]   = r;
        array[i+j+s] = r;
      }
    }
    p+=1;
  }
}




void butterfly_par(int n, int l, int *array){

  int p, i, j, s;

  p = 0;
#pragma omp parallel num_threads(NUM_THREADS)
  {
#pragma omp single
    {
      while(p<l){
        s = pow(2,p);
        for(i=0; i<n; i+=2*s){
          for(j=0; j<s; j++){
#pragma omp task depend(inout:array[i+j], array[i+j+s]) firstprivate(i,j,s)
//depend(inout:array[i+j], array[i+j+s]) : 这两个数组分别作为 1* 中的输入，2*、3*中输出。变量r在task块内定义，不能依赖
//firstprivate(i,j,s) : 不同的线程在执行task块时要继承上一个task块中i,j,s的值
            {
              int r = operator(array[i+j], array[i+j+s]); // 1*
              array[i+j]   = r;                           // 2*
              array[i+j+s] = r;                           // 3*
            }
          }
        }
        p+=1;
      }
    }
  }
}

/*
  如何编译？
  
  1.  更改宏定义中NUM_THREADS的值(1,2,4)
  2.  For Mac(M1 chip): clang -Xpreprocessor -fopenmp -lomp *.c -o main
      For linux:        make main
  3.  ./main 8


  Result:

  (1 thread)
  Generating an array with 256 elements
  The expected result is : 1206
  Sequential time :   102.50 msec.
  Parallel   time :   102.83 msec.
  The result is CORRECT

  (2 threads)
  Generating an array with 256 elements
  The expected result is : 1206
  Sequential time :   102.40 msec.
  Parallel   time :    52.67 msec.
  The result is CORRECT

  (4 threads)
  Generating an array with 256 elements
  The expected result is : 1206
  Sequential time :   102.43 msec.
  Parallel   time :    26.75 msec.
  The result is CORRECT


  分析：
    串行算法的执行时间 和 并行算法的执行时间 中的 并行线程数 有着近似线性的关系。
*/

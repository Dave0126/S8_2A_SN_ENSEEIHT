#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#include <math.h>
#include "aux.h"
#include "omp.h"
#define NUM_THREADS 4

unsigned long sequential_sweep(struct node *head);
unsigned long parallel_for_sweep(struct node *head);
unsigned long parallel_task_sweep(struct node *head);


int main(int argc, char **argv){
  int n, i, s;
  long    t_start, t_end, save;
  int *x;
  unsigned long acc, result;
  struct node *head, *curr;
  
  init_list(&head);
  
  t_start = usecs();
  result = sequential_sweep(head);
  t_end = usecs();
  printf("Sequential      time    : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %5ld\n",result);

  t_start = usecs();
  result = parallel_for_sweep(head);
  t_end = usecs();
  printf("Parallel for time       : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %5ld\n",result);



  t_start = usecs();
  result = parallel_task_sweep(head);
  t_end = usecs();
  
  printf("Parallel task   time    : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %5ld\n",result);
  
  
  return 0;
}


  

unsigned long sequential_sweep(struct node *head){

  unsigned long acc;
  struct node *curr;

  curr = head;
  acc = 0;
  while(curr){
    /* Loop until the last element in the list and accumulate the
       result of nodes processing */
    acc += process_node(curr);
    curr = curr->next;
  }

  return acc;
}
  



unsigned long parallel_for_sweep(struct node *head){
  unsigned long acc;
  struct node *curr;
  unsigned long tmp[100000];

  curr = head;
  acc = 0;
  int i;

/*  并行区域，
    其中共享变量c可以是各个进程间私有的，互不影响；
    而curr和acc必须是共有的，必须互斥访问 */
#pragma omp parallel for num_threads(NUM_THREADS)
  for (i = 0; i < 100000; i++) {
    /* Loop until the last element in the list and accumulate the
       result of nodes processing */
#pragma omp critical
{
  if (curr){
      acc += process_node(curr); 
      curr = curr->next;
    }
    else {
      i=100000;
    }
  }
}


  return acc;
}






  
unsigned long parallel_task_sweep(struct node *head) {
  unsigned long acc;
  struct node *curr;
  
  curr = head;
  acc = 0;
#pragma omp parallel num_threads(NUM_THREADS)
  {
#pragma omp single
    {
      while(curr){
        /* Loop until the last element in the list and accumulate the
          result of nodes processing */
#pragma omp task firstprivate(curr)
        {
#pragma omp atomic update
          acc += process_node(curr);
        }
        curr = curr->next;
      }
    }
  }



  return acc;
}

/*
  如何编译？
  
  1.  更改宏定义中NUM_THREADS的值(1,2,4)
  2.  For Mac(M1 chip): clang -Xpreprocessor -fopenmp -lomp *.c -o main
      For linux:        make main
  3.  ./main

  Result:

              Sequential      time    :   500.15 msec.       -- result: 50005001

  (1 thread)  Parallel for time       :   502.80 msec.       -- result: 50005001
  (1 thread)  Parallel task   time    :   500.87 msec.       -- result: 50005001

  (2 threads) Parallel for time       :   619.99 msec.       -- result: 50005001
  (2 threads) Parallel task   time    :   264.73 msec.       -- result: 50005001

  (4 threads) Parallel for time       :   627.06 msec.       -- result: 50005001
  (4 threads) Parallel task   time    :   139.80 msec.       -- result: 50005001

  分析：
    1. for：  因为在“#pragma omp for”语句中，for循环中迭代器的期待次数是可计算的，所以我们讲愿算法中
              while(curr){TODO;} 改为 for(i=0; i<100000; i++){ if(curr) TODO; else i=100000;}
              而应该互斥的访问curr变量，所以用critical来限制进程间互斥地执行，但是critical的开销很大。

    2. task： task语句可以用于不确定迭代次数的循环中，所以不用对代码做改动。而应该互斥的访问curr变量，
              但是可以使用atomic使开销减小。
*/

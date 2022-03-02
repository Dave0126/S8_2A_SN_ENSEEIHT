#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "omp.h"
#include "aux.h"
#define NIT 1000000
#define NE  10000
#define NUM_THREADS 4

void sequential(int *data);
void parallel_critical(int *data);
void parallel_atomic(int *data);
void parallel_locks(int *data);

int main(int argc, char **argv){
  int    n, i, j, k, nth, thn, cnt;
  long   t_start, t_end, save;
  double s, z, x, y, nx, ny, nz, mz;
  int    data[NE];
  
  /* Initialize data */
  for(i=0; i<NE; i++)
    data[i]=0;
  
  t_start = usecs();
  sequential(data);
  t_end = usecs();
  
  for(cnt=0, i=0; i<NE; i++){
    cnt+=data[i];
  }
  printf("Sequential   time : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %4d\n",cnt);


  /***********************************************************************/
  /***********************************************************************/
  /***********************************************************************/


  for(i=0; i<NE; i++)
    data[i]=0;
  
  t_start = usecs();
  parallel_critical(data);
  t_end = usecs();

  for(cnt=0, i=0; i<NE; i++){
    cnt+=data[i];
  }
  printf("Critical     time : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %4d\n",cnt);


  /***********************************************************************/
  /***********************************************************************/
  /***********************************************************************/


  for(i=0; i<NE; i++)
    data[i]=0;
  
  t_start = usecs();
  parallel_atomic(data);
  t_end = usecs();

  for(cnt=0, i=0; i<NE; i++){
    cnt+=data[i];
  }
  printf("Atomic       time : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %4d\n",cnt);

  
  /***********************************************************************/
  /***********************************************************************/
  /***********************************************************************/


  for(i=0; i<NE; i++){
    data[i]=0;
  }
  
  t_start = usecs();
  parallel_locks(data);
  t_end = usecs();
  
  for(cnt=0, i=0; i<NE; i++){
    cnt+=data[i];
  }
  printf("Locks        time : %8.2f msec.",((double)t_end-t_start)/1000.0);
  printf("       -- result: %4d\n",cnt);
  
  
  return 0;
}


void sequential(int *data){
  int i, j;
  
  for(i=0; i<NIT; i++){
    j = rand() % NE;
    data[j] += func();
  }
}



void parallel_critical(int *data){
  int i, j;
  
  #pragma omp parallel for private(j) num_threads(NUM_THREADS)
  for(i=0; i<NIT; i++){
    j = rand() % NE;
    #pragma omp critical
    data[j] += func();  // critical命令最终会被“翻译”成加锁和解锁的操作，“翻译”也需要时间
                        // 临界区在同一时间只能有一个线程执行它,其它线程要执行临界区则需要排队来执行它
                        // 这时等同于多个线程串行执行...
  }
}
  



void parallel_atomic(int *data){
  int i, j;
  
  #pragma omp parallel for private(j) num_threads(NUM_THREADS)
  for(i=0; i<NIT; i++){
    j = rand() % NE;
    #pragma omp atomic update
    data[j] += func();  // atomic会被翻译成原子操作,比critical的锁操作要快,如果可以的话,尽量用原子操作代替锁操作
                        // 临界区在同一时间只能有一个线程执行它,其它线程要执行临界区则需要排队来执行它
                        // 这时等同于多个线程串行执行...
  }
}


void parallel_locks(int *data){
  int i, j;
  omp_lock_t lock;
  omp_init_lock(&lock);   // 初始化锁

  #pragma omp parallel for private(j) num_threads(NUM_THREADS)
  for(i=0; i<NIT; i++){
    j = rand() % NE;

    omp_set_lock(&lock);  // 上锁
    data[j] += func();    // 锁:主要用于对shared变量的操作,防止出现数据竞争
    omp_unset_lock(&lock);// 解锁
  }
  omp_destroy_lock(&lock);// 销毁锁
}


/*
  如何编译？
  
  1.  更改宏定义中NUM_THREADS的值(1,2,4)
  2.  For Mac(M1 chip): clang -Xpreprocessor -fopenmp -lomp *.c -o main
      For linux:        make main
  3.  ./main

  Result:

              Sequential   time :  1003.59 msec.       -- result: 1000000

  (1 thread)  Critical     time :  1009.62 msec.       -- result: 1000000
  (1 thread)  Atomic       time :  1009.66 msec.       -- result: 1000000
  (1 thread)  Locks        time :  1005.95 msec.       -- result: 1000000

  (2 threads) Critical     time :  1132.03 msec.       -- result: 1000000
  (2 threads) Atomic       time :   502.42 msec.       -- result: 1000000
  (2 threads) Locks        time :  1086.42 msec.       -- result: 1000000

  (4 threads) Critical     time :  1740.98 msec.       -- result: 1000000
  (4 threads) Atomic       time :   250.74 msec.       -- result: 1000000
  (4 threads) Locks        time :  1663.66 msec.       -- result: 1000000
  

  分析：
    在这三种互斥地访问临界区的方法中，
    atomic：    理论上atomic用时最短，实际实验结果与预期相符
    lock：      因为每次访问临界区时都会有“上锁”和“解锁”两种操作，增加系统开销，故时间较慢。
                这种额外开销也会因为并行执行线程的增多而凸显。
    critical：  因为在使用critical时，编译器会将其“翻译”为锁操作(lock)，所以理论上讲，critical操作所用的时间会大于lock，
                而实验结果与理论可验证

  */

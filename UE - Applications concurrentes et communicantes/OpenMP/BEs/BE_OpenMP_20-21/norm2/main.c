#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>
#define NUM_THREADS 1

long usecs (){
  struct timeval t;

  gettimeofday(&t,NULL);
  return t.tv_sec*1000000+t.tv_usec;
}

double dnorm2_seq(double *x, int n);
double dnorm2_par_red(double *x, int n);
double dnorm2_par_red_mutex(double *x, int n);
double dnorm2_par_nored(double *x, int n);


int main(int argc, char *argv[]){

  int n, i;
  double *x;
  double n2_seq, n2_par_red, n2_par_nored;
  long    t_start,t_end;

  
  if(argc!=2){
    printf("Wrong number of arguments.\n Usage:\n\n\
./main n \n\n where n is the size of the vector x whose 2-norm has to be computed.\n");
    return 1;
  }

  
  sscanf(argv[1],"%d",&n);

  
  x = (double*)malloc(sizeof(double)*n);

  for(i=0; i<n; i++)
    x[i] = ((double) rand() / (RAND_MAX));


  printf("\n================== Sequential version ==================\n");
  t_start = usecs();
  n2_seq       = dnorm2_seq(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_seq);

  printf("\n=========== Parallel version with reduction  ===========\n");
  t_start = usecs();
  n2_par_red   = dnorm2_par_red(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par_red);

  printf("\n======== Parallel version with reduction (mutex) ========\n");
  t_start = usecs();
  n2_par_red   = dnorm2_par_red_mutex(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par_red);


  printf("\n========== Parallel version without reduction ==========\n");
  t_start = usecs();
  n2_par_nored = dnorm2_par_nored(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par_nored);


  printf("\n");
  if(fabs(n2_seq-n2_par_red)/n2_seq > 1e-10) {
    printf("The parallel version with reduction is numerically wrong! \n");
  } else {
    printf("The parallel version with reduction is numerically okay!\n");
  }
  
  if(fabs(n2_seq-n2_par_nored)/n2_seq > 1e-10) {
    printf("The parallel version without reduction is numerically wrong!\n");
  } else {
    printf("The parallel version without reduction is numerically okay!\n");
  }
  
  return 0;

}



double dnorm2_seq(double *x, int n){
  int i;
  double res;

  res = 0.0;

  for(i=0; i<n; i++)
    res += x[i]*x[i];

  return sqrt(res);
  
}


/*----------------- func: dnorm2_par_red(double *x, int n) -------------------*/
double dnorm2_par_red(double *x, int n){
  int i;
  double res;

  res = 0.0;
#pragma omp parallel for reduction (+:res) num_threads(NUM_THREADS)
  {
    for(i=0; i<n; i++)
      res += x[i]*x[i];
  }
  return sqrt(res);
}
/*------------------------------------------------------------------------------*/


/*-------------- func: dnorm2_par_red_mutex(double *x, int n) -----------------*/
double dnorm2_par_red_mutex(double *x, int n){
  int i;
  double res;

  res = 0.0;

#pragma omp parallel for num_threads(NUM_THREADS)
    for(i=0; i<n; i++)

//#pragma omp critical          // 互斥地访问临界区，自加操作。也可以用原子操作，如下所示：
#pragma omp atomic update   // 原子操作临界区
      res += x[i]*x[i];
      
  return sqrt(res);
}
/*------------------------------------------------------------------------------*/



/*----------------- func: dnorm2_par_nored(double *x, int n) -------------------*/
double dnorm2_par_nored(double *x, int n){
  int i, iam;
  double res;

  /*  
      在不能用reduction命令时，我们可以先用列表list保存结果，之后再在 循环内 用 列表list的值 供 变量 操作
      这里是两种给列表分配内存大小的方法
  */
  double res_list[omp_get_num_threads()];                                         // 方法1
  //double *res_list = (double*) malloc (sizeof(double)*omp_get_num_threads());   // 方法2

  res = 0.0;

#pragma omp parallel num_threads(NUM_THREADS)
  {
    res_list[omp_get_num_threads()] = 0.0;

#pragma omp for
    for(i=0; i<n; i++)
    res_list[omp_get_thread_num()] += x[i]*x[i];

#pragma omp atomic update
    res += res_list[omp_get_thread_num()];
  }

  return sqrt(res);
}
/*------------------------------------------------------------------------------*/


/*
  如何编译？
  
  1.  更改宏定义中NUM_THREADS的值(1,2,4)
  2.  For Mac(M1 chip): clang -Xpreprocessor -fopenmp -lomp *.c -o main
      For linux:        make main
  3.  ./main 102400000


  Result:
  (1 thread)
  ================== Sequential version ==================
  Time (msec.) :   389.5
  Computed norm is:   5842.633

  =========== Parallel version with reduction  ===========
  Time (msec.) :   352.5
  Computed norm is:   5842.633

  ======== Parallel version with reduction (mutex) ========
  Time (msec.) :   771.7
  Computed norm is:   5842.633

  ========== Parallel version without reduction ==========
  Time (msec.) :   484.5
  Computed norm is:   5842.633

  The parallel version with reduction is numerically okay!
  The parallel version without reduction is numerically okay!


  (2 threads)
  ================== Sequential version ==================
  Time (msec.) :   369.5
  Computed norm is:   5842.633

  =========== Parallel version with reduction  ===========
  Time (msec.) :   186.5
  Computed norm is:   5842.633

  ======== Parallel version with reduction (mutex) ========
  Time (msec.) :  1302.4
  Computed norm is:   5842.633

  ========== Parallel version without reduction ==========
  Time (msec.) :   283.7
  Computed norm is:   5842.633

  The parallel version with reduction is numerically okay!
  The parallel version without reduction is numerically okay!



  (4 threads)
  ================== Sequential version ==================
  Time (msec.) :   376.1
  Computed norm is:   5842.633

  =========== Parallel version with reduction  ===========
  Time (msec.) :    93.2
  Computed norm is:   5842.633

  ======== Parallel version with reduction (mutex) ========
  Time (msec.) :  2922.8
  Computed norm is:   5842.633

  ========== Parallel version without reduction ==========
  Time (msec.) :   206.5
  Computed norm is:   5842.633

  The parallel version with reduction is numerically okay!
  The parallel version without reduction is numerically okay!
*/
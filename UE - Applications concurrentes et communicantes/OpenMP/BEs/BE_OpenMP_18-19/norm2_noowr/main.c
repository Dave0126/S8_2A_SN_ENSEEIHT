#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>

long usecs (){
  struct timeval t;

  gettimeofday(&t,NULL);
  return t.tv_sec*1000000+t.tv_usec;
}

double dnorm2_seq(double *x, int n){
  int i;
  double res, scale, ssq, absxi;

  scale = 0.0;
  ssq   = 1.0;

  for(i=0; i<n; i++){
    if(x[i]!=0.0){
      absxi = fabs(x[i]);
      if(scale < absxi){
        ssq = 1.0 + ssq*pow(scale/absxi,2);
        scale = absxi;
      } else {
        ssq = ssq + pow(absxi/scale,2);
      }
    }
  }

  res = scale*sqrt(ssq);

  return res;
  
}

// TODO
double dnorm2_par(double *x, int n){
  int i;
  double res, scale, ssq, absxi;
  double list_ssq[n], list_absxi[n], list_scale[n];
  list_scale[0] = 0.0;
  list_ssq[0] = 1.0;
#pragma omp parallel for private(i)
  for(i=0; i<n; i++){
    #pragma omp critical
    if(x[i]!=0.0){
      list_absxi[i] = fabs(x[i]);
      if(list_scale[i] < list_absxi[i]){
        {
          list_ssq[i] = 1.0 + list_ssq[i]*pow(list_scale[i]/list_absxi[i],2);
          list_scale[i] = list_absxi[i];
        }
      } else {
        list_ssq[i] = list_ssq[i] + pow(list_scale[i]/list_absxi[i],2);
      }
    }
  }
  res = list_scale[n-1]*sqrt(list_ssq[n-1]);
  

  return res;
  
}



int main(int argc, char *argv[]){

  int n, i;
  double *x;
  double n2_seq, n2_par;
  long    t_start,t_end;

  
  if(argc!=2){
    printf("Wrong number of arguments.\n Usage:\n\n\
./main n \n\n where n is the size of the vector x whose 2-norm has to be computed.\n");
    return 1;
  }

  
  sscanf(argv[1],"%d",&n);

  
  x = (double*)malloc(sizeof(double)*n);

  for(i=0; i<n; i++)
    x[i] = ((double) 500.0 * rand() / (RAND_MAX));


  printf("\n================== Sequential version ==================\n");
  t_start = usecs();
  n2_seq       = dnorm2_seq(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_seq);

  printf("\n\n=========== Parallel version with reduction  ===========\n");
  t_start = usecs();
  n2_par   = dnorm2_par(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par);


  printf("\n\n");
  if(fabs(n2_seq-n2_par)/n2_seq > 1e-10) {
    printf("The parallel version is numerically wrong! \n");
  } else {
    printf("The parallel version is numerically okay!\n");
  }

  
  return 0;


}

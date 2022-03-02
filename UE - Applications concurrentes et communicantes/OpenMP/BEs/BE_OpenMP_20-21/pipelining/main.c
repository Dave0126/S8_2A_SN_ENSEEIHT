#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#include <math.h>
#include "omp.h"
#include "aux.h"
#define NUM_THREADS 1

void pipeline(data *datas, resource *resources, int ndatas, int nsteps);
void pipeline_lock(data *datas, resource *resources, int ndatas, int nsteps);


int main(int argc, char **argv){
  int   n, i, s, d, ndatas, nsteps;
  long  t_start, t_end;
  data *datas;
  resource *resources;

  // Command line arguments
  if ( argc == 3 ) {
    ndatas  = atoi(argv[1]);    /* num of datas */
    nsteps  = atoi(argv[2]);    /* num of steps */
  } else {
    printf("Usage:\n\n ./main ndatas nsteps\n where ndatas is the number of data and nsteps the number of steps.\n");
    return 1;
  }

  init_data(&datas, &resources, ndatas, nsteps);
  
  /* Process all the data */
  t_start = usecs();
  //pipeline(datas, resources, ndatas, nsteps);
  pipeline_lock(datas, resources, ndatas, nsteps);
  t_end = usecs();
  printf("\n\nExecution   time    : %8.2f msec.\n",((double)t_end-t_start)/1000.0);
  
  check_result(datas, ndatas, nsteps);
  
  return 0;
  
}



void pipeline(data *datas, resource *resources, int ndatas, int nsteps){

  int d, s;
  
  // Loop over all the data
  #pragma omp parallel for private(s) num_threads(NUM_THREADS)
  {
    for (d=0; d<ndatas; d++){
    //Loop over all the steps
      for (s=0; s<nsteps; s++){
#pragma omp critical
        process_data(datas, d, s, &(resources[s]));
      }
    }
  }
  
}

void pipeline_lock(data *datas, resource *resources, int ndatas, int nsteps){

  int d, s;
  omp_lock_t lock[nsteps];
  for(s=0; s<nsteps; s++)
    omp_init_lock(lock+s);
  
  // Loop over all the data
  #pragma omp parallel for private(s) num_threads(NUM_THREADS)
  for (d=0; d<ndatas; d++){
  // Loop over all the steps
    for (s=0; s<nsteps; s++){

      omp_set_lock(lock+s);
      process_data(datas, d, s, &(resources[s]));
      omp_unset_lock(lock+s);

    }
  }
  for(s=0; s<nsteps; s++)
  omp_destroy_lock(lock+s);
}

/*
  Result:
  (1 thread)
  (critical)  Execution   time    :  1600.99 msec.
              The result is correct!!!
  (lock)      Execution   time    :  1601.01 msec.
              The result is correct!!!

  (2 threads)
  (critical)  Execution   time    :  1610.02 msec.
              The result is correct!!!
  (lock)      Execution   time    :  826.07 msec.
              The result is correct!!!

  (4 threads)
  (critical)  Execution   time    :  1601.29 msec.
              The result is correct!!!
  (lock)      Execution   time    :   476.13 msec.
              The result is correct!!!     
*/

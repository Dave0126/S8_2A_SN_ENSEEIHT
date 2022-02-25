#include "trace.h"
#include "common.h"
#include <omp.h>


/* This routine performs the LU factorization of a square matrix by
   block-columns */

void lu_par_loop(Matrix A, info_type info){

  int i, j;

  /* Initialize the tracing system */
  trace_init();
  
  for(i=0; i<info.NB; i++){
    
    /* Do the Panel operation on column i */
    panel(A[i], i, info);
    
    /* Parallelize this loop     */
    
    /* CC: this is the most basic way of parallelizing the loop. Note
       that this may be relatively inefficient due to the fact that
       there is a fork and a join at each iteration of the outer
       loop. A better parallelization is provided in the version
       below. 
       
       提示：
       这是并行化循环的最基本方法。 请注意，由于在外循环的每次迭代中都有
       一个 fork 和一个 join，这可能相对低效。 以下版本提供了更好的并行化。*/
#pragma omp parallel for
    for(j=i+1; j<info.NB; j++){
      /* Update column j with respect to the result of panel(A, i) */
      update(A[i], A[j], i, j, info);
    }
  }
  
  /* This routine applies permutations resulting from numerical
     pivoting. It has to be executed sequentially. */
  backperm(A, info);
  
  /* Write the trace in file (ignore) */
  trace_dump("trace_par_loop.svg");
  
  return;
  
}

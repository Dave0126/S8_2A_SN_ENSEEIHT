#include "aux.h"
#include "omp.h"
#define NUM_THREADS 4

int main(int argc, char **argv){
  long    t_start;
  double  time;
  int     i, j, n;
  Stack   stacks[ntypes];
  Request req;
  int     head;
    
  init(stacks);

  t_start=usecs();

#pragma omp parallel num_threads(NUM_THREADS)
{
  #pragma omp single
  {
    for(;;){
    
    #pragma omp task depend(inout:req)
    {
      req = receive();
    }
    
    
    printf("Received request %d\n",req.id);

    if(req.type != -1) {
      
      /* process request and push result on stack */
     printf("Processing request %d\n",req.id);
      #pragma omp task depend(in:req)
    {
      stacks[req.type].results[++stacks[req.type].head] = process(&req);
    }
      
    } else {
      break;
    }
    
  }
  }
 
}


  time=(double)(usecs()-t_start)/1000000.0;
  printf("Finished. Execution time:%.2f \n",time);

  check(stacks);
  
  return 0;
}

/*
  Result:
  (Seq)
  Finished. Execution time:1.05 
  Result is correct :-)

  (Parallel - 2 threads)
  Finished. Execution time:2.04 
  Result is correct :-)

  (Parallel - 4 threads)
  Finished. Execution time:2.27 
  Result is correct :-)
  */

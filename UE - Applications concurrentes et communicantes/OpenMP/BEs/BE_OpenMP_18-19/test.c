#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>

void main(){
    //#pragma omp parallel
    {
        //#pragma omp single
        {
            int i,x;
            int a[10] = {0};
            int b[10] = {0};
            x=2;
            printf("\n一共有 %d 个线程\n",omp_get_num_threads());
            #pragma omp parallel for private(x)
            for(i=0;i<10;i++){
                //#pragma omp task depend(inout:a) depend(out:b)
                //#pragma omp cricital
                {
                    x = a[i] + 1;
                    a[i+1] = x + 1; 
                    b[i+1] = a[i] +1;
                    printf("Hello from Thread %d, a = %d, b = %d\n",omp_get_thread_num(), a[i], b[i]);
                }
                
            }
        }
        
    }
    
}
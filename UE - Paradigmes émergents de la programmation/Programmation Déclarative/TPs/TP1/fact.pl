fact(0,1). 

fact(N,F*N) :-  
   N > 0, 
   N1 is N-1, 
   fact(N1,F).
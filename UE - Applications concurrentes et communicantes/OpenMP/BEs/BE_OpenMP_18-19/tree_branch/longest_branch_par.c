#include "aux.h"


void longest_branch_par(node_t *root, unsigned int *longest_branch_weight, unsigned int *longest_branch_leaf){
#pragma omp parallel
  {
#pragma omp single
    {
      *longest_branch_weight = 0;
      *longest_branch_leaf   = -1;
      root->branch_weight = 0;

      longest_branch_par_rec(root, longest_branch_weight, longest_branch_leaf);
    }
  }
}
  
void longest_branch_par_rec(node_t *root, unsigned int *longest_branch_weight, unsigned int *longest_branch_leaf){

  int i;
  
  process(root);
  root->branch_weight += root->weight;
  
  if(root->nc>0) {
    #pragma omp task
    for(i=0; i<root->nc; i++){
      root->children[i].branch_weight = root->branch_weight;
      longest_branch_par_rec(root->children+i, longest_branch_weight, longest_branch_leaf);
    }
  } else {
    #pragma omp task
    if(root->branch_weight > *longest_branch_weight){
      *longest_branch_weight = root->branch_weight;
      *longest_branch_leaf   = root->id;
    }
  }
}

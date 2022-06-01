module I = Intervals
module C = Congruences
module Produit = NonRelationalProduct.Make (C) (I)

module Reduction = struct
  type t = Produit.t

  (* FONCTION A IMPLEMENTER *) 
  let rho (c, i) = c,i
end

module ProduitReduit = NonRelationalReduction.Make (Produit) (Reduction)

include ProduitReduit
 

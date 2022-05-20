(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
 type t = bool*bool

 (* a printing function (useful for debuging), *)
 let fprint ff x = match x with
   | (true,true) -> Format.fprintf ff "T"
   | (true,false) -> Format.fprintf ff "pair"
   | (false,true) -> Format.fprintf ff "impair"
   | (false,false) -> Format.fprintf ff "⊥"
 (* the order of the lattice. *)
 let order (x_p, x_i) (y_p, y_i) = (y_p || (not x_p) && y_i || (not x_i)) 
 (* and infimums of the lattice. *)

 let top = (true, true)
let bottom = (false, false)

 (* All the functions below are safe overapproximations.
  * You can keep them as this in a first implementation,
  * then refine them only when you need it to improve
  * the precision of your analyses. *)
 
 let join (x_p, x_i) (y_p, y_i) = 
  (x_p || y_p), (x_i || y_i)

 
 let meet (x_p, x_i) (y_p, y_i) =
 (x_p && y_p), (x_i && y_i)
 
 let widening x y = join x y  (* Ok, maybe you'll need to implement this one if your
                       * lattice has infinite ascending chains and you want
                       * your analyses to terminate. *)
 
 let sem_itv a b = assert false(* semantic interval: intervalle entre a et b*)
 (*  if (a < b) then top else 
     if ((a = b) && (a mod 2 = 0)) then (true, false) else 
      if ((a = b) && (a mod 2 = 1)) then (false, true) else
       bottom
 *)
 let sem_plus (xp, xi) (yp, yi) = 
   (xp && yp) || (xi && yi), (xp && yi) || (xi && yp)
 
 let sem_minus (xp, xi) (yp, yi) = 
  (xp && yp) || (xi && yi), (xp && yi) || (xi && yp)
 
 let sem_times (xp, xi) (yp, yi) = 
  (xp && yp) || (xp && yi) || (xi && yp), (xi && yi)
 
 let sem_div (xp, xi) (yp, yi) = 
  top
 
 let sem_guard t = t
 
 let backsem_plus x y r = x, y
 let backsem_minus x y r = x, y
 let backsem_times x y r = x, y
 let backsem_div x y r = x, y
 
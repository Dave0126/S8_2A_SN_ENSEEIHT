(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
 type t = bool*bool

 (* a printing function (useful for debuging), *)
 let fprint ff x = match x with
   | (true,true) -> Format.printf ff ""
   | (true,false) -> Format.printf ff "pair"
   | (false,true) -> Format.printf ff "impair"
   | (false,false) -> Format.printf ff ""
 
 (* the order of the lattice. *)
 let order (x_p, x_i) (y_p, y_i) = (y_p || (not x_p) && y_i || (not x_i)) 
 (* and infimums of the lattice. *)
 let top = ()
 let bottom = ()
 
 (* All the functions below are safe overapproximations.
  * You can keep them as this in a first implementation,
  * then refine them only when you need it to improve
  * the precision of your analyses. *)
 
 let join (x_p, x_i) (y_p, y_i) = 
  match (x_p, x_i) (y_p, y_i) with
   | Bot, _ -> y
   | _, Bot -> x
   | _, Top -> Top
   | Top, _ -> Top
   | Val i, Val j -> if (i=j) then Val i else Top
 
 let meet x y = match x, y with
   | Bot, _ -> Bot
   | _, Bot -> Bot
   | _, Top -> y
   | Top, _ -> x
   | Val i, Val j -> if (i=j) then Val i else Bot
 
 let widening x y = join x y  (* Ok, maybe you'll need to implement this one if your
                       * lattice has infinite ascending chains and you want
                       * your analyses to terminate. *)
 
 let sem_itv a b =
   if a > b then Bot else 
     if a = b then Val a else Top
 
 let sem_plus x y = 
   match x y with
     | Val i, Val j -> Val (i+j)
     | Bot, _ -> Bot
     | _, Bot -> Bot
     | Top, _ -> Top
     | _, Top -> Top
 
 let sem_minus x y = 
   match x y with
     | Val i, Val j -> Val (i-j)
     | Bot, _ -> Bot
     | _, Bot -> Bot
     | Top, _ -> Top
     | _, Top -> Top
 
 let sem_times x y = match x y with
     | Val i, Val j -> Val (i*j)
     | Bot, _ -> Bot
     | _, Bot -> Bot
     | Top, _ -> Top
     | _, Top -> Top
 
 let sem_div x y = match x y with
   | _, Val 0 -> Bot
   | Val i, Val j -> Val (i/j)
   | Bot, _ -> Bot
   | _, Bot -> Bot
   | Top, _ -> Top
   | _, Top -> Top
 
 let sem_guard t = match t with
   | Bot -> Bot
   | Top -> Top
   | Val i -> if i > 0 then Val i else Bot
 
 let backsem_plus x y r = x, y
 let backsem_minus x y r = x, y
 let backsem_times x y r = x, y
 let backsem_div x y r = x, y
 
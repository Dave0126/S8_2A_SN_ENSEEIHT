(*************************************************************************)
(*         Useful functions: use these functions for your work           *)
(*************************************************************************)

(* Compute the greatest common divisor *)
let rec gcd a b =
  if b = 0 then a
  else gcd b (a mod b)

(* Compute the least common multiple. *)
let lcm m n =
  match m, n with
  | 0, _ | _, 0 -> 0
  | m, n -> abs (m * n) / (gcd m n)


(* Compute the euclidian remainder of a / b. Returns a value in [0, b-1] *)
let rem a b =  
  let r = a mod b in
  if r < 0 then r + b else r
    
(* check whether a and b have the same reminder modulo m *)
let eq_cong a b m = (m=0 && a=b) || (m<>0 && (rem a m = rem b m))




(* A congruence domain element is a pair (a,b) in Z x N.
   It denotes the set a Z + b *)
type base_t = Bot | C of (int * int)
type t = base_t
    
let norm t =
  match t with
  | Bot -> t 
  | C(a, b) -> if a = 0 then t else 
      C(abs a, rem b a)

  (* a printing function (useful for debuging), *)
  let fprint ff = function
    | Bot -> Format.fprintf ff "Bot" 
    | C (a,b) -> 
      if a = 0 then 
	Format.fprintf ff "%i" b 
      else if a=1 then
	Format.fprintf ff "Top"
      else
	Format.fprintf ff "%i[%i]" b a

  (* the order of the lattice. *)

  (* FONCTION A IMPLEMENTER *)
  (* To judge the *)
  let order x y =  
    match x,y with
    | C(x1,x2),C(y1,y2) -> (eq_cong x1 0 y1) && (eq_cong x2 y2 y1)
    | _, Bot -> false
    | Bot, _ -> true

  (* and supremums, infimums of the lattice.*)

  (* FONCTION A IMPLEMENTER *)
  (* TOP : 1Z *)
  let top = C(1,0)

  (* FONCTION A IMPLEMENTER *)
  let bottom = Bot

  (* FONCTION A IMPLEMENTER *)    
  let join x y = 
    match x,y with
    | C(x1,x2),C(y1,y2) -> top
    | _, Bot -> x
    | Bot, _ -> y

 (* FONCTION A IMPLEMENTER *)
  let meet x y = 
    match x,y with
    | C(x1,x2),C(y1,y2) -> top
    | _, Bot -> x
    | Bot, _ -> y

  (* No widening available *)
  let widening = join 

  (* FONCTION A IMPLEMENTER *)
  let sem_itv n1 n2 = if n1 > n2 
    then Bot else 
      if (n1 = n2) then C(n1,0) else top

  (* FONCTION A IMPLEMENTER *)
  (* For exemple:
     (2Z + 1) + (2Z + 1)*)
  let sem_plus x y  = 
    match x,y with
    | C(x1,x2),C(y1,y2) -> let pgcd = gcd x1 y1 in C(pgcd, rem (x2 + y2) pgcd)
    | _, Bot -> Bot
    | Bot, _ -> Bot


  (* FONCTION A IMPLEMENTER *)
  let sem_minus x y  = 
    match x,y with
    | C(x1,x2),C(y1,y2) -> let pgcd = gcd x1 y1 in C(pgcd, rem (x2 - y2) pgcd)
    | _, Bot -> Bot
    | Bot, _ -> Bot

  (* FONCTION A IMPLEMENTER *)
  let sem_times x y  = 
    match x,y with
    | C(0,x2),C(0,y2) -> C(0, x2 * y2)
    | C(x1,x2),C(y1,y2) -> C(x1 * y1, x2 * y2)
    | _, Bot -> Bot
    | Bot, _ -> Bot


  (* FONCTION A IMPLEMENTER *)
  let sem_div x y = 
    match x,y with
    | C(x1,x2),C(y1,y2) -> C(x1 mod y1, x2 mod y2)
    | _, Bot -> Bot
    | Bot, _ -> Bot

  let sem_guard = function
    | t -> t

  let backsem_plus x y r = sem_minus r x, sem_minus r y
  let backsem_minus x y r = sem_plus r x, sem_plus r y
  let backsem_times x y r = x, y
  let backsem_div x y r = x, y

(* Local Variables: *)
(* compile-command:"make -C .." *)
(* End: *)

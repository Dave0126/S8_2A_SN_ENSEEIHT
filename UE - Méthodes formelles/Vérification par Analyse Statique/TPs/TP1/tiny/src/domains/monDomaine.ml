(* !!!!! Modify the frist line of `src/analyze.ml`
   to change the domain *)

(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
type t = Bot | Top | Val of int 

(* a printing function (useful for debuging), *)
let fprint ff  = function
  | Bot -> Format.fprintf ff "⊥"
  | Top -> Format.fprintf ff "T"
  | Val i -> Format.fprintf ff "%d" i

(* the order of the lattice. *)
let order x y = match x, y with
  | Bot, _ -> true
  | _, Top -> true
  | Val i, Val j -> i=j
  | _ -> false

(* and infimums of the lattice. *)
let top = Top
let bottom = Bot

(* All the functions below are safe overapproximations.
 * You can keep them as this in a first implementation,
 * then refine them only when you need it to improve
 * the precision of your analyses. *)

let join x y = match x, y with
  | Bot, _ -> y
  | _, Bot -> x
  | _, Top -> Top
  | Top, _ -> Top
  | Val i, Val j -> if i==j then Val i else Top

let meet x y = match x, y with
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | _, Top -> x
  | Top, _ -> y
  | Val i, Val j -> if i==j then Val i else Bot

let widening x y = join x y  (* Ok, maybe you'll need to implement this one if your
                      * lattice has infinite ascending chains and you want
                      * your analyses to terminate. *)

let sem_itv a b =
  if a > b then Bot else 
    if a == b then Val a else Top

let sem_plus x y = 
  match x,y with
    | Val i, Val j -> Val (i+j)
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top

let sem_minus x y = 
  match x,y with
    | Val i, Val j -> Val (i-j)
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top

let sem_times x y = match x,y with
    | Val i, Val j -> Val (i*j)
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top

let sem_div x y = match x,y with
  | _, Val 0 -> Bot
  | Val i, Val j -> Val (i/j)
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | Top, _ -> Top
  | _, Top -> Top

let sem_guard = function
  | Bot -> Bot
  | Top -> Top
  | (Val i) as c -> if i > 0 then c else Bot

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y

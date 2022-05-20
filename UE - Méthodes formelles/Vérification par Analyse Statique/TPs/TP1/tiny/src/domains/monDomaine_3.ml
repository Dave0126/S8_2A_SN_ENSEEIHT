type t = bool*bool*bool (*<0, =0, >0*)

(* and infimums of the lattice. *)
let top = (true, true, true)
let bottom = (false, false, false)

(* a printing function (useful for debuging), *)
let fprint ff  = function
  | bottom -> Format.fprintf ff "⊥"
  | top -> Format.fprintf ff "T"
  | Val i -> Format.fprintf ff "%d" i

(* the order of the lattice. *)
let order x1 y1 = match x1, y1 with
  | bottom, _ -> true
  | _, top -> true
  | Val x, Val y -> x=y
  | _ -> false

(* All the functions below are safe overapproximations.
 * You can keep them as this in a first implementation,
 * then refine them only when you need it to improve
 * the precision of your analyses. *)

let join x y = match x, y with
  | bot, _ -> y
  | _, bot -> x
  | _, top -> top
  | top, _ -> top
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


let sem_plus (n1, z1, p1) (n2, z2, p2) =
  ( n1 || n2,
    (z1 && z2) || (n1 && p2) || (n2 && p1),
    (p1 || p2))

let sem_minus (n1, z1, p1) (n2, z2, p2) =
  ( n1 || n2,
  (z1 && z2) || (n1 && p2) || (n2 && p1),
  (p1 || p2))

let sem_times (n1, z1, p1) (n2, z2, p2) =
  ( (n1 && p2) || (n2 && p1),
    (z1 || z2),
    (n1 && n2) || (p1 && p2)
  )

let sem_div (n1, z1, p1) (n2, z2, p2) =
  ( (n1 && p2) || (n2 && p1),
    (z1 && (n2 || p2)),
    (n1 && n2) || (p1 && p2)
  )

let sem_guard t = match t with
  | Bot -> Bot
  | Top -> Top
  | Val i -> if i > 0 then Val i else Bot

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y

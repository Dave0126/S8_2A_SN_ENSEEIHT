type t = bool*bool*bool (*<0, =0, >0*)

(* and infimums of the lattice. *)
let top = (true, true, true)
let bottom = (false, false, false)

(* a printing function (useful for debuging), *)
let fprint ff  = function
  | (false, false, false) -> Format.fprintf ff "⊥"
  | (true, true, true) -> Format.fprintf ff "T"

(* the order of the lattice. *)
let order x y = match x, y with
  | (xn, xe, xp), (yn, ye, yp) -> if xn then (not yn)
else (if xe then ye || yp else (not yp))


(*
(xn, xe, xp), (yn, ye, yp) -> if xn then (match sem_minus x y with
                                              | (n, e, p) -> n)
else (if xe then ye || yp else (match sem_minus y x with
                                | (n, e, p) -> p))
   *)

(* All the functions below are safe overapproximations.
 * You can keep them as this in a first implementation,
 * then refine them only when you need it to improve
 * the precision of your analyses. *)

let join x y = match x, y with
  | (xn, xe, xp), (yn, ye, yp) -> (xn || yn, xe || ye, xp || yp)

let meet x y = match x, y with
  | (xn, xe, xp), (yn, ye, yp) -> (xn && yn, xe && ye, xp && yp)

let widening x y = join x y  (* Ok, maybe you'll need to implement this one if your
                      * lattice has infinite ascending chains and you want
                      * your analyses to terminate. *)

let sem_itv x y = match x with
  | (xn, xe, xp) -> if xn then (match y with
    | (true, _, _) -> (true, false, false)
    | (_, true, _) -> (true, true, false)
    | (_, _, true) -> (true, true, true)
    ) else if xe then (match y with
      | (true, _, _) -> (false, false, false)
      | (_, true, _) -> (false, true, false)
      | (_, _, true) -> (false, true, true)
) else if xp then (match y with
  | (true, _, _) -> (false, false, false)
  | (_, true, _) -> (false, false, false)
  | (_, _, true) -> (false, false, true)
) else (false, false, false)


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
  | (false, false, false) -> (false, false, false)
  | (true, true, true) -> (true, true, true)

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y

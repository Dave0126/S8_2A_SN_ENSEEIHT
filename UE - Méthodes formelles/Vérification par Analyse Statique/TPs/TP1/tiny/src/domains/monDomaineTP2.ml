type t = Bot | Itv of int option * int option

let fprint ff x = match x with
  |Itv (None, None) -> Format.fprintf ff "]-inf, +inf"
  |Itv (None, (Some n)) -> Format.fprintf ff "]-inf, %d[" n
  |Itv ((Some n), None) -> Format.fprintf ff "]%d, -inf[" n
  |Itv ((Some n1), (Some n2)) -> Format.fprintf ff "]%d, %d[" n1 n2
  |Bot -> Format.fprintf ff "NOOOOOON"

(* Extension de <= a Z U {-oo}. *)
let leq_minf x y = match x, y with
| None, _ -> true (* -oo <= y *)
| _, None -> false (* x > -oo (x != -oo) *)
| Some x, Some y -> x <= y

let min_minf x y = match x, y with
  |None, y -> None (* -oo <= y*)
  |x, None -> x (*x > +oo *)
  |Some x, Some y -> if x <= y then Some x else Some y

(* Extension de <= a Z U {+oo}. *)
let leq_pinf x y = match x, y with
  | _, None -> true (* x <= +oo *)
  | None, _ -> false (* +oo > y (y != +oo) *)
  | Some x, Some y -> x <= y

let max_pinf x y = match x, y with
  |None, y -> y
  |x, None -> None
  |Some x, Some y -> if x >= y then Some x else Some y

let mk_itv o1 o2 = match o1, o2 with
| None, _ | _, None -> Itv (o1, o2)
| Some n1, Some n2 -> if n1 > n2 then Bot else Itv (o1, o2)

let top = Itv (None, None)
let bottom = Bot

let join x y = match x, y with
  |Itv (n1, n2), Itv (n3, n4) -> Itv (min_minf n1 n3, max_pinf n2 n4)
  |Bot, i -> i
  |i, Bot -> i

let meet x y = match x, y with
  |Itv (n1, n2), Itv (n3, n4) -> mk_itv (max_pinf n1 n3) (min_minf n2 n4)



let add_minf x y = match x, y with
  |None, y -> None (* -oo <= y*)
  |x, None -> None (*x > +oo *)
  |Some x, Some y -> Some(x + y)

let sub_minf x y = match x, y with
  |None, y -> None (* -oo <= y*)
  |x, None -> None (*x > +oo *)
  |Some x, Some y -> Some(x - y)

let tim_minf x y = match x, y with
  |None, y -> None (* -oo <= y*)
  |x, None -> None (* x > +oo *)
  |Some x, Some y -> Some(x * y)

let div_minf x y = match x, y with
  |None, b -> None (* -oo <= y*)
  |a, None -> None (*x > +oo *)
  |Some a, Some b -> if Some(b) = Some(0) then None else Some(a / b)


let sem_plus x y = match x, y with
  |Bot, i -> Bot
  |i, Bot -> Bot
  |Itv (n1, n2), Itv (n3, n4) -> Itv (add_minf n1 n3, add_minf n2 n4)

let sem_minus x y = match x, y with
  |Itv (n1, n2), Itv (n3, n4) -> Itv (sub_minf n1 n4, sub_minf n2 n3)
  |Bot, i -> Bot
  |i, Bot -> Bot

let neg_inf x = Option.map ( (-) 0) x

let good_T x = Option.map ( (+) 0) x

let neg x = match x with
|Bot -> Bot
|Itv(a, b) -> Itv(neg_inf b, neg_inf a)

let sem_times x y = match x, y with
  |Itv (n1, n2), Itv (n3, n4) -> join (join (if n2 <= Some(0) then Bot else Itv(tim_minf n2 n3, tim_minf n2 n4))
                                  (if tim_minf n1 n2 <= Some(0) then Itv(Some(0), Some(0)) else Bot))
                                  (if n1 >= Some(0) then Bot else (neg (Itv(tim_minf (neg_inf n1) n3, tim_minf (neg_inf n1) n4))))
  |Bot, i -> Bot
  |i, Bot -> Bot

let sem_div x y = match x, y with
  |Itv (n1, n2), Itv (n3, n4) -> join (join (if n2 <= Some(0) then Bot else (if not (n3 = Some(0) || n4 = Some(0)) then Itv(div_minf n2 n3, div_minf n2 n4) else Bot))
                                  (if tim_minf n1 n2 <= Some(0) then Itv(Some(0), Some(0)) else Bot))
                                  (if n1 >= Some(0) then Bot else (if not (n3 = Some(0) || n4 = Some(0)) then (neg (Itv(div_minf (neg_inf n1) n3, div_minf (neg_inf n1) n4))) else Bot))
  |Bot, i -> Bot
  |i, Bot -> Bot

let sem_guard x = meet x (Itv (Some 1, None))

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y

let order x y = match x, y with
  | Bot, _ -> true
  | _, Bot -> false
  | Itv (n1, n2), Itv (n3, n4) -> leq_minf n3 n1 && leq_pinf n2 n4

let widening x y = match x,y with
|Bot,_ -> y
|_, Bot -> x
|Itv (n1, n2), Itv (n3, n4) -> if (n3 >= n1) then (
  if (n4 <= n2) then Itv (n1, n2) else Itv (n1, None)
) else (
  if (n4 <= n2) then Itv (None, n2) else Itv (None, None)
)

let sem_itv x y = Itv(Some(x), Some(y))
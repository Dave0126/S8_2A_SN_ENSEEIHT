type t = bool*bool*bool (*<0, =0, >0*)

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

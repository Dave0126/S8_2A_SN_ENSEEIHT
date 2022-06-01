(*
 * TINY (Tiny Is Not Yasa (Yet Another Static Analyzer)):
 * a simple abstract interpreter for teaching purpose.
 * Copyright (C) 2012  P. Roux
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)

type base_t = Bot | Itv of InfInt.t * InfInt.t
(* The module Infint extends 32 bits integers with -oo and +oo
 * with some arithmetic operations. *)

type t = base_t

let fprint ff = function
  | Bot -> Format.fprintf ff "⊥"
  | Itv (a, b) -> Format.fprintf ff "%s%s, %s%s"
    (if InfInt.eq a InfInt.minfty then "(" else "[")
    (InfInt.to_string a) (InfInt.to_string b)
    (if InfInt.eq b InfInt.pinfty then ")" else "]")

let order x y = match x, y with
  | Bot, _ -> true
  | _, Bot -> false
  | Itv (a, b), Itv (c, d) -> InfInt.order c a && InfInt.order b d

let top = Itv (InfInt.minfty, InfInt.pinfty)
let bottom = Bot

let join x y = match x, y with
  | Bot, _ -> y
  | _, Bot -> x
  | Itv (a, b), Itv (c, d) -> Itv (InfInt.min a c, InfInt.max b d)

let meet x y = match x, y with
  | Bot, _
  | _, Bot -> Bot
  | Itv (a, b), Itv (c, d) ->
    let e = InfInt.max a c in
    let f = InfInt.min b d in
    if InfInt.order e f then Itv (e, f)
    else Bot

let widening x y = match x, y with
  | Bot, _ -> y
  | _, Bot -> x
  | Itv (a, b), Itv (c, d) ->
    let e = if InfInt.order a c then a else InfInt.minfty in
    let f = if InfInt.order d b then b else InfInt.pinfty in
    Itv (e, f)

let sem_itv n1 n2 =
  if n1 > n2 then Bot
  else Itv (InfInt.fin n1, InfInt.fin n2)

let sem_plus x y = match x, y with
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | Itv (a, b), Itv (c, d) -> Itv (InfInt.add_lb a c, InfInt.add_ub b d)

let sem_minus x y = match x, y with
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | Itv (a, b), Itv (c, d) -> Itv (InfInt.sub_lb a d, InfInt.sub_ub b c)

let sem_times x y = match x, y with
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | Itv (a, b), Itv (c, d) ->
    let e = InfInt.min
      (InfInt.min (InfInt.mul_lb a c) (InfInt.mul_lb b d))
      (InfInt.min (InfInt.mul_lb b c) (InfInt.mul_lb a d)) in
    let f = InfInt.max
      (InfInt.max (InfInt.mul_ub a c) (InfInt.mul_ub b d))
      (InfInt.max (InfInt.mul_ub b c) (InfInt.mul_ub a d)) in
    Itv (e, f)

(* precondition: meet y [0, 0] = ⊥ *)
let sem_div_without_0 x y = match x, y with
  | Bot, _ -> Bot
  | _, Bot -> Bot
  | Itv (a, b), Itv (c, d) ->
    let e = InfInt.min
      (InfInt.min (InfInt.div_lb a c) (InfInt.div_lb b d))
      (InfInt.min (InfInt.div_lb b c) (InfInt.div_lb a d)) in
    let f = InfInt.max
      (InfInt.max (InfInt.div_ub a c) (InfInt.div_ub b d))
      (InfInt.max (InfInt.div_ub b c) (InfInt.div_ub a d)) in
    Itv (e, f)

let sem_div x y =
  let yneg = meet y (Itv (InfInt.minfty, InfInt.fin (-1))) in
  let ypos = meet y (Itv (InfInt.fin 1, InfInt.pinfty)) in
  join (sem_div_without_0 x yneg) (sem_div_without_0 x ypos)

let sem_guard = meet (Itv (InfInt.fin 1, InfInt.pinfty))

let backsem_add_int (a, b) (c, d) (e, f) =
  let min = InfInt.max a (InfInt.sub_lb e d) in
  let max = InfInt.min b (InfInt.sub_ub f c) in
  if InfInt.order min max then Itv (min, max) else Bot

let backsem_plus x y r = match x, y, r with
  | Itv (a, b), Itv (c, d), Itv (e, f) ->
    backsem_add_int (a, b) (c, d) (e, f),
    backsem_add_int (c, d) (a, b) (e, f)
  | _ -> Bot, Bot

let backsem_minus_int (a, b) (c, d) (e, f) =
  let min = InfInt.max a (InfInt.add_lb e c) in
  let max = InfInt.min b (InfInt.add_ub f d) in
  if InfInt.order min max then Itv (min, max) else Bot

let backsem_minus_int' (a, b) (c, d) (e, f) =
  let min = InfInt.max c (InfInt.sub_lb a f) in
  let max = InfInt.min d (InfInt.sub_ub b e) in
  if InfInt.order min max then Itv (min, max) else Bot

let backsem_minus x y r = match x, y, r with
  | Itv (a, b), Itv (c, d), Itv (e, f) ->
    backsem_minus_int (a, b) (c, d) (e, f),
    backsem_minus_int' (a, b) (c, d) (e, f)
  | _ -> Bot, Bot

(* Do we need to be more precise? *)
let backsem_times x y r = match x, y, r with
  | Itv _, Itv _, Itv _ -> x, y
  | _ -> Bot, Bot
let backsem_div = backsem_times

module Reduction : NonRelationalReduction.Reduction with type t = Congruences.t * Intervals.t

include NonRelational.Domain

datatype exp = Constant of int
             | Negate of exp
             | Add of exp*exp
             | Multiply of exp*exp

(* define a fun max_constant : exp -> int that finds the largest Constant *)

fun max_constant (e:exp) : int =
    case e of
        Constant n => n
      | Negate e => max_constant e
      | Add (e1,e2) => let val tl1 = max_constant e1
                           val tl2 = max_constant e2
                       in if tl1 > tl2 then tl1 else tl2
                       end
      | Multiply (e1,e2) => let val tl1 = max_constant e1
                                val tl2 = max_constant e2
                            in if tl1 > tl2 then tl1 else tl2
                            end

val test1 = max_constant (Negate (Constant 13)) = 13

val test2 = max_constant (Add (Negate (Constant (12+2)),
                               (Multiply (Constant 23, Constant 5)))) = 23

(* but it's bad style to have the same block of code again and again,
   so use a helper function that does the computing of max of two exps *)

(* but also, there's a built-in fun that computes the max of two Ints, so let's just use that *)

fun max_constant_better (e:exp) : int =
    case e of
        Constant n => n
      | Negate e => max_constant_better e
      | Add (e1,e2) => Int.max (max_constant_better e1, max_constant_better e2)
      | Multiply (e1,e2) => Int.max (max_constant_better e1, max_constant_better e2)

val test3 = max_constant_better (Negate (Constant 13)) = 13

val test4 = max_constant_better (Add (Negate (Constant (12+2)),
                               (Multiply (Constant 23, Constant 5)))) = 23

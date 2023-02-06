(* Datatypes are useful for...

Enumerations! - *)

datatype suit = Club
						 |  Diamond
						 |  Heart
						 |  Spade

datatype rank = Num of int
              | Jack
              | Queen
              | King
              | Ace

(* one-of is good style *)
datatype id = student_num of int
            | name of string * string option * string

(* each-of is very bad style *)
(* usually people say "use student_num unless it is ~1" or some other bad way of doing one-ofs *)
(*
{student_num : int,
 first       : string,
 middle      : string option,
 last        : string}
*)
(* this gives up all the benefits of pattern matching, mentioned previously *)

(* unless of course, you need to use each-of, in which case use records! *)

(* EXPRESSION TREES (self referential expressions) *)

datatype exp = Constant of int
             | Negate of exp
             | Add of exp*exp
             | Multiply of exp*exp

(* the Negate, Add and Multiply constructors use exp *)
(* so what you would do is construct an exp by passing an Int to Constant
   and use that exp in Negate, Add and Multiply *)

val exp1 = Add (Constant (10+9), Negate (Constant 4))
(* visualize this as a tree, with Constants as the leaves *)

fun eval e =
    case e of
        Constant i => i
      | Negate e => ~ (eval e)
      | Add (e1,e2) => eval (e1) + eval (e2)
   (* | Add e => (eval (#1 e)) + (eval (#2 e)) same as above *)
      | Multiply (e1,e2) => (eval e1) * (eval e2)

(* Negate, Add and Multiply need to be self recursive because ofc e, e1, e2 are exps, not Ints! *)
(* Funs over recursive datatypes are usually recursive! *)

val eval1 = eval (exp1)

(* Write a function that counts the number of Adds in an exp *)

fun countAdds (e:exp) : int =
    case e of
        Constant i => 0
      | Negate e => countAdds e
      | Add (e1,e2) => 1 + countAdds (e1) + countAdds (e2)
      | Multiply (e1,e2) => countAdds (e1) + countAdds (e2)

val countAdds_exp1 = countAdds exp1 = 1

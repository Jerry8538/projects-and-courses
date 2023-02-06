(* case expressions are used to ACCESS datatype values *)

datatype mytype = TwoInts of int*int
                | Str of string
       | Pizza

fun f x = (* we can let ml implicitly figure out the type of x, like it does for f *)
    (* here, x:mytype, f:mytype -> int *)
    case x of
        Pizza => 3
      | Str s => 8 (* s is a variable we bind to the value under Str constructor *)
      | TwoInts(i1,i2) => i1+i2; (* i1 and i2 can be referred to, see above *)

(* we use case expressions to access pieces of a datatype *)

(* NOTE - argument of f MUST be mytype. You can't call f("hi"), you need f (Str "hi") *)

(* This is a multi-branch conditional *)

(* We evaluate the expression b/w case and of, and then pattern match it with the branches *)
(* Here, "matching" means built from the same constructor *)
(* Then we bind variables locally, and evaluate respective expression after => *)

(* general syntax - *)
(*
case e0 of
    p1 => e1
  | p2 => e2
    ...
  | pn => en;
*)

fun g x =
    case x of
        Pizza => "hi"
      | Str s => "str"
   (* | TwoInts(x,x) => x  - doesn't work *)
      | TwoInts(x,y) => x;

(* Why pattern matching is better than something like define-struct -

   0. You can technically write your own functions that check for a pattern like isStr or getValStr
      BUT DON'T DO THAT. It's poor style and you're giving up the powerful features of pattern matching

   1. You can't forget a case, ml warns you
   2. You can't duplicate a case, ml raises an exception
   3. You can't confuse patterns easily
   4. Pattern matching is more general and powerful *)

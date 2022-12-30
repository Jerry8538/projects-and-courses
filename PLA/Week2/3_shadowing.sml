(* Programming Languages, Dan Grossman *)
(* Section 1: Examples to Demonstrate Shadowing *)

val a = 10

val b = a * 2

val a = 5
(* a -> 5, b -> 20 *)

val c = b
(* a -> 5, b -> 20, c -> 20 *)

val d = a

val a = a + 1
(* ..., a -> 6 *)

(* next line does not type-check, f not in environment yet *)
(* val g = f - 3  *)

val f = a * 2

(* Programming Languages, Dan Grossman *)
(* Section 1: Some Errors *)

(* This program has several errors in it so we can try to debug them. *)

val x = 34

val y = x + 1

val z = if y > 0 then 34 else x

(* val q = if y > 0 then 0 *)
val q = if y > 0 then 0 else y

val a = ~5 (* how -5 is written in ML *)

val w = 1

(* val fun = 34 *)
val f = 34 (* fun is a keyword *)

(* val v = x / w *) (* for reals *)
val v = x div w (* for ints *)

(* val fourteen = 7 - 7 *)
val fourteen = 7 + 7

(* if you have a record with the fields as ints, you're basically making a tuple! *)

val a = {3="hi", 1=true, 2=1+4}; (* <=> (true, 5, "hi") *) (* BAD SYNTAX; don't actually do this lmao *)

(* Thus tuples are "syntactic sugar" for records *)
(* syntactic sugar = being able do describe the semantics (evaluation and type rules, etc.) in an easier way *)

(* It's also easier to implement this, since there are fewer semantics to worry about *)

(* another syntactic sugar - andalso & orelse *)
e1 andalso e2;

if e1
then e2
else false;


(* 7-lists *)

(*===============Constructing lists================*)
(* all elements of a list have the same type *)

val mt = [];

val intlist = [4, 5-8, 3]; (* : int list *)

val boollist = [true, false, false]; (* : bool list *)

(* incorrect type:
val both-list = [5, true, 8+8, false]; *)

(* :: is cons *)
val a = 4::mt;

val b = 6::8::mt;

(* lists can have duplicate values *)
val c = 8::b; (* -> [8, 6, 8] *)

(* you can have lists of lists *)
val d = [[1], [2,3]]; (* : int list list *)
(* but all the elements must have the same type *)

(*===============Operating on lists================*)

(*`null list` returns true if list is empty *)
val e = null mt; (* -> true *)

(* `hd list` returns head of non-empty list *)
val f = hd intlist;

(* `tl list` returns tail of non-empty list *)
val g = tl intlist;
val h = tl [2]; (* -> [] *)

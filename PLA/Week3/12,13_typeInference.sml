(* these can type check without type annotations, because it is possible to figure out what
   the types are here *)
fun sum_triple1 (x,y,z) =
    x+y+z

fun full_name1 {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " ^ z

(* these won't type check without type annotations, since ml can't figure out how many
   elements there are in the tuple for example.
   It can't make sure there isn't a 4th element, or a 4th field in the record *)
fun sum_triple2 triple =
    #1 triple + #2 triple + #3 triple

fun full_name2 r =
    #first r ^ " " ^ #middle r ^ " " ^ #last r

(* GENERALITY OF TYPES *)
(*
The type
    'a * 'a -> 'a
can replace (is more general than)
    string * string -> string
    int * int -> int
but can't replace (is not more general than)
    int * string -> int
because here 'a becomes int AND string, which isn't possible.
*)

(* As long as you replace the type variables CONSISTENTLY, it's okay *)

(*
{quux:'b, bar:int * 'a, baz:'b}
is more general than
{quux:string, bar:int*int, baz:string}

but both are fine! *)

(* EQUALITY TYPES *)
(* ''a is an equality type, on which the = operator can be used.
   ints, strings, tuples... are equality types, but funs and reals are not. *)

(* ''a * ''a -> string *)
fun same(x,y) =
    if x=y then "yes" else "no"

(* so far we've only used pattern matching is on one-of types,
   but it works for tuples and records too! *)

(* bad style *)
fun sum_triple triple =
    case triple of
        (x,y,z) => x+y+z

fun full_name r =
    case r of
        {first=x, middle=y, last=z} =>
        x ^ " " ^ y ^ " " ^ z

(* better style *)
(* val-binding can also use a pattern! Variables are just one kind of pattern *)
fun sum_triple triple =
    let val (x,y,z) = triple
    in
        x+y+z
    end

fun full_name r =
    let val {first=x, middle=y, last=z} = r
    in
        x ^ " " ^ y ^ " " ^ z
    end
(* this is semantically identical to one-branch case exps. *)

(* BEST STYLE *)
(* function arguments can also be patterns! *)
fun sum_triple_best (x,y,z) =
    x+y+z

fun full_name_best {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " ^ z

val example1 = sum_triple_best (4,5,6)
(* passing three arguments is the same as passing a triple!!! *)

(* all functions only take ONE argument: a tuple *)

(* something you can't do in java or python, cause funs don't take tuples there *)
fun rotate_left (x,y,z) = (y,z,x)

val example2 = sum_triple_best (rotate_left (3,4,5))

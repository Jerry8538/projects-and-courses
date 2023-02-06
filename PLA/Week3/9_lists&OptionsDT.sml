(* HTC moment *)
(* this is a singly linked list *)
datatype myIntList =
         Empty
       | Cons of int*myIntList

val l1 = Cons (1, Cons (2, Cons (3, Cons (4, Empty))))
val l2 = Cons (5, Cons (6, Empty))
val l3 = Cons (1, (Cons (2, Cons (3, Cons (4, Cons (5, Cons (6, Empty)))))))

fun append (xs : myIntList, ys : myIntList) : myIntList =
    (* appends 2 to the end of 1 *)
    case xs of
        Empty => ys
      | Cons (x,xs') => Cons (x, append (xs', ys)) (* xs' = "xs prime" *)

val test1a = append (l1, l2) = l3

(* Now for Options *)
(* "A tiny little truth: " NONE and SOME are constructors!! *)

fun incOrZero intoption =
    case intoption of
        NONE => 0
      | SOME i => i+1

(* Now for Lists *)

fun append (xs,ys) : list =
    case xs of
        [] => ys
      | x::xs' => x :: append (xs', ys)

(* holy shit [] and :: are constructors too *)
(* use case exps from now on *)

(* So why do null, tl, etc. still exist??
   - For passing as arguments to other functions (next week)
   - Sometimes convenient *)

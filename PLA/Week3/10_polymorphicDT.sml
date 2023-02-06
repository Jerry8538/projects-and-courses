(* Defining Polymorphic Datatypes *)

fun append (xs, ys) =
    case xs of
        [] => ys
      | x :: xs' => x :: append (xs', ys)

(* list is not a type. 'a list is a type *)
(* Functions need not be polymorphic - *)
type sum_list = int list -> int (* needs to be ints cause addition *)
(* type append = 'a list * 'a list -> 'a list (* [this is polymorphic] *) *)
(* doesn't need to be any specific type of list => can be 'a list *)

(* We can set one or more type variables before datatype name *)
datatype 'a option = NONE
                   | SOME of 'a

datatype 'a mylist = Empty
                   | Cons of 'a * 'a mylist

(* A binary tree with leaves having one datatype and internal nodes having another.
   The types can be the same, or different *)
datatype ('a, 'b) tree = Leaf of 'b
                       | Node of 'a
                                 * ('a, 'b) tree (* left subtree *)
                                 * ('a, 'b) tree (* right subtree *)

(* sumTree - Adds every element of tree *)
fun sumTree (tr : (int,int) tree) : int =
    case tr of
        Leaf i => i
      | Node (i,lft,rgt) => i + sumTree lft + sumTree rgt

val test1a = sumTree (Leaf 5) = 5
val test1b = sumTree (Node (7, Leaf 4, Node (9, Leaf 8, Leaf 10))) = 38

(* Now for a fn that has cooler types -
   sumLeaves - Only add up the leaves *)
fun sumLeaves (tr : ('a,int) tree) : int =
    case tr of
        Leaf i => i
      | Node (i,lft,rgt) => sumLeaves lft + sumLeaves rgt

val test2a = sumLeaves (Leaf 6) = 6
val test2b = sumLeaves (Node (10, Leaf 4, Leaf 2)) = 6
(* Node element doesn't HAVE to be int! *)
val test2c = sumLeaves (Node ("hi", Leaf 4, Leaf 2)) = 6

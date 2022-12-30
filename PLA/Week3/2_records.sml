(* records are a collection of expressions in curly brackets
   - records have NO ORDER
     (but they are shown in alphabetical order)
   - it isn't necessary to declare the type of records, but you can, the regular way *)

val my_prof = {id=1, name="Prof. Dan"} : {id:int, name:string};

(* created a record with id and name as fields and specified the type *)

(* We can retrieve values like Python dicts *)

val name = #name my_prof;

(* Note - The type checker can statically verify whether a field exists in a record *)
(* #h {f=1, g=2} *) (* Type error *)

(* In ml, tuples and records are very similar, but -
   - If you have elements ordered by fields, records are better
   - If you have elements ordered by position, tuples are better *)

(* Note -
   ml (and most other) functions are like a hybrid of these uses.
   fn (a, b)
   When you call a fun, you order the arguments by position inside the brackets.
   But when you use them inside the fun, you have a name for the arguments *)

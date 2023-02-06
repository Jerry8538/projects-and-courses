(* a new way of making one-of types *)

datatype mytype = TwoInts of int*int
                | Str of string
                | Pizza;

(* This adds
   - a new type mytype to the environment
   - constuctors TwoInts, Str, Pizza
     A constructor is a function that outputs values of the new type, or it is a value of new type
     TwoInts : int*int -> mytype
     Str : string -> mytype
     Pizza : mytype *)

(* This is a one-of type. mytype is either TwoInts, Str, or Pizza *)

val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(1+3,9);

(* any value of mytype is made up of one of these constructors.
   The value contains - a "tag" to show which constructor
                      - the data *)

(* Pizza is both the tag and the value *)

(* ACCESSING DATATYPE VALUES - *)

(* We need to be able to check the tag, and access the data.
   Other one-of types like lists and options have null and isSome to check tags, and hd, tl, valOf to access data. *)

(* ml doesn't have stuff like isStr and getStrData, it does something better! (Nice hook, Prof. Dan) *)

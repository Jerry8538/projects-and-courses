(* a type synonym is just another name for an already existing type *)

datatype suit =
         Club
       | Diamond
       | Heart
       | Spade

datatype rank =
         Num of int
       | Jack
       | Queen
       | King
       | Ace

(* so let's say we want to represent a card as a suit * rank tuple *)
type card = suit * rank (* we can just create a type synonym for that tuple! *)
(* type card is interchangeable with suit*rank *)

(* we can also assign any arbitrary type a name *)
type name_record = { student_num : int option,
                     first : string,
                     middle : string,
                     last : string }

(* so now if we wanna make a name_record... *)
val me : name_record = { student_num = NONE,
                         first = "deez",
                         middle = "H",
                         last = "nuts" }
(* ... we can easily make sure the type is right, both here and in the REPL *)

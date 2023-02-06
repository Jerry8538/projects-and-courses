(* this is probably what it looks like in ml *)
fun hd xs =
    case xs of
        [] => raise List.Empty
      | x::_ => x

exception MyUndesirableCondition
(* also we can return some data when exception is raised *)
exception OtherException of int*int
(* raise OtherException (3,4) *)

(* type of all exceptions is exn. We can pass them as arguments *)
fun maxlist (xs, ex:exn) : int =
(* output of fun is still int cause nothing is returned when an exception is raised *)
    case xs of
        [] => raise ex (* maxlist shouldn't be called with [] *)
      | x::[] => x
      | x::xs' => Int.max (x,maxlist (xs',ex))

(* handling exceptions *)

(* e1 handle ex => e2
   evaluates e1; if e1 raises ex => return e2
                 else return e1 *)
val h1 = maxlist ([], MyUndesirableCondition)
         handle MyUndesirableCondition => 42
(* h1 = 42 *)

(* Exceptions are a lot like datatype constructors!
   When you declare an exception, you're just adding a constructor for type exn.
   Also, handle can pattern match exceptions *)

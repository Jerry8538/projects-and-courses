fun fact n =
    let fun helper (n,rsf) =
            (* rsf is the fact so far *)
            if n=1
            then rsf
            else helper (n-1, n*rsf) (* we're only RETURNING the result of fun call *)
                                     (* no operations are done on it *)
    in
        helper (n,1)
    end

val test1a = fact 3 = 6

(* The tail calls are treated a bit differently, since we don't do anything to them.
   ml pops the caller before the call, instead of building up a stack *)

(* Implementing Tail Recursion *)
(* Three steps -
   1 - Create helper function that takes an acc
   2 - original base case -> default value of acc
   3 - final value of acc -> new base case *)

fun sum xs =
    let
        fun helper (xs,rsf) =
            (* rsf is the sum so far *)
            case xs of
                [] => rsf
              | x::xs' => helper (xs', x+rsf)
    in
        helper (xs, 0)
    end

val test2a = sum [1,2,3] = 6

fun rev xs =
    let
        fun helper (xs, rsf) =
            (* rsf is the reversed list so far *)
            case xs of
                [] => rsf
              (* puts element farther "in" recursion to the front of the result *)
              | x::xs' => helper (xs', x::rsf)
    in
        helper (xs,[])
    end

(* Places you SHOULDN'T use Tail Recursion *)

(* Sometimes recursive functions can't be evaluated in a constant amount of stack.
   Trees are one example, where you should ideally just use a natural recursive approach.
   There, you can get one recursive tail call, but it's rarely worth it. *)

(* Beware premature optimization. Sometimes readable code is worth the extra processing. *)


(* A recursive definition of tail position *)

(* - In fun f p = e, the body e is in tail position
   - If 'if e1 then e2 else e3' is in tail position, so are e2 and e3
   - If 'let b1 ... bn in e end' is in tail position, e is, but local bindings b1 ... bn are not
   - Arguments of a function are not in tail position cause the function is evaluated
     after evaluating the arguments *)

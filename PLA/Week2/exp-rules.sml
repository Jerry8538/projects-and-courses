val abs_of_5 = if 5 < 0
	       then 0 - 5 else 5;

(* If expression -

   syntax: if e1 then e2 else e3
           where if, then and else are keywords and
           e1, e2 and e3 are subexpressions

   type-checking:
    e1 must be type bool
    e2 and e3 can be any type t, but they must both be type t
    the type of the if exp. is t

   evaluation:
    first evaluate e1 to a value v1,
    if v1 is true, evaluate e2, making it the result of the if expression
    else, evaluate e3, making it the result of the if expression *)

5 < 0;

(* less-than expression rules -

   syntax:
    e1 < e2,
    where < is a keyword, and
    e1 and e2 are subexpressions

   type-checking:
    e1 and e2 must be type int, and
    the value of the less-than exp. is bool

   evaluation:
    evaluate e1 and e2 to v1 and v2, and
    result is true/false based en whether v1 < v2 *)

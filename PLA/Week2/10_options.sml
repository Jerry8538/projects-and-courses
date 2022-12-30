
(* 11_options *)

(* int list -> int option *)
fun max1 (xs : int list) =
    if null xs
    then NONE
    else
	let
	    val tl_ans = max1 (tl xs)
	in
	    if isSome tl_ans andalso valOf tl_ans > hd xs
	    then tl_ans
	    else SOME (hd xs)
	end

(* another way that is more of the "this was added onto the original fun to sanitize its input" *)

fun max2 (xs : int list) =
    if null xs
    then NONE
    else
	let
	    (* xs can't be empty *)
	    fun max_non_empty (xs : int list) =
		if null (tl xs)
		then hd xs
		else
		    let val tl_ans = max_non_empty (tl xs)
		    in
			if hd xs > tl_ans
			then hd xs
			else tl_ans
		    end
	in
	    SOME (max_non_empty xs)
	end
	    

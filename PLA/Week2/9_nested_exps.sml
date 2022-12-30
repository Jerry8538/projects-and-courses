
(* 10_nested_exps *)

fun countup_from1 (x : int) =
    let
	fun count (from : int) =
	    if from = x
	    then x :: []
	    else from :: count (from+1)
    in
	count (1)
    end

val test_cf1 = countup_from1 5 = [1, 2, 3, 4, 5]

(* Minimizing computation using let exps. *)

fun bad_max (xs : int list) =
    if null xs
    then 0
    else
	if (hd xs) > (bad_max (tl xs))
	then hd xs
	else bad_max (tl xs)

val test_bad_max = bad_max [4, 0, ~8, 7, 3] = 7

fun countup (from : int, to : int) =
    if from=to
    then to::[]
    else from :: countup (from+1,to)
			
fun countdown (from : int, to : int) =
    if from=to
    then to::[]
    else from :: countdown (from-1,to)

(* val long_test_bm = bad_max (countup (1, 30)) *)
(* Here, at each element of the list, bad_max is called twice for the rest of the elements,
(in the if and else expressions) *)
			   
(* An efficient version! *)

fun good_max (xs : int list) =
    (* base case always comes first *)
    if null xs
    then 0
    else
	let
	    (* remember, this is non-base case *)
	    val tl_ans = good_max (tl xs)
	in
	    if hd xs > tl_ans
	    then hd xs
	    else tl_ans
	end
	    
val long_test_gm = good_max (countup (1, 30))


(* hw1 *)

(* date is a triple, interp. as (year, month, day) *)

(* 1 *)
fun is_older (dt1 : int*int*int, dt2 : int*int*int) =
    if #1 dt1 = #1 dt2
		   
    then if #2 dt1 = #2 dt2
	 then #3 dt1 < #3 dt2
			  
	 else #2 dt1 < #2 dt2
    else #1 dt1 < #1 dt2

(* 2 *)
fun number_in_month (dts : (int*int*int) list, m : int) =
    if null dts
    then 0
    else
	if #2 (hd dts) = m
	then 1 + number_in_month (tl dts, m)
	else number_in_month (tl dts, m)

(* 3 *)
fun number_in_months (dts : (int*int*int) list, ms : int list) =
    if null ms
    then 0
    else number_in_month (dts, hd ms) + number_in_months (dts, tl ms)
							 
(* 4 *)
fun dates_in_month (dts : (int*int*int) list, m : int) =
    if null dts
    then []
    else
	if #2 (hd dts) = m
	then hd dts :: dates_in_month (tl dts, m)
	else dates_in_month (tl dts, m)
			    
(* 5 *)			    
fun append (xs : (int*int*int) list, ys : (int*int*int) list) =
    if null xs
    then ys
    else hd xs :: append (tl xs, ys)

fun dates_in_months (dts : (int*int*int) list, ms : int list) =
    if null ms
    then []
    else append (dates_in_month (dts, hd ms), dates_in_months (dts, tl ms))

(* 6 *)
fun get_nth (strs : string list, n : int) =
    if n = 1
    then hd strs
    else get_nth (tl strs, n - 1)
		 
(* 7 *)
fun date_to_string (dt : int*int*int) =
    let
	val ms = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	val m = get_nth (ms, #2 dt)
	val d = Int.toString (#3 dt)
	val y = Int.toString (#1 dt)
    in
	m ^ " " ^ d ^ ", " ^ y
    end
	
(* 8 *)
fun number_before_reaching_sum (sum : int, ints : int list) =
    let
	fun helper (ints : int list, ssf : int) =
	    (* ssf is the sum_so_far *)
	    if null ints
	    then 0
	    else
		if hd ints + ssf < sum
		then 1 + helper (tl ints, hd ints + ssf)
		else 0
    in
	helper (ints, 0)
    end

(* 9 *)
fun what_month (d : int) =
    let
	(* dipm is days in prev month *)
	val dipm = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
    in
	number_before_reaching_sum (d, dipm)
    end
	
(* 10 *)
fun month_range (d1 : int, d2 : int) =
	    if d1 > d2
	    then []
	    else what_month d1 :: month_range (d1+1, d2)

(* 11 *)
fun oldest (dts : (int*int*int) list) =
    if null dts
    then NONE
    else
	let
	    (* Assume: dts is not null *)
	    fun helper (dts : (int*int*int) list) =
		if null (tl dts)
		then hd dts
		else
		    let val tl_ans = helper (tl dts)
		    in
			if is_older(hd dts, tl_ans)
			then hd dts
			else tl_ans
		    end

	in
	    SOME (helper dts)
	end
	    
(* 12 *)
fun not_in (x : int, xs : int list) =
    if null xs
    then true
    else
	if x = hd xs
	then false
	else not_in (x, tl xs)
		    
fun remove_dupes (ints : int list) =
    if null ints
    then []
    else
	if not_in (hd ints, tl ints)
	then hd ints :: remove_dupes (tl ints)
	else remove_dupes (tl ints)
				  
fun number_in_months_challenge (dts : (int*int*int) list, ms : int list) =
    number_in_months (dts, remove_dupes ms)
    
fun dates_in_months_challenge (dts : (int*int*int) list, ms : int list) =
    dates_in_months (dts, remove_dupes ms)

(* 13 *)
fun reasonable_date (dt : int*int*int) =
    let
	fun is_positive (dt : int*int*int) =
	    #1 dt > 0 andalso #2 dt > 0 andalso #3 dt > 0
							    
	fun valid_month (dt : int*int*int) =
	    #2 dt <= 12

	fun valid_day (dt : int*int*int) =
	    let
		(* ldim is last day in month *)
		val ldim = [31,28,31,30,31,30,31,31,30,31,30,31]
		val ldim_leap = [31,29,31,30,31,30,31,31,30,31,30,31]

		fun get_nth_int (ints : int list, n : int) =
		    if n = 1
		    then hd ints
		    else get_nth_int (tl ints, n - 1)

		fun is_leap (y : int) =
		    (y mod 400 = 0) orelse (y mod 4 = 0 andalso y mod 100 <> 0)
	    in
		if is_leap (#1 dt)
		then
		    #3 dt <= get_nth_int (ldim_leap, #2 dt)
		else
		    #3 dt <= get_nth_int (ldim, #2 dt)
	    end
    in
	is_positive dt andalso valid_month dt andalso valid_day dt
    end

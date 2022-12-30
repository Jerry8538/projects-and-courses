use "hw1.sml";
(* hw1_tests *)

(* Simple tests *)

val test1 = is_older ((1,2,3),(2,3,4)) = true
					     
val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1

val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

(* My Tests *)

(* is_older *)

val test1a = is_older ((1,2,3), (1,2,3)) = false
val test1b = is_older ((2,1,3), (1,2,3)) = false
val test1c = is_older ((1,2,3), (1,1,3)) = false
val test1d = is_older ((1,2,3), (1,2,2)) = false

val test1e = is_older ((1,1,3), (1,2,3)) = true
val test1f = is_older ((1,2,3), (1,2,4)) = true;

(* number_in_month *)

val test2a = number_in_month ([(5,3,1), (1,5,1), (3,5,1)], 5) = 2;

val test_append = append ([(1,2,3)], [(4,5,6), (7,8,9)]) = [(1,2,3), (4,5,6), (7,8,9)]

(* Challenge Problems *)

(* 12 *)
val test12a = number_in_months_challenge ([(1,3,1), (1,2,1), (1,5,1)], [3, 3, 2]) = 2

val test12b = dates_in_months_challenge ([(1,3,1), (1,2,1), (1,5,1)], [3,3,2]) = [(1,3,1), (1,2,1)]

(* 13 *)

(* positive? *)
val test13aa = (reasonable_date (~1,1,1)
	       orelse reasonable_date (1,~1,1)
	       orelse reasonable_date (1,1,~1)
	       orelse reasonable_date (1,0,1)) = false
						    
val test13ab = reasonable_date (1,1,1) = true

(* valid_month? *)
val test13b = reasonable_date (1,13,1) = false

(* valid_day? *)
val test13c = reasonable_date (1,2,31) = false

(* valid_leap_day? *)
val test13da = (reasonable_date (2022,2,29)
		orelse reasonable_date (1900,2,29)
		orelse reasonable_date (2024,2,30)) = false
					     
val test13db = (reasonable_date (2024,2,29) andalso reasonable_date (2000,2,29)) = true
										       

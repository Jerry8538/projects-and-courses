
(* Our first program*)

val x = 34; (* sets x to an int, 34 *)
(* static env.: x : int *)
(* dynamic env.: x --> 34 *)

val y = 17;

val z = (x + y) + (y + 2);

val abs_of_z = if z < 0
	       then 0 - z else z; (* must have same type, because abs_of_z can only have one type *)

val abs_of_z_simpler = abs z; (* same as abs(z) *)

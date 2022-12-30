(* Programming Languages, Dan Grossman *)
(* Section 1: simple functions *)

(* this function correct only for y >= 0 *)
fun pow (x:int, y:int) = 
    if y=0
    then 1
    else x * pow(x,y-1)

fun cube (x:int) =
    pow(x,3)

val sixtyfour = cube(4)

val fortytwo = pow(2,2+2) + pow(4,2) + cube(2) + 2

(* very nice, now let's see it tail recursive *)
fun pow_tr_helper (x:int, y:int, rsf:int) =
    if y=0
    then rsf
    else pow_tr_helper(x, y-1, x*rsf)

fun pow_tr (x:int, y:int) =
    pow_tr_helper(x, y, 1)

fun cube_tr (x:int) =
    pow_tr (x, 3)

val sixtyfour_tr = cube_tr(4)

val fortytwo_tr = pow_tr(2,2+2) + pow_tr(4,2) + cube_tr(2) + 2

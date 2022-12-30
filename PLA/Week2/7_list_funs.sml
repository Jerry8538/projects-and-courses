
(* list_functions *)

fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list(tl xs);

fun list_product (xs : int list) =
    if null xs
    then 1
    else hd xs * list_product(tl xs);

fun countdown (x : int) = (* countdown 7 -> [7, 6, 5, 4, 3, 2, 1] *)
    if x = 0
    then []
    else x::countdown(x-1);

fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else hd xs :: append(tl xs, ys);

(* functions over pairs of lists *)

fun sum_pair_list (xs : (int * int) list) =
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list (tl xs);

fun firsts (xs : (int * int) list) =
    if null xs
    then []
    else #1 (hd xs) :: firsts (tl xs);

val test_list = [(3, 4), (5, 6)]

val test_firsts = firsts test_list = [3, 5];

fun seconds (xs : (int * int) list) =
    if null xs
    then []
    else #2 (hd xs) :: seconds(tl xs);

fun sum_pair_list2 (xs : (int * int) list) =
    sum_list (append (firsts xs, seconds xs));

val test_spl2 = sum_pair_list2 test_list = 18;

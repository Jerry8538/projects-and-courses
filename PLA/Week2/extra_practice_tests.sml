use "extra_practice.sml";

(* extra_practice_tests *)

(* 1 *)
val test1 = alternate [1,2,3,4] = ~2;
			  
(* 2 *)
val test2a = min_max [1] = (1,1)
val test2b = min_max [1,3,5,~3] = (~3,5)

(* 3 *)
val test3 = cumsum [1, 3, ~3] = [1, 4, 1]

(* 4 *)				    
val test4a = greeting (SOME "Jerry8538") = "Hello there, Jerry8538!"
val test4b = greeting NONE = "Hello there, you!"

(* 5 *)
val test5 = repeat ([1,2,3], [1,0,1]) = [1,3]

(* 6 *)
val test6a = addOpt (NONE, SOME 2) = NONE
val test6b = addOpt (SOME 4, SOME 1) = SOME 5

(* 7 *)
val test7a = addAllOpt [NONE, NONE] = NONE
val test7b = addAllOpt [NONE, SOME 4, SOME 5, NONE] = SOME 9

(* 8 *)
val test8a = any [false, false] = false
val test8b = any [false, true, false] = true

(* 9 *)
val test9a = all [false, true, true] = false
val test9b = all [true, true] = true

(* 10 *)
val test10a = zip ([1,2,3], [4,6]) = [(1,4), (2,6)]
val test10b = zip ([], [1,2,3]) = []

(* 11 *)
val test11a = zipRecycle ([], [1,2,3]) = []
val test11b = zipRecycle ([1,2], [1,2,3]) = [(1,1), (2,2), (1,3)]
val test11c = zipRecycle ([1,2], [1]) = [(1,1), (2,1)]

(* 12 *)
val test12a = zipOpt ([1],[1,2]) = NONE
val test12b = zipOpt ([1,2],[1,2]) = SOME [(1,1),(2,2)]
val test12c = zipOpt ([],[]) = SOME []

(* 13 *)
val test13a = lookup ([("a",1),("b",2),("c",3)], "d") = NONE
val test13b = lookup ([("a",1),("b",2),("c",3)], "b") = SOME 2

(* 14 *)
val test14a = splitup [1,4,~6,3,~2] = ([1,4,3],[~6,~2])

(* 15 *)
val test15a = splitAt ([1,4,~6,3,~2], 2) = ([4,3],[1,~6,~2])
val test15b = splitAt ([6,4,3,8,9,12,7],5) = ([6,8,9,12,7],[4,3]);

(* 16 *)
val test16a = isSorted [] = true
val test16b = isSorted [1,2,3] = true
val test16c = isSorted [1,3,2] = false;

(* 17 *)
val test17a = isAnySorted [] = true
val test17b = isAnySorted [1] = true
val test17c = isAnySorted [1,2,3] = true
val test17d = isAnySorted [3,2,1] = true
val test17e = isAnySorted [1,3,2] = false;

(* 18 *)
val test18a = sortedMerge ([],[]) = []
val test18b = sortedMerge ([1,3],[2,4]) = [1,2,3,4]
val test18c = sortedMerge ([1,3,5],[2,4]) = [1,2,3,4,5];

(* 19 *)
val test19a = qsort [] = []
val test19b = qsort [1] = [1]
val test19c = qsort [1,5,4,8,2] = [1,2,4,5,8];

(* 20 *)
val test20a = divide [] = ([],[])
val test20b = divide [1,2,3] = ([1,3],[2]);

(* 21 *)
val test21a = not_so_quick_sort [1,5,4,8,2] = [1,2,4,5,8];

(* 22 *)
val test22a = fullDivide (2,40) = (3,5)
val test22b = fullDivide (3,10) = (0,10);

(* 23 *)
val test23a = factorize (1) = []
val test23b = factorize (20) = [(2,2),(5,1)]
val test23c = factorize (71) = [(71,1)];

(* 24 *)
val test24a = multiply (factorize (20)) = 20
val test24b = multiply (factorize 1) = 1;

(* 25 *)
val test25a = all_products (factorize 20) = [1,2,4,5,10,20]
val test25b = all_products (factorize 1) = [1]
val test25c = all_products (factorize 30) = [1,2,3,5,6,10,15,30]

val test25d = all_products_better (factorize 20) = [1,2,4,5,10,20]
val test25e = all_products_better (factorize 1) = [1]
val test25f = all_products_better (factorize 30) = [1,2,3,5,6,10,15,30]

(* extra practice problems *)

(* 1 *)
fun alternate (ints : int list) =
    let
	fun helper (ints : int list, lca : string, ssf : int) =
	    (* lca is a lost-context acc, either "add" or "sub"
	       ssf is the sum so far *)
	    if null ints
	    then ssf
	    else
		if lca = "add"
		then helper (tl ints, "sub", ssf + hd ints)
		else helper (tl ints, "add", ssf - hd ints)
    in
	helper (ints, "add", 0)
    end;

(* 2 *)
fun min_max (ints : int list) =
    (* ASSUME: ints are non empty *)
    if null (tl ints)
    then (hd ints, hd ints)
    else
	let
	    val tl_ans = min_max(tl ints)
	in
	    (* if higher than highest *)
	    if hd ints > #2 tl_ans
	    then (#1 tl_ans, hd ints)
	    else
		(* if lower than lowest *)
		if hd ints < #1 tl_ans
		then (hd ints, #2 tl_ans)
		(* neither lowest nor highest *)
		else tl_ans
	end

(* 3 *)
fun cumsum (ints : int list) =
    if null ints
    then []
    else
	let
	    fun helper (ints : int list, ssf : int, lsf : int list) =
		(* ssf is the sum so far
		   lsf is the list so far
		   ints are non-empty at first *)
		if null ints
		then lsf
		else
		    let val cursum = hd ints + ssf
		    in helper (tl ints, cursum, cursum :: lsf)
		    end
	in
	    helper (ints, 0, [])
	end

(* 4 *)
fun greeting (name : string option) =
    if isSome name
    then "Hello there, " ^ (valOf name) ^ "!"
    else "Hello there, you!"

(* 5 *)
fun repeat (ints : int list, counts : int list) =
    (* ints and counts have same length *)
    if null ints
    then []
    else
	let
	    fun repeatOne (n : int, c : int) =
		if c = 0
		then []
		else n :: repeatOne (n, c-1)
	in
	    repeatOne (hd ints, hd counts) @ repeat (tl ints, tl counts)
	end

(* 6 *)
fun addOpt (opt1 : int option, opt2 : int option) =
    if isSome opt1 andalso isSome opt2
    then SOME ((valOf opt1) + (valOf opt2))
    else NONE

(* 7 *)
fun addAllOpt (intOpts : int option list) =
    let
	fun helper (intOpts : int option list, ssf : int option) =
	    (* we need to see if there are any SOMEs
		   so we initialize ssf as NONE *)
	    (* can't just check if ssf is 0 at the end, since 1 + ~1 = 0, for example *)
	    if null intOpts
	    then ssf
	    else
		(* we don't wanna change ssf unless we get a SOME *)
		if isSome (hd intOpts)
		then if ssf = NONE
		     (* update ssf *)
		     then helper (tl intOpts, hd intOpts)
		     else helper (tl intOpts,
				  SOME (valOf (hd intOpts) + (valOf ssf)))
		(* if hd intOpts is NONE *)
		else helper (tl intOpts, ssf)
    in
	helper (intOpts, NONE)
    end

(* 8 *)
fun any (bools : bool list) =
    if null bools
    then false
    else hd bools orelse any (tl bools)

(* 9 *)
fun all (bools : bool list) =
    if null bools
    then true
    else hd bools andalso all (tl bools)

(* 10 *)
fun zip (ints1 : int list, ints2 : int list) =
    (* lists don't have to be equal length *)
    if null ints1 orelse null ints2
    then []
    else (hd ints1, hd ints2) :: zip (tl ints1, tl ints2)

(* 11 *)
fun zipRecycle (ints1 : int list, ints2 : int list) =
    (* initially both must be non-empty *)
    if null ints1 orelse null ints2
    then []
    else
	let
	    val INTS1 = ints1
	    val INTS2 = ints2

	    fun longer (ints1 : int list, ints2 : int list) =
		(* true if ints1 is longer than ints2 *)
		if null ints1
		then false
		else
		    if null ints2
		    then true
		    else longer (tl ints1, tl ints2)

	    fun zipper (ints1 : int list, ints2 : int list, oneortwo : bool) =
		      if oneortwo
		      then
		          (* ints1 is longer *)
		          if null ints1
		          then []
		          else
			            if null ints2
				                  (* when ints2 gets over, start it again *)
			            then zipper (ints1, INTS2, oneortwo)
			            else (hd ints1, hd ints2) :: zipper (tl ints1, tl ints2, oneortwo)
		      else
		          (* ints2 is longer *)
		          if null ints2
		          then []
		          else
			            if null ints1
				                  (* when ints1 gets over, start it again *)
			            then zipper (INTS1, ints2, oneortwo)
			            else (hd ints1, hd ints2) :: zipper (tl ints1, tl ints2, oneortwo)

	in zipper (ints1, ints2, longer (ints1, ints2))
	end

fun zipRecycle2 (list1 : int list, list2 : int list) =
    if null list1 orelse null list2
    then []
    else
	let
	    fun helper (sub1 : int list, sub2 : int list, end1 : bool, end2 : bool) =
		if end1 andalso end2
		then []

		else if null sub1
		then helper (list1, sub2, true, end2)

		else if null sub2
		then helper (sub1, list2, end1, true)

		else (hd sub1, hd sub2) :: helper (tl sub1, tl sub2, end1, end2)
	in
	    helper (list1, list2, false, false)
	end

(* 12 *)
fun zipOpt (list1 : int list, list2 : int list) =
    let
	fun helper (list1:int list, list2:int list, rsf:(int*int) list) =
	    (* when both end at same time, i.e. same length *)
	    if null list1 andalso null list2
	    then SOME rsf
	    (* when one ends before the other *)
	    else if null list1 orelse null list2
	    then NONE
	    (* else put the tuple at end of rsf *)
	    else helper (tl list1, tl list2, rsf @ [(hd list1, hd list2)])
    in
	helper (list1, list2, [])
    end

(* 13 *)
fun lookup (pairs:(string*int) list, s2:string) =
    if null pairs
    then NONE

    else if #1 (hd pairs) = s2
    then SOME (#2 (hd pairs))

    else lookup (tl pairs, s2)

(* 14 *)
fun splitup (mixed:int list) =
    if null mixed
    then ([],[])

    else let val tl_ans = splitup (tl mixed)
	 in
	     if hd mixed > 0
	     then (hd mixed :: (#1 tl_ans), #2 tl_ans)

	     else (#1 tl_ans, hd mixed :: (#2 tl_ans))
	 end

(* 15 *)
(* ASSUME: no number in mixed is equal to threshold *)
fun splitAt (mixed:int list, threshold:int) =
    if null mixed
    then ([],[])

    else let val tl_ans = splitAt (tl mixed, threshold)
	 in
	     if hd mixed > threshold
	     then (hd mixed :: (#1 tl_ans), #2 tl_ans)
	     else (#1 tl_ans, hd mixed :: (#2 tl_ans))
	 end;

(* 16 *)
fun isSorted (ints:int list) =
    if null ints orelse null (tl ints)
    then true
    else ((hd ints < hd (tl ints)) andalso isSorted (tl ints));

(* 17 *)
fun isAnySorted (ints:int list) =
    let
        fun greater (n1:int, n2:int) =
            n1 > n2
        fun lesser (n1:int, n2:int) =
            n1 < n2
        fun helper (ints:int list, fun1:int*int -> bool) =
            (* empty or singleton *)
            if null ints orelse null (tl ints)
            then true
            (* fun1 should be true for entire list *)
            else fun1 (hd ints, hd (tl ints)) andalso helper (tl ints, fun1)
    in
        helper (ints, greater) orelse helper (ints, lesser)
    end;

(* 18 (tail recursive) *)
fun sortedMerge (ints1:int list, ints2:int list) =
    (* ASSUME: ints1 and ints2 are sorted *)
    let
        fun helper (ints1:int list, ints2: int list, rsf: int list) =
            (* rsf is the sorted list so far *)
            (* base cases - *)
            if null ints1
            then rsf @ ints2
            else if null ints2
            then rsf @ ints1

            else
                (* add smaller element to the end of rsf *)
                if hd ints1 < hd ints2
                then helper (tl ints1, ints2, rsf @ [hd ints1])
                else helper (ints1, tl ints2, rsf @ [hd ints2])
    in
        helper (ints1, ints2, [])
    end;

(* 19 *)
fun qsort (ints:int list) =
    if null ints orelse null (tl ints)
    then ints
    else
        let
            val threshold = hd ints
            (* split the rest of the list at threshold *)
            val split = splitAt (tl ints, threshold)
            val below = #2 split
            val above = #1 split
        in
            (* append the two sorted lists, putting threshold in the middle *)
            qsort (below) @ (threshold :: qsort (above))
        end;

(* 20 *)
fun divide (ints:int list) =
        let
            fun helper (ints:int list, switch:bool) =
                if null ints
                then ([],[])
                else
                    let val tl_ans = helper (tl ints, not switch)
                    in
                        if switch
                        then (hd ints :: (#1 tl_ans), #2 tl_ans)
                        else (#1 tl_ans, hd ints :: (#2 tl_ans))
                    end
        in
            helper (ints, true)
        end;

(* 21 *)
fun not_so_quick_sort (ints:int list) =
    if null ints orelse null (tl ints)
    then ints
    else
        let val divided = divide ints
            val l1 = #1 divided
            val l2 = #2 divided
        in
            sortedMerge (not_so_quick_sort l1, not_so_quick_sort l2)
        end;

(* 22 *)
fun fullDivide (k:int, n:int) =
    (* base case: fully divided *)
    if n = 1
    then (0,n)
    else
        (* if divisible *)
        if n mod k = 0
        then
            let val tl_ans = fullDivide (k,n div k);
                (* increment the count of divides *)
            in (#1 tl_ans + 1, #2 tl_ans)
            end
                (* base case: undivisible *)
        else (0,n);

(* 23 *)
fun factorize (n:int) =
    let
        val N = n
        fun helper (n:int, lca:int) =
            (* lca: stores current factor *)

            (* base cases - *)
            if n = 1
            then []
            else
                if (* lca greater than sqrt (n) *)
                    (lca * lca) > N
                then (* n is the last possible factor *)
                    [(n,1)]

                else
                    (* call fullDivide with lca and append whatever that gives *)
                    let val fullDiv'd = fullDivide (lca,n)
                    in
                        if (* lca is actually a factor *)
                            #1 fullDiv'd <> 0
                        then (lca, #1 fullDiv'd) :: helper (#2 fullDiv'd, lca + 1)
                        else helper (#2 fullDiv'd, lca + 1)
                    end
    in
        helper (n,2)
    end;

(* 24 *)
fun multiply (factors:(int*int) list) =
    if null factors
    then 1
    else
        let
            (* multiplies one factor *)
            fun helper (factor: int*int) =
                if #2 factor = 1
                then #1 factor
                else (#1 factor) * helper (#1 factor, #2 factor - 1)
        in
            helper (hd factors) * multiply (tl factors)
        end;

(* 25 *)
fun all_products (factors:(int*int) list) : int list =
    (* generate all valid configs of factors, from 1 factor to all factors *)
    let
        fun sum (n1:int, n2:int) =
            n1+n2
        fun product (n1:int, n2:int) : int =
            n1*n2
        fun listProduct (l:int list) : int =
            foldl product 1 l

        val MAXTERMS = foldl sum 0 (map #2 factors)
        (* factors is more like factors + counts *)
        val FACTORLIST = map #1 factors

        fun genConfigs (t:int, prevConfig:(int list) list) : (int list) list =
            (* t is number of terms in config, initially 1 *)
            (* prevConfig can be used as the config generated for t-1 terms, initially [] *)

            if t > MAXTERMS
            then []
            else (* there are still configs to generate *)
                let
                    fun placeTerminConfigs (configs:(int list) list) : (int list) list =
                        (* generates configs with one more term than last time *)
                        let
                            fun placeTerminConfig (oneConfig:int list, factors:int list):(int list) list =
                                if (* can't happen first execution *)
                                    null factors
                                then []
                                else (hd factors :: oneConfig) ::
                                     placeTerminConfig (oneConfig, tl factors)
                        in
                            (* generating configs with 1 term *)
                            if t = 1
                            then placeTerminConfig ([], FACTORLIST)
                            else
                                (* base case *)
                                if null configs
                                then []
                                else placeTerminConfig (hd configs, FACTORLIST) @
                                     placeTerminConfigs (tl configs)
                        end
                    val CURRENTCONFIG = placeTerminConfigs (prevConfig)

                in CURRENTCONFIG @ genConfigs (t+1, CURRENTCONFIG)
                end

        fun valid (config:int list) : bool =
            (* a config is valid when the product of the factors of n is less than n *)
            (* !!! this can't work because there can be a wrong number of factors and still be less than n *)
            (* for a factor f appearing t times,
               we could check if config is valid, if CONFIGPRODUCT mod (f pow t+1) <> 0 *)
            let
                val N = multiply (factors)
                val CONFIGPRODUCT = foldl product 1 config

                fun validCounts (configproduct:int, factors:(int*int) list) : bool =
                    if null factors
                    then true
                    else
                        let
                            fun exp (n1:int, n2:int) : int =
                                if n2 = 0
                                then 1
                                else n1 * exp (n1, n2-1)

                                              (* if f isn't there t+1 times *)
                            val validamount = configproduct mod (exp (#1 (hd factors), (#2 (hd factors)) + 1)) <> 0

                        in validamount andalso
                           validCounts (configproduct, tl factors)
                        end
            in
                CONFIGPRODUCT <= N andalso validCounts (CONFIGPRODUCT, factors)
            end
        fun removeDupes (l:int list) : int list =
            if null l
            then []
            else
                let val tl_ans = removeDupes (tl l)
                    fun member (n:int, l:int list) =
                        if null l
                        then false
                        else if hd l = n
                        then true
                        else member (n, tl l)

                in if member ((hd l), tl_ans)
                   then tl_ans
                   else (hd l) :: tl_ans
                end

    in
        qsort (* sorts the list *)
            (1 :: removeDupes (* 1 has to be a factor *)
                      (map listProduct (* converts config to int *)
                           (List.filter valid
                                        (genConfigs (1, []))))) (* t starts at 1, we can have a separate case *)
    end

fun all_products_better (factors:(int*int) list) : int list =
    let
        val n = multiply (factors)
        (* gets all factors (not just prime) *)
        fun helper (c:int) : int list =
            if c = n
            then [n]
            else if n mod c = 0 (* is a factor *)
            then c :: helper (c+1)
            else helper (c+1)
    in
        helper(1)
    end

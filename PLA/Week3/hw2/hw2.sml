(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* 1a *)
(* patterns can only be constructors not expressions *)
fun all_except_option (x:string, ys:string list) : string list option =
    case ys of
        [] => NONE
      | y::ys' => if same_string (x,y)
                  then SOME ys' (* if same just return entire tail *)
                  else (* return based on option type of tail *)
                      case all_except_option (x,ys') of
                           NONE => NONE
                         | SOME tl_ans => SOME (y::tl_ans)

(* 1b *)
fun get_substitutions1 (yslist:(string list) list, x:string) : string list =
    (* go through each list with all_except_option *)
    case yslist of
        [] => []
      | ys::yslist' => case all_except_option (x,ys) of
                           NONE => get_substitutions1 (yslist',x) (* try next *)
                         | SOME exceptX => exceptX @ get_substitutions1 (yslist',x)

(* 1c *)
fun get_substitutions2 (yslist:(string list) list, x:string) : string list =
    let
        fun helper (yslist:(string list) list, rsf:string list) =
            (* rsf is the resulting list of strings, so far *)
            case yslist of
                [] => rsf
              | ys::yslist' => case all_except_option (x,ys) of
                                  NONE => helper (yslist',rsf)
                                | SOME exceptX =>
                                  helper (yslist',rsf @ exceptX)
    in
        helper (yslist, [])
    end

(* 1d *)
type fullName = {first:string, middle:string, last:string}
fun similar_names (allSubs:(string list) list, {first=f,middle=m,last=l}:fullName)
    : fullName list =
    (* has to call a function for iterating through subs, since it takes
       allSubs : string list list, which includes subs for other names,
       while we need to iterate through nameSubs : string list -> for our name only *)
    let
        (* the subs we want *)
        val nameSubs:string list = get_substitutions2 (allSubs,f)

        fun replaceName (sub:string) : fullName =
            {first=sub, middle=m, last=l}

        fun replaceNames (subs:string list) : fullName list =
            case subs of
                [] => [{first=f,middle=m,last=l}] (* base case: return list of name *)
              | sub::subs' => replaceName (sub) :: replaceNames (subs')
    in
        replaceNames (nameSubs)
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* 2a *)
fun card_color (crd:card) : color =
    case crd of
        (Clubs,_) => Black
      | (Diamonds,_) => Red
      | (Hearts,_) => Red
      | (Spades,_) => Black

(* 2b *)
fun card_value (crd:card) : int =
    case crd of
        (_,Jack) => 10
      | (_,Queen) => 10
      | (_,King) => 10
      | (_,Ace) => 11
      | (_,Num i) => i

(* 2c *)
fun remove_card (cs:card list, c:card, e:exn) : card list =
    case cs of
        [] => raise e
      | c1::cs' => if c1=c then cs' else c1::remove_card (cs', c, e)

(* 2d *)
fun all_same_color (cs:card list) : bool =
    (* we can compare 2 at a time *)
    case cs of
        [] => true (* might be an issue *)
      | [c] => true
      | c1::c2::cs' => (card_color (c1) = card_color (c2)) andalso all_same_color (c2::cs')

(* 2e *)
fun sum_cards (cs:card list) : int =
    (* must be tail recursive *)
    let
        fun helper (cs:card list, rsf:int) : int =
            (* rsf: sum so far *)
            case cs of
                [] => rsf
              | c::cs' => helper (cs', rsf + card_value (c))
    in
        helper (cs, 0)
    end

(* 2f *)
fun score (cs:card list, goal:int) : int =
    let
        val sum = sum_cards (cs)

        fun prelimScore (sum:int, goal:int) : int =
            if sum > goal
            then 3*(sum-goal)
            else goal-sum
    in
        if all_same_color (cs)
        then (prelimScore (sum, goal)) div 2
        else prelimScore (sum, goal)
    end

(* 2g *)
fun officiate (deck:card list, mvs: move list, goal:int) : int =
    (* deck: list of cards in deck
       mvs: moves the user makes *)
    let
        fun performMoves (hand:card list, deck:card list, mvs:move list) =
            case mvs of
                [] => score (hand, goal) (* empty => game over *)
              | (Discard c) :: mvs' => performMoves (remove_card (hand, c, IllegalMove),
                                                     deck,
                                                     mvs')
              | Draw::mvs' => case deck of
                                  [] => score (hand, goal) (* empty => game over *)

                                | c::cs' => if sum_cards (c::hand) > goal
                                            then score (c::hand, goal)
                                            else performMoves (c::hand, cs', mvs')
    in performMoves ([],deck,mvs)
    end

(* 3a *)

(* needs to be global, to be used by officiate *)
fun sum_cards2 (cs:card list) : int =
    (* with Ace as 1 *)
    case cs of
        [] => 0
      | (_,Ace) :: cs' => 1 + sum_cards2 (cs')
      | c::cs' => card_value (c) + sum_cards2 (cs')

fun score_challenge (cs:card list, goal:int) : int =
    let
        val sum2 = sum_cards2 cs

        fun prelimScore2 (sum:int, goal:int) : int =
            (* with Ace as 1 *)
            if sum > goal
            then 3*(sum-goal)
            else goal-sum
        val pscore2 = prelimScore2 (sum2, goal)
    in
        if all_same_color (cs)
        (* return min of both scores *)
        then Int.min (pscore2 div 2, score (cs, goal))
        else Int.min (pscore2, score (cs,goal))
    end

fun officiate_challenge (deck:card list, mvs:move list, goal:int) : int =
    let
        fun performMoves2 (hand:card list, deck:card list, mvs:move list) : int =
            case mvs of
                [] => score_challenge (hand, goal)
              | Discard c :: mvs' => performMoves2 (remove_card (hand, c, IllegalMove),
                                                    deck,
                                                    mvs')
              | Draw :: mvs' => case deck of
                                    [] => score_challenge (hand, goal)

                                  | c::deck' => if sum_cards2 (c::hand) > goal
                                                (* game over *)
                                                then score_challenge (c::hand, goal)
                                                else performMoves2 (c::hand,
                                                                    deck',
                                                                    mvs')
    in
        performMoves2 ([],deck,mvs)
    end

(* 3b *)

fun careful_player (deck:card list, goal:int) : move list =
    let
        fun returnHand (hand:card list, deck:card list, mvs:move list) : card list =
            case mvs of
                [] => hand
              | Discard c :: mvs' => returnHand (remove_card (hand, c, IllegalMove),
                                                 deck,
                                                 mvs')
              | Draw :: mvs' => case deck of
                                    [] => hand
                                  | c::deck' => returnHand (c::hand, deck', mvs')
        fun helper (mvs:move list) : move list =
            if score (returnHand ([], deck, mvs), goal) = 0
            then mvs
            else case deck of

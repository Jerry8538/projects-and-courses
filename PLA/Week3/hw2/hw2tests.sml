use "hw2.sml";
(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1a1 = all_except_option ("string", ["string"]) = SOME []
val test1a2 = all_except_option ("string", ["a","b","c"]) = NONE

val test1b1 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test1b2 = get_substitutions1 ([["foo", "bar", "faz"], ["foo", "bar"]], "foo") =
               ["bar", "faz", "bar"]

val test1c1 = get_substitutions2 ([["foo"],["there"]], "foo") = []
(* just append to back of rsf *)
val test1c2 = get_substitutions2 ([["foo", "bar", "faz"], ["foo", "bar"]], "foo") =
               ["bar", "faz", "bar"]
val test1c3 = get_substitutions2 ([["foo", "bar", "faz"], ["foo", "baz", "bar"]], "foo") =
               ["bar","faz", "baz", "bar"]

val test1d1 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
                           {first="Fred", middle="W", last="Smith"}) =
	          [{first="Fredrick", last="Smith", middle="W"},
	           {first="Freddie", last="Smith", middle="W"},
             {first="F", last="Smith", middle="W"},
             {first="Fred", last="Smith", middle="W"}]

val test2a1 = card_color (Clubs, Num 2) = Black

val test2b1 = card_value (Clubs, Num 2) = 2
val test2b2 = card_value (Hearts, Ace) = 11
val test2b3 = card_value (Spades, Jack) = 10

val test2c1 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test2c2 = ((remove_card ([(Hearts, Ace)], (Clubs, Ace), IllegalMove);
                false)
               handle IllegalMove => true)

val test2c3 = remove_card ([(Hearts, Ace), (Clubs,Ace)], (Hearts, Ace), IllegalMove) =
              [(Clubs,Ace)]

val test2d1 = all_same_color [(Hearts, Ace), (Diamonds, Ace)] = true
val test2d2 = all_same_color [(Hearts, Ace)] = true
val test2d3 = all_same_color [(Spades, Ace), (Hearts, Ace)] = false

val test2e = sum_cards [(Clubs, Num 2),(Clubs, Ace)] = 13

(* sum < goal, different color *)
val test2f1 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
(* sum > goal, same color *)
val test2f2 = score ([(Hearts, King),(Diamonds,Num 2)],11) = (3*(12-11)) div 2
(* sum > goal, different color *)
val test2f3 = score ([(Hearts, Queen),(Spades,Num 5)],10) = 3*(15-10)
(* sum < goal, same color *)
val test2f4 = score ([(Clubs, Num 2),(Spades,Num 3)],10) = (10-5) div 2
(* base case test *)
val test2f5 = score ([],10) = (10-0) div 2

val test2g1 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test2g2 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                         [Draw,Draw,Draw,Draw,Draw],
                         42)
              = 3

val test2g3 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                          [Draw,Discard(Hearts,Jack)],
                          42);
                false)
               handle IllegalMove => true)

(* CHALLENGE *)

(* Ace => 1 *)
val test3a1 = score_challenge ([(Hearts, Ace)],5) = (5-1) div 2
(* Ace => 11 *)
val test3a2 = score_challenge ([(Hearts, Ace)],11) = 3*(11-11) div 2

val test3a3 = sum_cards2 [(Clubs, Num 2),(Clubs, Ace)] = 3
val test3a4 = sum_cards2 [(Clubs, Num 2),(Clubs, King)] = 12

(* plain old tests *)
val test3a5 = officiate_challenge ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test3a6 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                                   [Draw,Draw,Draw,Draw,Draw],
                                   42)
              = 3

val test3a7 = ((officiate_challenge ([(Clubs,Jack),(Spades,Num(8))],
                                     [Draw,Discard(Hearts,Jack)],
                                     42);
                false)
               handle IllegalMove => true)

(* should have Ace as 1 *)
val test3a8 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                                    [Draw,Draw,Draw,Draw,Draw],
                                    4)
              = 0
(* WORKS!!! *)

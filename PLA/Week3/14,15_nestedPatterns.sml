(* Examples of nested patterns, before a neat recursive definition of patterns *)

exception unequalListLengths
val triple1 = ([1,2,3],[4,5,6],[7,8,9]) (* number of lists are fixed *)
val zipped1 = [(1,4,7),(2,5,8),(3,6,9)] (* number of tuples are variable, but all are triples *)

fun zip3 listTriple =
    case listTriple of
        ([],[],[]) => []
      | (x::xs', y::ys', z::zs') => (x,y,z) :: zip3(xs', ys', zs')
      | _ => raise unequalListLengths (* else *)
(* matching with a tuple of datatypes is a common idiom ^ *)

val test1a = zip3 triple1 = zipped1

fun unzip3 l =
    case l of
        [] => ([],[],[])
      | (x,y,z)::rest => let val (xs', ys', zs') = unzip3 rest
                         in (x::xs', y::ys', z::zs')
                         end

val test2a = unzip3 zipped1 = triple1


fun nondecreasing (xs:int list) : bool =
    (* return true if list in increasing order *)
    case xs of
        [] => true
      | [_] => true (* when you aren't using the variable, use underscore, it's good style *)
      | x1::x2::xs' => x1 <= x2 andalso nondecreasing (x2::xs')

val test3a = nondecreasing [1,3,5,6,9] = true
val test3b = nondecreasing [1,3,2,6,9] = false

(* sign of a number: Positive, Negative, Zero *)
datatype sgn = P | N | Z

fun multSign (x:int, y:int) : sgn =
    (* returns the sign when multiplying x and y *)
    let fun sign x = if x=0 then Z else if x<0 then N else P

        val sgnx = sign x
        val sgny = sign y
    in
        case (sgnx,sgny) of
            (* remember: patterns are matched in order *)
            (Z,_) => Z
          | (_,Z) => Z
          | (N,N) => P
          | (P,P) => P
          | (N,P) => N
          | (P,N) => N
    end

val test4a = multSign (5,0) = Z
val test4b = multSign (0,5) = Z
val test4c = multSign (~3,~4) = P
(* and so on. But pls actually test these lol *)

fun len xs =
    case xs of
        [] => 0
      | _::xs' => 1 + len xs'

val test5a = len [] = 0
val test5b = len [3,4,1] = 3

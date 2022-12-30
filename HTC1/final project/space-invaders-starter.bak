;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 2)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define INVADER-WIDTH/2 (/ (image-width INVADER) 2)) ;hitting borders

(define INVADER-HEIGHT/2 (/ (image-height INVADER) 2)) ;end the game

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "grey")       ;gun
                     (rectangle 20 10 "solid" "blue"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2)) ;placing above floor

(define TANK-Y (- HEIGHT TANK-HEIGHT/2))

(define TANK-WIDTH/2 (/ (image-width TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))

(define MISSILE-HEIGHT/2 (/ (image-height MISSILE) 2)) ;hitting ceiling

(define MISSILE-START-Y (- HEIGHT (image-height TANK)))


;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loi (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))



(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left
(define T3 (make-tank TANK-WIDTH/2 -1)) ;at left border, going left
(define T4 (make-tank TANK-WIDTH/2 1))  ;at left border, going right
(define T5 (make-tank (- WIDTH TANK-WIDTH/2) 1))  ;at right border, going right
(define T6 (make-tank (- WIDTH TANK-WIDTH/2) -1)) ;at right border, going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right
(define I4 (make-invader INVADER-WIDTH/2 150 -5)) ;hit left border
(define I5 (make-invader (- WIDTH INVADER-WIDTH/2) 100 10)) ;hit right border


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))

;;ListOfInvader is one of:
;; - empty
;; - (cons Invader ListOfInvader)
;; interp. as a list of invaders

(define LOI0 empty)
(define LOI1 (list I1))
(define LOI2 (list I1 I2))
#;
(define (fn-for-loi loi)
  (cond
    [(empty? loi) (...)]
    [else
     (... (first loi)
          (fn-for-loi (rest loi)))]))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit I1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit I1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit I1
(define M4 (make-missile (+ (invader-x I1) 3) (+ (invader-y I1) 50))) ;not hit I1
(define M5 (make-missile (+ (invader-x I1) 5) (+ (invader-y I1) 7))) ;hit I1

(define M6 (make-missile 200 MISSILE-HEIGHT/2)) ;exactly hit ceiling
(define M7 (make-missile 10 0)) ;hit ceiling

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))

;;ListOfMissile is one of:
;; - empty
;; - (cons Missile ListOfMissile)
;; interp. as a list of missiles

(define LOM0 empty)
(define LOM1 M1)
(define LOM2 (list M1 M2))
#;
(define (fn-for-lom lom)
  (cond
    [(empty? lom) (...)]
    [else
     (... (first lom)
          (fn-for-lom (rest lom)))]))


;;Game constants
(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game LOI1 LOM1 T1))
(define G3 (make-game LOI2 LOM2 T1))


;;===============
;;Functions

;;Game -> Game
;;Start space-invaders by evaluating (main (make-game empty empty T0))

(define (main game)
  (big-bang game
    (on-tick tick-game)              ;Game -> Game
    (on-key handle-keys)             ;Game KeyEvent -> Game
    (to-draw render-game)            ;Game -> Image
    (stop-when end-game end-scene))) ;Game -> Boolean

;;======================
;; Functions for on-tick

;; Game -> Game
;; Updates invaders, missiles and tank
#;
(define (tick-game s) s) ;stub

(check-random (tick-game G0)
              (make-game
               (manage-invaders (game-invaders G0)
                                (manage-missiles (game-missiles G0)))
               (manage-missiles (game-missiles G0))
               (move-tank (game-tank G0))))

(check-random (tick-game G3)
              (make-game
               (manage-invaders (game-invaders G3)
                                (manage-missiles (game-missiles G3)))
               (manage-missiles (game-missiles G3))
               (move-tank (game-tank G3))))

(define (tick-game g)
  (make-game
   (manage-invaders (game-invaders g) (manage-missiles (game-missiles g)))
   (manage-missiles (game-missiles g))
   (move-tank (game-tank g))))
;;=====================
;; Functions for Invader

;; ListOfInvader ListOfMissile -> ListOfInvader
;; Checks to see if invaders are hit, and removes them
#;
(define (manage-invaders loi lom) loi) ;stub

(check-random (manage-invaders empty empty)
              (invade empty INVADE-RATE))
(check-random (manage-invaders empty (list M1))
              (invade empty INVADE-RATE))
(check-random (manage-invaders (list I1) (list M1))
              (invade
               (move-invaders (list I1))
               INVADE-RATE))

(check-random (manage-invaders (list I1) (list M2))
              (invade
               (move-invaders
                (remove-invaders (list I1) (list M2)))
               INVADE-RATE))
(check-random (manage-invaders (list I1 I2) (list M2))
              (invade
               (move-invaders
                (remove-invaders (list I1 I2) (list M2)))
               INVADE-RATE))

;;Cross product of type comments table

;;                               loi
;;
;; l                       empty  | (cons Invader LOI)
;; o
;; m   empty               empty  | loi
;;    (cons Missile LOM)   empty  | <remove, move and invade>
;;

(define (manage-invaders loi lom)
  (cond
    [(empty? loi)
     (invade empty INVADE-RATE)]
    [(empty? lom)
     (invade (move-invaders loi) INVADE-RATE)]
    [else
     (invade
      (move-invaders
       (remove-invaders loi lom))
      INVADE-RATE)]))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; Calls its helper to check loi with every value in lom
#;
(define (remove-invaders loi lom) loi) ;stub

(check-expect (remove-invaders empty empty) empty)
(check-expect (remove-invaders empty (list M1)) empty)
(check-expect (remove-invaders (list I1) empty) (list I1))

(check-expect (remove-invaders (list I1) (list M2)) empty)
(check-expect (remove-invaders (list I1 I2) (list M2)) (list I2))

;;Cross product of type comments table

;;                               loi
;;
;; l                       empty  | (cons Invader LOI)
;; o
;; m   empty               empty  | loi
;;    (cons Missile LOM)   empty  | (remove-invaders
;;                                    (remove-invaders-helper loi (first lom))
;;                                    (rest lom))
;;

(define (remove-invaders loi lom)
  (cond
    [(empty? loi) empty]
    [(empty? lom) loi]
    [else
     (remove-invaders
      (remove-invaders-helper loi (first lom))
      (rest lom))]))


;; ListOfInvader ListOfMissile -> ListOfInvader
;; removes invader from loi if hit by missile
;;(assume loi isnt empty)
#;
(define (remove-invaders-helper loi m) loi) ;stub

(check-expect (remove-invaders-helper (list I1) M1) (list I1))
(check-expect (remove-invaders-helper (list I1) M2) empty)
(check-expect (remove-invaders-helper (list I1 I2) M2) (list I2))

(define (remove-invaders-helper loi m)
  (cond
    [(empty? loi) empty]
    [else
     (if (hit? (first loi) m)
         (remove-invaders-helper (rest loi) m)
         (cons (first loi) (remove-invaders-helper (rest loi) m)))]))

;; Invader Missile -> Boolean
;; Returns true if invader within HIT-RANGE of missile, false otherwise
#;
(define (hit? i m) true) ;stub

(check-expect (hit? I1 M1) false)
(check-expect (hit? I1 M2) true)
(check-expect (hit? I1 M4) false)
(check-expect (hit? I1 M5) true)

(define (hit? i m)
  (and (<= (abs (- (invader-x i) (missile-x m))) HIT-RANGE)
       (<= (abs (- (invader-y i) (missile-y m))) HIT-RANGE)))

;; ListOfInvader Number -> ListOfInvader
;; If (random 100) < INVADE-RATE, create an invader with random X and Y as 0
#;
(define (invade loi rate) loi) ;stub

(check-random (invade empty 100)
              (if (< (random 100) 100)
                  (cons
                   (make-invader (random WIDTH) 0 INVADER-X-SPEED)
                   empty)
                  empty))
(check-random (invade (list I1) 5)
              (if (< (random 100) 5)
                  (cons
                   (make-invader (random WIDTH) 0 INVADER-X-SPEED)
                   (list I1))
                  (list I1)))

(define (invade loi rate)
  (if (< (random 100) rate)
      (cons
       (make-invader (random WIDTH) 0 INVADER-X-SPEED)
       loi)
      loi))


;; ListOfInvader -> ListOfInvader
;; Moves each invader along X by invader-dx and along y by INVADER-Y-SPEED
;; Switches dx from +ve to -ve and vice versa when invader hits border
#;
(define (move-invaders loi) loi) ;stub

(check-expect (move-invaders empty) empty)
(check-expect (move-invaders (list (make-invader 100 0 INVADER-X-SPEED))) ;not hit border
              (list (make-invader 101.5 1.5 INVADER-X-SPEED)))

(check-expect (move-invaders (list I4 I5)) ;I4 hit left border, I5 hit right border
              (list (make-invader (- INVADER-WIDTH/2 -5) 151.5 5)
                    (make-invader (- (- WIDTH INVADER-WIDTH/2) 10) 101.5 -10)))

(check-expect (move-invaders (list ;hit borders but moving in the right direction
                              (make-invader INVADER-WIDTH/2 150 5)
                              (make-invader (- WIDTH INVADER-WIDTH/2) 100 -10)))
              (list
               (make-invader (+ INVADER-WIDTH/2 5) 151.5 5)
               (make-invader (+ (- WIDTH INVADER-WIDTH/2) -10) 101.5 -10)))

(define (move-invaders loi)
  (cond
    [(empty? loi) empty]
    [else
     (if (hit-border? (first loi))
         (cons (make-invader (- (invader-x (first loi)) (invader-dx (first loi)))
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (- 0 (invader-dx (first loi))))
               (move-invaders (rest loi)))
         (cons (make-invader (+ (invader-x (first loi)) (invader-dx (first loi)))
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (invader-dx (first loi)))
               (move-invaders (rest loi))))]))


;; Invader -> Boolean
;; Returns true if invader has hit a border and is going in the wrong direction,
;; false otherwise
#;
(define (hit-border? i) true) ;stub

(check-expect (hit-border? (make-invader 100 0 1.5)) false) ;hasn't hit border
(check-expect (hit-border? ;hit and going wrong direction
               (make-invader INVADER-WIDTH/2 150 -5))
              true)
(check-expect (hit-border? ;hit but going right direction
               (make-invader INVADER-WIDTH/2 150 5))
              false)
(check-expect (hit-border? ;hit and going wrong direction
               (make-invader (- WIDTH INVADER-WIDTH/2) 100 10)) true)
(check-expect (hit-border? ;hit but going right direction
               (make-invader (- WIDTH INVADER-WIDTH/2) 100 -10)) false)

(define (hit-border? i)
  (cond
    [(and (<= (invader-x i) INVADER-WIDTH/2) (< (invader-dx i) 0))
     true]
    [(and (>= (invader-x i) (- WIDTH INVADER-WIDTH/2)) (> (invader-dx i) 0))
     true]
    [else false]))


;;======================
;; Functions for Missile

;; ListOfMissile -> ListOfMissile
;; Moves missiles and removes ones that go off the screen (and ones that hit?)
#;
(define (manage-missiles lom) lom) ;stub

(check-expect (manage-missiles empty) empty)
(check-expect (manage-missiles (list M1))
              (remove-missiles
               (move-missiles (list M1))))
(check-expect (manage-missiles (list M1 M6 M7))
              (remove-missiles
               (move-missiles (list M1 M6 M7))))

(define (manage-missiles lom)
  (cond
    [(empty? lom) empty]
    [else
     (remove-missiles
      (move-missiles lom))]))

;; ListOfMissile -> ListOfMissile
;; Decreases Y coord of all missiles in lom by MISSILE-SPEED
#;
(define (move-missiles lom) lom) ;stub

(check-expect (move-missiles empty) empty)
(check-expect (move-missiles (list M1))
              (list (make-missile 150 290)))
(check-expect (move-missiles (list M6 M7))
              (list
               (make-missile 200 (- MISSILE-HEIGHT/2 10))
               (make-missile 10 (- 0 10))))

(define (move-missiles lom)
  (cond
    [(empty? lom) empty]
    [else
     (cons (make-missile (missile-x (first lom))
                         (- (missile-y (first lom)) MISSILE-SPEED))
           (move-missiles (rest lom)))]))

;; ListOfMissile -> ListOfMissile
;; Removes the missiles in lom with Y coord <= MISSILE-HEIGHT/2
#;
(define (remove-missiles lom) lom) ;stub

(check-expect (remove-missiles empty) empty)
(check-expect (remove-missiles (list M1 M6 M7))
              (list M1))

(define (remove-missiles lom)
  (cond
    [(empty? lom) empty]
    [else
     (if (off-screen? (first lom))
         (remove-missiles (rest lom))
         (cons (first lom) (remove-missiles (rest lom))))]))

;; Missile -> Boolean
;; Returns true if Y coord of m <= MISSILE-HEIGHT/2
#;
(define (off-screen? m) true) ;stub

(check-expect (off-screen? M1) false)
(check-expect (off-screen? M6) true)

(define (off-screen? m)
  (<= (missile-y m) MISSILE-HEIGHT/2))

;;===================
;; Functions for Tank

;; Tank -> Tank
;; Adds (TANK-SPEED * tank-dir) to tank-x if tank is moving correctly, return t if not
;!!!
#;
(define (move-tank t) t) ;stub

(check-expect (move-tank T0) ;not at border, so moves
              (make-tank (+ (/ WIDTH 2) TANK-SPEED) 1))
(check-expect (move-tank T2)
              (make-tank (+ 50 (* TANK-SPEED -1)) -1))

(check-expect (move-tank T3)  ;at border and moving wrong dir, so doesnt move
              (make-tank TANK-WIDTH/2 -1))
(check-expect (move-tank T5)
              (make-tank (- WIDTH TANK-WIDTH/2) 1))

(check-expect (move-tank T4) ;at border and moving correct dir, so moves
              (make-tank (+ TANK-WIDTH/2 TANK-SPEED) 1))
(check-expect (move-tank T6)
              (make-tank (+ (- WIDTH TANK-WIDTH/2) (* TANK-SPEED -1)) -1))

(define (move-tank t)
  (cond
    [(or
      (<= (tank-x t) TANK-WIDTH/2)
      (>= (tank-x t) (- WIDTH TANK-WIDTH/2)))
     (if (correct-dir? t)
         (make-tank
          (+ (tank-x t) (* TANK-SPEED (tank-dir t)))
          (tank-dir t))
         t)]
    [else
     (make-tank
      (+ (tank-x t) (* TANK-SPEED (tank-dir t)))
      (tank-dir t))]))

;; Tank -> Boolean
;;  - If tank not at any border, return true,
;;  - If tank at left border, returns true if tank-dir is 1, else false,
;;  - If tank at right border, returns true if tank-dir is -1 else false.
#;
(define (correct-dir? t) true)

(check-expect (correct-dir? T0)
              true)
(check-expect (correct-dir? T3)
              false)
(check-expect (correct-dir? T4)
              true)
(check-expect (correct-dir? T5)
              false)
(check-expect (correct-dir? T6)
              true)

(define (correct-dir? t)
  (cond
    [(<= (tank-x t) TANK-WIDTH/2)
     (= (tank-dir t) 1)]
    [(>= (tank-x t) (- WIDTH TANK-WIDTH/2))
     (= (tank-dir t) -1)]
    [else true]))

;;=====================
;; Functions for on-key

;; Game KeyEvent -> Game
;; Change tank-dir and fire missiles,
;; by handling left and right keys, and space key
#;
(define (handle-keys g ke) g) ;stub

(check-expect (handle-keys G0 " ")
              (fire-missile G0))
(check-expect (handle-keys G0 "left")
              (change-tank-dir G0 "left"))
(check-expect (handle-keys G0 "right")
              (change-tank-dir G0 "right"))

(check-expect (handle-keys G0 "q") G0)
(check-expect (handle-keys G0 "up") G0)

(define (handle-keys g ke)
  (cond
    [(key=? ke " ") (fire-missile g)]
    [(or
      (key=? ke "left") (key=? ke "right"))
     (change-tank-dir g ke)]
    [else g]))

;; Game -> Game
;; Fires a missile at X=tank-x, Y=MISSILE-START-Y
#;
(define (fire-missile g) g) ;stub

(check-expect (fire-missile G0)
              (make-game
               (game-invaders G0)
               (cons
                (make-missile (tank-x (game-tank G0))
                              MISSILE-START-Y)
                (game-missiles G0))
               (game-tank G0)))
(check-expect (fire-missile G1)
              (make-game
               (game-invaders G1)
               (cons
                (make-missile (tank-x (game-tank G1))
                              MISSILE-START-Y)
                (game-missiles G1))
               (game-tank G1)))

(define (fire-missile g)
  (make-game
   (game-invaders g)
   (cons
    (make-missile (tank-x (game-tank g))
                  MISSILE-START-Y)
    (game-missiles g))
   (game-tank g)))

;; Game KeyEvent["left", "right"] -> Game
;; Changes tank-dir to -1 if ke = "left", and 1 if ke = "right"
#;
(define (change-tank-dir g ke) g) ;stub

(check-expect (change-tank-dir G0 "left")
              (make-game
               (game-invaders G0)
               (game-missiles G0)
               (make-tank (tank-x (game-tank G0))
                          -1)))
(check-expect (change-tank-dir G0 "right")
              (make-game
               (game-invaders G0)
               (game-missiles G0)
               (make-tank (tank-x (game-tank G0))
                          1)))

(define (change-tank-dir g ke)
  (cond
    [(key=? ke "left")
     (make-game
      (game-invaders g)
      (game-missiles g)
      (make-tank (tank-x (game-tank g))
                 -1))]
    [(key=? ke "right")
     (make-game
      (game-invaders g)
      (game-missiles g)
      (make-tank (tank-x (game-tank g))
                 1))]))

;;==========================
;; Functions for to-draw

;; Game -> Image
;; Render the game by placing all elements at right place on BACKGROUND
#;
(define (render-game g) BACKGROUND) ;stub

(check-expect (render-game G0)
              (place-tank (game-tank G0) BACKGROUND))
(check-expect (render-game G3)
              (place-invaders (game-invaders G3)
                              (place-missiles (game-missiles G3)
                                              (place-tank (game-tank G3) BACKGROUND))))
(define (render-game g)
  (place-invaders (game-invaders g)
                  (place-missiles (game-missiles g)
                                  (place-tank (game-tank g) BACKGROUND))))

;; ListOfInvader Image -> Image
;; Places all invaders in loi onto img at respective coords
#;
(define (place-invaders loi img) img) ;stub

(check-expect (place-invaders empty BACKGROUND) BACKGROUND)
(check-expect (place-invaders LOI2 BACKGROUND)
              (place-images
               (list INVADER INVADER)
               (list
                (make-posn 150 100)
                (make-posn 150 HEIGHT))
               BACKGROUND))

(define (place-invaders loi img)
  (cond
    [(empty? loi) img]
    [else
     (place-image INVADER
                  (invader-x (first loi))
                  (invader-y (first loi))
                  (place-invaders (rest loi) img))]))

;; ListOfMissile Image -> Image
;; Places all missiles in lom onto img at respective coords
#;
(define (place-missiles lom img) img) ;stub

(check-expect (place-missiles empty BACKGROUND) BACKGROUND)
(check-expect (place-missiles LOM2 BACKGROUND)
              (place-images
               (list MISSILE MISSILE)
               (list
                (make-posn 150 300)
                (make-posn (invader-x I1) (+ (invader-y I1) 10)))
               BACKGROUND))

(define (place-missiles lom img)
  (cond
    [(empty? lom) img]
    [else
     (place-image MISSILE
                  (missile-x (first lom))
                  (missile-y (first lom))
                  (place-missiles (rest lom) img))]))

;; Tank Image -> Image
;; Places tank onto img at X=tank-x, Y=TANK-Y
#;
(define (place-tank t img) img) ;stub

(check-expect (place-tank T0 BACKGROUND)
              (place-image
               TANK
               (/ WIDTH 2)
               TANK-Y
               BACKGROUND))
(check-expect (place-tank T1 BACKGROUND)
              (place-image
               TANK
               50
               TANK-Y
               BACKGROUND))

(define (place-tank t img)
  (place-image
   TANK
   (tank-x t)
   TANK-Y
   img))

;;========================
;; Functions for stop-when

;; Game -> Boolean
;; Returns true if an invader hits the bottom
#;
(define (end-game g) true) ;stub

(check-expect (end-game G0) false)

(check-expect (end-game
               (make-game
                (list I2)
                empty
                T0))
              true)

(define (end-game g)
  (game-over? (game-invaders g)))

;; ListOfInvader -> Boolean
;; Returns true if an invader in loi has reached the bottom
#;
(define (game-over? loi) true) ;stub

(check-expect (game-over? empty) false)
(check-expect (game-over?
               (list I1 I2 I3))
              true)

(define (game-over? loi)
  (cond
    [(empty? loi) false]
    [else
     (if (>= (invader-y (first loi)) (- HEIGHT INVADER-HEIGHT/2))
         true
         (game-over? (rest loi)))]))

;; Game -> Image
;; Places the text "game over" on the screen
#;
(define (end-scene g) (render-game g)) ;stub

(check-expect (end-scene G0)
              (place-image
               (text "GAME OVER" 40 "black")
               (/ WIDTH 2)
               (/ HEIGHT 2)
               (render-game G0)))

(define (end-scene g)
  (place-image
   (text "GAME OVER" 40 "black")
   (/ WIDTH 2)
   (/ HEIGHT 2)
   (render-game g)))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |HTDF Design Quiz|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image Image -> Boolean
;; Finds the area of the 2 input images and compares, true if first is greater, false otherwise

;(define (compare-img img1 img2) false)    ;stub

;image 1 is greater
(check-expect
 (compare-img
  (square 10 "solid" "white") (square 1 "solid" "white"))
 "Image 1 is greater")

(check-expect
 (compare-img
  (square 18 "solid" "white") (square 10 "solid" "white"))
 "Image 1 is greater")

;image 2 is greater
(check-expect
 (compare-img
  (rectangle 15 10 "solid" "white") (circle 10 "solid" "white"))
 "Image 2 is greater")

(check-expect
 (compare-img
  (right-triangle 20 10 "solid" "white") (triangle 20 "solid" "white"))
 "Image 2 is greater")

;images are equal

(check-expect
 (compare-img
  (circle 15 "solid" "white") (circle 15 "solid" "white"))
 "Images are equal")

(check-expect
 (compare-img
  (right-triangle 50 10 "solid" "white") (rectangle 25 10 "solid" "white"))
 "Images are equal")
 
;either image is invalid

(check-expect
 (compare-img
  (ellipse 45 20 "solid" "white") (circle 25 "solid" "white"))
 "Make sure the images are solid and white, and one of five shapes - square, rectangle, circle, right-triangle, triangle")

(check-expect
 (compare-img
  (square 20 "solid" "white") (triangle 30 "outline" "red"))
 "Make sure the images are solid and white, and one of five shapes - square, rectangle, circle, right-triangle, triangle")



;(define (compare-img img1 img2)
;  (... img1 img2))


(define (compare-img img1 img2)

  ;making sure images are valid
  (if (or (equal? (compare-square img1) "invalid img") (equal? (compare-square img2) "invalid img"))
      "Make sure the images are solid and white, and one of five shapes - square, rectangle, circle, right-triangle, triangle"
      ;if img1 is greater
      (if (> (compare-square img1) (compare-square img2))
          "Image 1 is greater"
          ;if equal
          (if (= (compare-square img1) (compare-square img2))
              "Images are equal"
              ;if img2 is greater, since there is no other possibility
              "Image 2 is greater")
          )
      )
  )




;;; Compare-square Function

;;Image -> Number
;;Returns the area of the image

;(define (compare-square img) 0)   ;stub

(check-expect
 (compare-square (square 10 "solid" "white"))
 100)
(check-within
 (compare-square (circle 10 "solid" "white"))
 314.16 1)
(check-expect
 (compare-square (rectangle 10 15 "solid" "white"))
 150)
(check-expect
 (compare-square (right-triangle 20 10 "solid" "white"))
 100)
(check-expect
 (compare-square (triangle 10 "solid" "white"))
 45)

;(define (compare-square img)
;  (... img)

;defining variables
(define (h img) (image-height img))
(define (w img) (image-width img))
(define m "solid")
(define c "white")

(define (compare-square img)
  ;square
  (if
   (image=? img (square (h img) m c))
   ;if true return area of square
   (sqr (h img))
   ;if false onto next function
   (compare-rectangle img)
   )
  )

(define (compare-rectangle img)
  ;rectangle
  (if
   (image=? img (rectangle (w img) (h img) m c))
   ;if true return area of rectangle
   (* (w img) (h img))
   ;if false onto next function
   (compare-circle img)
   )
  )

(define (compare-circle img)
  
  ;circle 
  (if
   (image=? img (circle (* 0.5 (w img)) m c))
   ;if true area of circle
   (* pi (sqr (* 0.5 (w img))))
   ;if false onto next function
   (compare-right-triangle img)
   )
  )

(define (compare-right-triangle img)

  ;right-triangle
  (if
   (image=? img (right-triangle (w img) (h img) m c))
   ;if true area of right triangle
   (* 0.5 (w img) (h img))
   ;if false onto next function
   (compare-triangle img)
   )
  )


(define (compare-triangle img)
  ;triangle
  (if
   (image=? img (triangle (w img) m c))
   ;if true return area of triangle
   (* 0.5 (w img) (h img))
   ;if false make sure input is correct, since the function depends on the image being white and solid
   "invalid img"
   )
  )
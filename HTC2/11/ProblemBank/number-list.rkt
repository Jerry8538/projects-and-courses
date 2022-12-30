;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname number-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require spd/tags)

(@Problem 1)
(@HtDF number-list)
(@signature (listof X) -> (listof X))
;; append each string's position in the list to the front of the string to number the list

(check-expect (number-list empty) empty)
(check-expect (number-list (list "first" "second" "third")) 
              (list "1: first" "2: second" "3: third"))
(check-expect (number-list (list "a" "c" "b"))
              (list "1: a" "2: c" "3: b"))

(@template (listof X) accumulator)

(define (number-list lox0)
  (local [(define (number-list acc lox)
            (cond [(empty? lox) empty]
                  [else
                   (cons (string-append (string-append (number->string acc) ": ") (first lox))
                                  (number-list (add1 acc) (rest lox)))]))]
    (number-list 1 lox0)))
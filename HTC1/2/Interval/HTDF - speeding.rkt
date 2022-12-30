;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |HTDF -|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; CarSpeed is Number[0, 200]
;; interp. the speed of a car in km/h: 0 means stopped, 200 is the maximum speed

(define cs1 0)
(define cs2 150)
(define cs3 200)

(define (fn-for-car-speed cs)
  (... cs))

;; Template rules used:
;; - Atomic non-distinct: Number[0, 200]

;; Functions -

;; CarSpeed -> Boolean
;; Returns true if car speed is over 110

#;
(define (speeding? cs) "stub")  ;stub

(check-expect (speeding? 0) false)
(check-expect (speeding? 110) false)
(check-expect (speeding? 150) true)

;; Template from CarSpeed

(define (speeding? cs)
  (> cs 110))
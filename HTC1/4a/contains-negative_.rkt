;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname contains-negative?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ListOfNumber is one of:
;; - empty
;; - (cons Number ListOfNumber)
;; interp. a list of numbers

(define LON1 empty)
(define LON2 (cons 1 empty))
(define LON3 (cons 2 (cons 3 empty)))

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;;Template Rules used:
;; one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Number ListOfNumber)

;; ListOfNumber -> Boolean
;; Returns true if lon contains a negative number

#;
(define (contains--ve? lon) false) ;stub

(check-expect (contains--ve? empty) false)
(check-expect (contains--ve? (cons 0 empty)) false)
(check-expect (contains--ve? (cons -2 empty)) true)
(check-expect (contains--ve? (cons 3 (cons -7 empty))) true)

(define (contains--ve? lon)
  (cond [(empty? lon) false]
        [else
         (if (< (first lon) 0)
             true
             (contains--ve? (rest lon)))]))
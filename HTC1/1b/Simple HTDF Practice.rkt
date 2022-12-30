;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Simple HTDF Practice|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Text -> Text

;; returns plural by adding s

;(define (pluralize text) ;stub
;  "s")

(check-expect (pluralize "word") "words")
(check-expect (pluralize "test") "tests")

;(define (pluralize text)
;  (... text + "s"))

(define (pluralize text)
  (string-append text "s"))

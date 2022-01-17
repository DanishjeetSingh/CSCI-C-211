;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname lecture16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A ListOfNumbers is one of:
; - empty
; - (cons Number ListOfNumbers)

; Exercsie1.

; triple-numbers : ListOfNumbers -> ListOfNumbers
; takes every number in a list triples it and returns it in a new list
; (define (triple-numbers s) ...)

(define l1 (list 1 2))
(define l2 (list 1 2 3))
(define l3 (list 1 2 3 4))

(check-expect (triple-numbers l1) (list 3 6))
(check-expect (triple-numbers l2) (list 3 6 9))
(check-expect (triple-numbers l3) (list 3 6 9 12))

;(define (triple-numbers s)
;  (cond
;    [(empty? s) ...]
;    [(cons? s) (... (expt (first s) 3) (triple-numbers (rest s))...)]))

(define (triple-numbers s)
  (cond
    [(empty? s) empty]
    [(cons? s) (cons (* (first s) 3) (triple-numbers (rest s)))]))

; Exercsie2.

; product : ListOfNumbers -> Number
; takes a lon and multiplies them together
; (define (product s) ...)

(check-expect (product l1) 2)
(check-expect (product l2) 6)
(check-expect (product l3) 24)

;(define (product s)
;  (cond
;    [(empty? s) ...]
;    [(cons? s) (... (first s) (product (rest s))...)]))

(define (product s)
  (cond
    [(empty? s) 1]
    [(cons? s) (* (first s) (product (rest s)))]))


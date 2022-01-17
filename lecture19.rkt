;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

; sort-num : ListOfNumbers -> ListOfNumbers
; sorts a lon into ascending order
; (define (sort-num l) ...)

;(define (sort-num l)
;  (cond
;    [(empty? (rest l)) ...]
;    [(<= (first l) (first (rest l))) ...]
;    [(> (first l) (first (rest l))) ...]))

; Exercise 2.

; insert : Number ListOfNumbers -> ListOfNumbers
; inserts the number in the correct place in a sorted list
; (define (insert n l) ...)

(check-expect (insert 1 (list -1 2 3)) (list -1 1 2 3))
(check-expect (insert 2 (list -1 2 3)) (list -1 2 2 3))
(check-expect (insert 2 (list)) (list 2))

;(define (insert n l)
;  (cond
;    [(empty? l) (cons n empty)]
;    [(<= n (first l)) ...]
;    [(> n (first l)) ...]))

(define (insert n l)
  (cond
    [(empty? l) (cons n empty)]
    [(<= n (first l)) (cons n l)]
    [(> n (first l)) (cons (first l) (insert n (rest l)))])) 
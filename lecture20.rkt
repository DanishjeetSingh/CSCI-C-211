;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

; A TwoTree is one of:
; - Number
; - (make-two ThreeTree ThreeTree)
(define-struct two [first second])

; A ThreeTree is one of:
; - Number
; - (make-three TwoTree TwoTree)
(define-struct three [first second third])

(define two1 1)
(define three1 3)
(define two2 (make-two (make-three two1 two1 two1) (make-three two1 two1 two1)))
(define three2 (make-three (make-two three1 three1) (make-two three1 three1) (make-two three1 three1)))

; Exercise 2.

; count-two : TwoTree -> Number
; counts the numbers in tree
; (define (count-two tt) ...)

(check-expect (count-two 5) 1)
(check-expect (count-two (make-two 5 5)) 2)
(check-expect (count-two (make-two (make-three 1 1 1) 1)) 4)

; count-three : ThreeTree -> Number
; counts the numbers in tree
; (define (count-three tt) ...)

(check-expect (count-three 5) 1)
(check-expect (count-three (make-three 1 2 3)) 3)
(check-expect (count-three (make-three (make-two 1 2) 1 3)) 4)

(define (count-two tt)
  (cond
    [(number? tt) 1]
    [else (+ (count-three (two-first tt)) (count-three (two-second tt)))]))
(define (count-three tt)
  (cond
    [(number? tt) 1]
    [else (+ (count-two (three-first tt)) (count-two (three-second tt)) (count-two (three-third tt)))]))

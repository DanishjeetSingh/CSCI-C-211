;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Line is (make-line Number Number)
(define-struct line [intercept slope])
 
; run : Line Number -> Number
(define (run L x)
  (+ (line-intercept L) (* (line-slope L) x)))

; Exercise 1.

; (make-line 20 1)
; this line is better because it is closer to our expectations of
;(run L 0) is near 26
;
;(run L 10) is near 31
;
;(run L 20) is near 40
; we're using the formula y = mx + c
; where m is the slope and c the intercept

; Exercise 2.

; an almost better line than (make-line 20 1)

(make-line 21 1)
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture29) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Formula is one of:
; - Number
; - "x"
; - (make-add Formula Formula)
; - (make-mul Formula Formula)
(define-struct add [first second])
(define-struct mul [first second])

(define formula1
  (make-add (make-add (make-mul "x" "x")
                      (make-mul 2 "x"))
            1))

; Exercise 1.

; eval : Formula Number -> Number
; takes the value for x and evaluates it in the formula
; (define (eval f x) ...)

(check-expect (eval formula1 10) 121)

;(define (eval f x)
;  (cond
;    [(add? f) (... (eval (add-first f) x) (eval (add-second f) x))]
;    [(mul? f) (... (eval (mul-first f) x) (eval (mul-second f) x))]
;    [(number? f) ...]
;    [(string=? f "x") ...]))

(define (eval f x)
  (cond
    [(add? f) (+ (eval (add-first f) x) (eval (add-second f) x))]
    [(mul? f) (* (eval (mul-first f) x) (eval (mul-second f) x))]
    [(number? f) f]
    [(string=? f "x") x]))

; Exercise 2.

; dx : Formula -> Formula
; takes a formula and computes a derivative of it
; (define (dx f) ...)

(check-expect (eval (dx formula1) 10) 22)

;(define (dx f)
;  (cond
;    [(add? f) (... (dx (add-first f)) (dx (add-second f)))]
;    [(mul? f) (... (make-mul (dx (mul-first f)) (mul-second f))
;                        (make-mul (dx (mul-second f)) (mul-first f)))]
;    [(number? f) ...]
;    [(string=? f "x") ...]))

(define (dx f)
  (cond
    [(add? f) (make-add (dx (add-first f)) (dx (add-second f)))]
    [(mul? f) (make-add (make-mul (dx (mul-first f)) (mul-second f))
                        (make-mul (dx (mul-second f)) (mul-first f)))]
    [(number? f) 0]
    [(string=? f "x") 1]))




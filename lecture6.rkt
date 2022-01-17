;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Lecture 6

; Exercise 1
 
    (cond [(< 100 32) "solid"]
          [(<= 32 100 212) "liquid"]
          [(> 100 212) "gas"])
; = ???
; = ...
; = "liquid"

;(cond
; (#false "solid")
; ((<= 32 100 212)
;  "liquid")
; ((> 100 212) "gas"))

;(cond
; ((<= 32 100 212)
;  "liquid")
; ((> 100 212) "gas"))

;(cond
; (#true "liquid")
; ((> 100 212) "gas"))

;"liquid"

    (cond [(< -40 32) "solid"]
          [(<= 32 -40 212) "liquid"]
          [(> -40 212) "gas"])
; = ???
; = ...
; = "solid"

;(cond
; (#true "solid")
; ((<= 32 -40 212)
;  "liquid")
; ((> -40 212) "gas"))

;"solid"
 
    (cond [(< 450 32) "solid"]
          [(<= 32 450 212) "liquid"]
          [(> 450 212) "gas"])
; = ???
; = ...
; = "gas"

;(cond
; (#false "solid")
; ((<= 32 450 212)
;  "liquid")
; ((> 450 212) "gas"))

;(cond
; ((<= 32 450 212)
;  "liquid")
; ((> 450 212) "gas"))

;(cond
; (#false "liquid")
; ((> 450 212) "gas"))

;(cond
; ((> 450 212) "gas"))

;(cond (#true "gas"))

;"gas"

; Exercise 2

; A Boolean value is either:
; - #true 
; - #false

; > : Number Number -> Boolean
; < : Number Number -> Boolean
; = : Number Number -> Boolean
; >= : Number Number -> Boolean
; <= : Number Number -> Boolean

; bp-points : Number -> Number
; convert bp-points to coded value
; (define (bp-points bp) ...)

(check-expect (bp-points 99) 4)
(check-expect (bp-points 79) 3)
(check-expect (bp-points 69) 2)
(check-expect (bp-points 39) 1)
(check-expect (bp-points 0) 0)

; (define (bp-points bp) (... bp ...))

(define (bp-points bp)
  (cond [(> bp 89) 4]
        [(<= 76 bp 89) 3]
        [(< 50 bp 75) 2]
        [(< 1 bp 49) 1]
        [(= bp 0) 0])) 


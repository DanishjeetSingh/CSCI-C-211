;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lab7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define background (empty-scene 200 200))

; Exercise 1.

; number-between-20-and-180 : Number -> Number
; Imagine you are walking on the number line from the number 20 to the number 180.
; Where are you after going n% of the way?
; (define (number-between-20-and-180 n) ...)

(check-expect (number-between-20-and-180 0) 20)
(check-expect (number-between-20-and-180 50) 100)
(check-expect (number-between-20-and-180 100) 180)
(check-expect (number-between-20-and-180 1) 21.6)

;(define (number-between-20-and-180 n) (+ (* n ...) ...))

(define (number-between-20-and-180 n) (+ 20 (* n (/ (- 180 20) 100))))

; Exercise 2.

; number-between-90-and-10 : Number -> Number
; Imagine you are walking on the number line from the number 90 to the number 10.
; Where are you after going n% of the way?
; (define (number-between-90-and-10 n) ...)

(check-expect (number-between-90-and-10 0) 90)
(check-expect (number-between-90-and-10 50) 50)
(check-expect (number-between-90-and-10 100) 10)
(check-expect (number-between-90-and-10 1) 89.2)

; (define (number-between-90-and-10 n) (- (* n ...) ...))

(define (number-between-90-and-10 n) (+ 90 (* n (/ (- 10 90) 100))))

; Exercise 3.

; number-between. : Number Number Number -> Number
; finds the % of the range of numbers
; n1 is the low range, n2 is top range, n3 is the percentage to be computed
; (define (number-between n1 n2 n3) ...)

(check-expect (number-between 10 90 0) 90)
(check-expect (number-between 180 20 50) 100)

; (define (number-between n1 n2 n3) (+ n2 (* n3 (/ (- n1 n2) ...))))

(define (number-between n1 n2 n3) (+ n2 (* n3 (/ (- n1 n2) 100))))

; Exercise 4.

; line1 : NaturalNumber -> Posn
; Imagine you are walking on an empty scene from (make-posn 20 90) to (make-posn 180 10).
; Where are you after going n% of the way?
; (define (line1 n) ...)

(check-expect (line1 0) (make-posn 20 90))
(check-expect (line1 50) (make-posn 100 50))
(check-expect (line1 100) (make-posn 180 10))

; (define (line1 n) (...make-posn (number-between-20-and-180 n) (number-between-90-and-10 n)...))

(define (line1 n) (make-posn (number-between 180 20 n) (number-between 10 90 n)))

; Exercise 5.
; line2 : NaturalNumber -> Posn
; Imagine you are walking on an empty scene from (make-posn 30 200) to (make-posn 10 0).
; Where are you after going n% of the way?
; (define (line2 n) ...)

(check-expect (line2 0) (make-posn 30 200))
(check-expect (line2 50) (make-posn 20 100))
(check-expect (line2 100) (make-posn 10 0))

; (define (line2 n) (...make-posn (number-between 10 30 n) (number-between 0 200 n)...))

(define (line2 n) (make-posn (number-between 10 30 n) (number-between 0 200 n)))

; Exercise 6.

; posn-between : Posn Posn NaturalNumber -> Posn
; Imagine you are walking on an empty scene from start to end.
; Where are you after going n% of the way?
; (define (posn-between p1 p2 n) ...)

(check-expect (posn-between (make-posn 20 90) (make-posn 180 10) 0) (make-posn 20 90))
(check-expect (posn-between (make-posn 20 90) (make-posn 180 10) 50) (make-posn 100 50))
(check-expect (posn-between (make-posn 20 90) (make-posn 180 10) 100) (make-posn 180 10))

;(define (posn-between p1 p2 n) (make-posn (number-between (... p2) (... p1) n)
;                                          (number-between (... p2) (... p1) n)))

(define (posn-between p1 p2 n) (make-posn (number-between (posn-x p2) (posn-x p1) n)
                                          (number-between (posn-y p2) (posn-y p1) n)))

; Exercise 7.

;(define (line1 n) (posn-between (make-posn 20 90) (make-posn 180 10) n))
;(define (line2 n) (posn-between (make-posn 30 200) (make-posn 10 0) n))

; Exercise 8.

; Process-NaturalNumber

; Exercise 9.

; Process-NaturalNumber

; Exercise 10.
; 99

; Exercise 11.

; draw-wave : NaturalNumber Image -> Image
; draw the first that-many points of a wave on the given image
(check-expect (draw-wave 0 background) background)
(check-expect (draw-wave 3 background)
              (place-image
               (circle 1 "solid" "dark green")
               6 (+ 70 (* 30 (sin 0.6)))
               (place-image
                (circle 1 "solid" "dark green")
                4 (+ 70 (* 30 (sin 0.4)))
                (place-image
                 (circle 1 "solid" "dark green")
                 2 (+ 70 (* 30 (sin 0.2)))
                 background))))
(define (draw-wave n bg)
  (cond [(= n 0) bg]
        [else (place-image (circle 1 "solid" "dark green")
                   (posn-x (wave n))
                   (posn-y (wave n))
                   (draw-wave (- n 1) bg))]))

; draw-line1 : NaturalNumber Image -> Image
; draw the first that-many points of a straight line on the given image
(check-expect (draw-line1 0 background) background)
(check-expect (draw-line1 3 background)
              (place-image
               (circle 1 "solid" "blue")
               24.8 87.6
               (place-image
                (circle 1 "solid" "blue")
                23.2 88.4
                (place-image
                 (circle 1 "solid" "blue")
                 21.6 89.2
                 background))))
(define (draw-line1 n bg)
  (cond [(= n 0) bg]
        [else (place-image (circle 1 "solid" "blue")
                           (posn-x (line1 n))
                           (posn-y (line1 n))
                           (draw-line1 (- n 1) bg))]))
; Exercise 12.

; wave : NaturalNumber -> Posn

(define (wave n) (make-posn (* n 2) (+ 70 (* 30 (sin (/ n 5))))))

; draw : Operation String NaturalNumber -> Image
; Draws either a line or a wave
; (define (draw str n) ...)

(check-expect (draw line1 "blue" 3)
              (place-image
               (circle 1 "solid" "blue")
               24.8 87.6
               (place-image
                (circle 1 "solid" "blue")
                23.2 88.4
                (place-image
                 (circle 1 "solid" "blue")
                 21.6 89.2
                 background))))
(check-expect (draw wave "dark green" 3) (place-image
               (circle 1 "solid" "dark green")
               6 (+ 70 (* 30 (sin 0.6)))
               (place-image
                (circle 1 "solid" "dark green")
                4 (+ 70 (* 30 (sin 0.4)))
                (place-image
                 (circle 1 "solid" "dark green")
                 2 (+ 70 (* 30 (sin 0.2)))
                 background))))
(check-expect (draw line1 "yellow" 0) background)
(check-expect (draw wave "brown" 0) background)

(define (draw op color n)
  (cond [(= n 0) background]
        [else (place-image (circle 1 "solid" color)
                           (posn-x (op n))
                           (posn-y (op n))
                           (draw op color (- n 1)))]))

; Exercise 14.

(draw line2 "red" 100)

; curve1 : NaturalNumber -> Posn
; start like line1 and end like wave
(check-within (curve1 0) (line1 0) 0.001)
(check-within (curve1 100) (wave 100) 0.001)
(check-within (curve1 50)
              (posn-between (line1 50)
                            (wave 50)
                            50)
              0.001)
(define (curve1 n)
  (posn-between (line1 n) (wave n) n))

; curve2 : NaturalNumber -> Posn
; start like line2 and end like line1
(check-expect (curve2 0) (line2 0))
(check-expect (curve2 100) (line1 100))
(check-expect (curve2 50)
              (posn-between (line2 50)
                            (line1 50)
                            50))
(define (curve2 n)
  (posn-between (line2 n) (line1 n) n))

(draw curve1 "blue" 100)
(draw curve2 "red" 100)

; Exercise 16.

; blend : Operation Operation Number -> Posn
; Blend two operations together
; (define (blend op1 op2 n) ...)

(check-expect (blend line2 line1 100) (curve2 100))
(check-within (blend line1 wave 100) (curve1 100) 1)

(define (blend op1 op2 n)
  (posn-between (op1 n) (op2 n) n))

; Exercise 17

; curve3 : NaturalNumber -> Posn
; Blends line2 and wave together
; (define (curve3 n) ...)

(define (curve3 n)
  (blend line2 wave n))

(draw curve3 "red" 100)

; Exercise 18

; curve4 : NaturalNumber -> Posn
; blends line1 and line2 together
; (define (curve4 n) ...)

(define (curve4 n) (blend line1 line2 n))

; Exercise 19

; curve5 : NaturalNumber -> Posn
; blends curve2 and curve4 together
; (define (curve5 n) ...)

(define (curve5 n) (blend curve2 curve4 n))






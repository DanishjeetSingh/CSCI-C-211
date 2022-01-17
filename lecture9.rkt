;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Point is (make-point Number Number)
(define-struct point [x y])
 
; A Person is (make-person String Number)
(define-struct person [name age])

; Exercise 1.

;17 -> Number
;
;true -> Boolean
;
;"true" -> String
;
;"red" -> String
;
;(circle 10 "solid" "red") -> Image
;
;(make-point 3 4) -> Point
;
;(make-person "Dan" 22) -> Person

;Exercise 2.

(define background (empty-scene 400 400))
(define disk (circle 10 "solid" "red"))

; draw : Point -> Image
; returna n image of a cirle on x and y locations of a point p
; (define (draw p) ...)

(check-expect (draw (make-point 10 10))
              (place-image disk (point-x (make-point 10 10)) (point-y (make-point 10 10)) background))
(check-expect (draw (make-point 20 20))
              (place-image disk (point-x (make-point 20 20)) (point-y (make-point 20 20)) background))
(check-expect (draw (make-point 30 30))
              (place-image disk (point-x (make-point 30 30)) (point-y (make-point 30 30)) background))

; (define (draw p) (... disk ... p ,,, background ...))
(define (draw p)
  (place-image disk (point-x p) (point-y p) background))

; A x is a number
; A y is a number
; mouse: x y mouse-event -> Point
; to change the x and y locations of the point p to x and y locations of mouse
; (define (mouse p x y me) ...)

(check-expect (mouse (make-point 10 10) 0 0 "move") (make-point 0 0))
(check-expect (mouse (make-point 100 100) 10 10 "move") (make-point 10 10))
(check-expect (mouse (make-point 20 20) 50 50 "move") (make-point 50 50))

; (define (mouse p x y me) ( ... x ... y ...))

(define (mouse p x y me)
  (make-point x y))

; move-point: Point -> Point
; to change the x and y values of a point by 1
; (define (move-point p) ...)

(check-expect (move-point (make-point 10 10)) (make-point 11 11))
(check-expect (move-point (make-point 11 11)) (make-point 12 12))
(check-expect (move-point (make-point 12 12)) (make-point 13 13))


; (define (move-point p) (... x ... y ...))

(define (move-point p)
  (make-point (+ 1 (point-x p)) (+ 1 (point-y p))))

; when I add move-point function to on-tick
; the disk starts to move diagonally from the point it was last left on

(big-bang (make-point 100 100)
  [to-draw draw]
  [on-mouse mouse]
  [on-tick move-point])
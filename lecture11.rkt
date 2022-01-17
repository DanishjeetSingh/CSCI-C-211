;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; A EvenMorePoints is one of
;; - (make-none)
;; - (make-one Point)
;; - (make-two Point Point)
;; - (make-three Point Point Point)
(define-struct none ())
(define-struct one (first))
(define-struct two (first second))
(define-struct three (first second third))
 
;; A Point is (make-point Number Number)
(define-struct point [x y])

; Exercise 1.

;(define (process-evenmorepoints emp) (cond
;                                       [ ... (none? emp) ...]
;                                       [ ... (one? emp) ( ... (one-first emp) ...)]
;                                       [ ... (two? emp) ( ... (two-first emp) (two-second emp) ...)]
;                                       [ ... (three? emp)
;                                             ( ... (three-first emp)
;                                                   (three-second emp) (three-second emp) ...)]))

; Examples of evenmorepoints:
(define emp0 (make-none))
(define emp1 (make-one (make-point 10 10)))
(define emp2 (make-two (make-point 10 10) (make-point 20 20)))
(define emp3 (make-three (make-point 10 10) (make-point 20 20) (make-point 30 30)))


; draw-evenmorepoints: evenmorepoints -> Image
; takes up points and draws an image
; (define (draw-evenmorepoints emp) ...)

(define background (empty-scene 500 500))
(define marker (circle 5 "solid" "red"))

(check-expect (draw-evenmorepoints emp0) background)
(check-expect (draw-evenmorepoints emp1) (place-image marker 10 10 background))
(check-expect (draw-evenmorepoints emp2) (place-image
                                          marker 20 20
                                          (place-image marker 10 10
                                                       background)))
(check-expect (draw-evenmorepoints emp3) (place-image marker 10 10 (place-image
                                          marker 20 20
                                          (place-image marker 30 30
                                                       background))))

;(define (draw-evenmorepoints emp) (cond
;                                    [(none? emp) ... ]
;                                    [(one? emp) ... ]
;                                    [(two? emp) ... ]                                    
;                                    [(three? emp) ... ]))

(define (draw-evenmorepoints emp) (cond
                                    [(none? emp) background]
                                    [(one? emp)
                                     (place-image marker 10 10 background)]
                                    [(two? emp)
                                     (place-image
                                          marker 20 20
                                          (place-image marker 10 10
                                                       background))]
                                    [(three? emp)
                                     (place-image marker 10 10 (place-image
                                          marker 20 20
                                          (place-image marker 30 30
                                                       background)))]))
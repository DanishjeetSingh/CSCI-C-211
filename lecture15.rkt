;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname lecture15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Exercise 1.

; A MaybePosn is one of:
; - (make-none)
; - Posn
(define-struct none [])

; (define (process-MaybePosn p)
;   (cond[(none? p) ...]
;        [(posn? p) (... (posn-x p) (posn-y p) ...)]))


; A World is (make-world ListOfPosns Number MaybePosn)
(define-struct world [invaders player bullet])
; Interpretation: the player is at the given X coordinate
;                   and the bottom of the screen

; (define (process-ListOfPosns w)
;   (cond[(empty? w) ...]
;        [(cons? w)
;         (... (posn-x (first w)) (posn-y (first w)) ...)]))


; (define (process-world w)
;   (... (process-ListOfPosns (world-invaders ps))
;        (world-Number w) (process-MaybePosn (world-bullet w)) ...))

; Exercise 2.

; draw-world: world -> image

(define b1 (make-none))
(define b2 (make-posn 70 50))
(define player-sprite (triangle 10 "solid" "red"))
(define bullet-sprite (circle 5 "solid" "green"))

; draw-bullet : MaybePosn Image -> Image
; draw the bullet on the given image

(define cons1 empty)
(define cons2 (cons (make-posn 20 30) cons1))
(define cons3 (cons (make-posn 30 40) cons2))
(define cons4 (cons (make-posn 40 50) cons3))

(define background (rectangle 200 300 "solid" "black"))

(define draw
  (rectangle 5 5 "solid" "white"))

(define (draw-invaders w)
  (cond[(empty? w) background]
       [(cons? w) (place-image
                    draw (posn-x (first w)) (posn-y (first w))
                    (draw-invaders (rest w)))])) 

(check-expect (draw-bullet b1
                           (place-image player-sprite
                                        80 295
                                        (draw-invaders cons2)))
              (place-image player-sprite
                           80 295
                           (draw-invaders cons2)))
(check-expect (draw-bullet b2
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders cons1)))
              (place-image bullet-sprite
                           70 50
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders cons1))))
; (define (draw-bullet b img)
;   (cond [(none? b) (... img ...)]
;         [(posn? b) (... (posn-x b) (posn-y b) img ...)]))


(define (draw-bullet b img)
  (cond [(none? b) img]
        [(posn? b) (place-image bullet-sprite (posn-x b) (posn-y b) img)]))

;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; 1. Data definitions

; A Boolean is one of:
; - #true
; - #false

; A TrafficLight is one of:
; - "red"
; - "yellow"
; - "green"

; 2. Signature, purpose, header

; draw-tl : TrafficLight -> Image
; draw a simple traffic light
;(define (draw-tl tl) ...)

; 3. Examples

(require 2htdp/image)
(define background (rectangle 100 300 "solid" "black"))

(check-expect (draw-tl "red")
              (place-image (circle 40 "solid" "red") 50 50 background))

(check-expect (draw-tl "yellow")
              (place-image (circle 40 "solid" "yellow") 50 150 background))

(check-expect (draw-tl "green")
              (place-image (circle 40 "solid" "green") 50 250 background))

; 4. Template

;(define (draw-tl tl)
;  (cond [(string=? tl "red") ...]
;        [(string=? tl "yellow") ...]
;        [(string=? tl "green") ...]))

; 5. Function definition

(define (draw-tl tl)
  (cond [(string=? tl "red")
         (place-image (circle 40 "solid" "red") 50 50 background)]
        [(string=? tl "yellow")
         (place-image (circle 40 "solid" "yellow") 50 150 background)]
        [(string=? tl "green")
         (place-image (circle 40 "solid" "green") 50 250 background)]))

; 1. Data definitions

; A Boolean is one of:
; - #true
; - #false

; A TrafficLight is one of:
; - "red"
; - "yellow"
; - "green"

; 2. Signature, purpose, header

; next-tl : TrafficLight -> TrafficLight
; return the next traffic light
;(define (next-tl tl) ...)

; 3. Examples
(check-expect (next-tl "red") "green")
(check-expect (next-tl "green") "yellow")
(check-expect (next-tl "yellow") "red")

; 4. Template
;(define (next-tl tl)
;  (cond [(string=? tl "red") ...]
;        [(string=? tl "green") ...]
;        [(string=? tl "yellow") ...]))

; 5. Function definition
(define (next-tl tl)
  (cond [(string=? tl "red") "green"]
        [(string=? tl "green") "yellow"]
        [(string=? tl "yellow") "red"]))

; 1. Data definitions

; A Boolean is one of:
; - #true
; - #false

; A TrafficLight is one of:
; - "red"
; - "yellow"
; - "green"

; 2. Signature, purpose, header

; reset-to-red : TrafficLight -> TrafficLight
; return the red traffic light when any key is pressed
;(define (reset-to-red tl ke) ...)

; 3. Examples
(check-expect (reset-to-red "red" " ") "red")
(check-expect (reset-to-red "green" " ") "red")
(check-expect (reset-to-red "yellow" " ") "red")

; 4. Template
; (define (reset-to-red tl ke) (... tl ...))

; 5. Function definition
(define (reset-to-red tl ke) (next-tl "yellow"))

(big-bang "red"
  [to-draw draw-tl]
  [on-key reset-to-red]
  [on-tick next-tl 2])

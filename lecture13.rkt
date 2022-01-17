;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

; What’s one thing you learned?
; Analog systems is the heart of tradiitonal ways of engineering.

; What’s one question you have?
; How sophisticated systems can we build?

; Describe one similarity between the SDI software system and another specific software system.
; GPS system is a similarity as it is used to determine your location, and the star wars program
; uses that to determine missile position.

; A Doll is one of:
; - (make-small-doll String)
; - (make-larger-doll Doll)
(define-struct small-doll (color))
(define-struct larger-doll (smaller))

; Exercise 2.

; green-doll: Doll -> Doll
; to make the small doll green
; (define (green-doll g) ...)

(define d1 (make-small-doll "green"))
(define d2 (make-small-doll "red"))
(define d3 (make-larger-doll d1))
(define d4 (make-larger-doll d2))

(check-expect (green-doll d1)
              (make-small-doll "green"))
(check-expect (green-doll d2)
              (make-small-doll "green"))
(check-expect (green-doll d3)
              (make-larger-doll (make-small-doll "green")))
(check-expect (green-doll d4)
              (make-larger-doll (make-small-doll "green")))

;(define (green-doll g)
;  (cond
;    [(small-doll? g)
;     (cond
;       [(string=? (small-doll-color g) "green") ...]
;       [else ...])]
;    [(larger-doll? g) ...]))
   

(define (green-doll g)
  (cond
    [(small-doll? g)
     (cond
       [(string=? (small-doll-color g) "green") g]
       [else (make-small-doll "green")])]
    [(larger-doll? g)
     (make-larger-doll (green-doll (larger-doll-smaller g)))]))

      
        
   
              

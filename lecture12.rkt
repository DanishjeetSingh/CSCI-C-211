;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Point is (make-point Number Number)
(define-struct point [x y])
 
; A BunchOfPoints is one of:
; - (make-none)
; - (make-some Point BunchOfPoints)
(define-struct none [])
(define-struct some [first rest])

; Exercise 1.

(define bop1 (make-none))
(define bop2 (make-some (make-point 10 10) (make-some (make-point 10 20) (make-none))))
(define bop3 (make-some (make-point 10 10)
                        (make-some (make-point 10 20)
                                   (make-some (make-point 10 30) (make-none)))))

; Exercise 2.

;(make-some (make-point 70 40)
;           (make-point 30 50))
; not a bop, doesn't follow the data definiton of bop

;(make-none)
; it is a bop

;(make-some (make-point 30 50)
;           make-none)
; it is not a bop, because of the missing bracket
 
;(make-some
; (make-point 70 40)
; (make-some (make-point 30 50)
;            (make-none)))
; it is a bop

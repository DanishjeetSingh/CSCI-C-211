;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

;The property of the pension system are the individuals in the system.
; The insurance cards are also a property of the pension systmem.
; The computation is the EMIDEC 2400 which checks everyone in the UK.
; The norm is what identifies individuals in the UK.


; Exercise 2.

; between-20-50 : ListOfNumbers -> ListOfNumbers
; gets rid of every number that isn't in 20 to 50 range.
; (define (between-20-50 n) ...)

(check-expect (between-20-50 (list)) (list))
(check-expect (between-20-50 (list 10 20)) (list 20))
(check-expect (between-20-50 (list 10 20 30)) (list 20 30))

;(define (between-20-50 n)
;  (cond
;    [(empty? n) (list)]
;    [(cons? n) (cond
;                 [(... 20 (first n) 50) (cons (first n) (between-20-50 (rest n))...)]
;                 [else (between-20-50 (rest n))...])]))
                              
(define (between-20-50 n)
  (cond
    [(empty? n) (list)]
    [(cons? n) (cond
                 [(<= 20 (first n) 50) (cons (first n) (between-20-50 (rest n)))]
                 [else (between-20-50 (rest n))])]))
                              

;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

; filter is the name
; signature takes only 1 input, X
; function takes 2 inputs, [X - > Boolean] [ListOf X]

; Exercise 2.

; e? : [String -> Boolean]
; checks if a string has e or not ang gives the opposite of that.
; (define (e? s) ...)

(check-expect (e? "cheese") false)
(check-expect (e? "hello") false)
(check-expect (e? "again") true)

;(define (e? s)
;  (not (string-contains? "e" s)...))

(define (e? s)
  (not (string-contains? "e" s)))

(filter e? (list "a" "b" "c" "d" "e"))

; x<y? : [Posn -> Boolean]
; checks if the x coordinate is less than y coordinate and gives the opposite of that.
; (define (x<y? s) ...)

(check-expect (x<y? (make-posn 20 10)) false)
(check-expect (x<y? (make-posn 20 30)) true)
(check-expect (x<y? (make-posn 20 20)) true)

;(define (x<y? s)
;  (not (< (posn-y s) (posn-x s))...))

(define (x<y? s)
  (not (< (posn-y s) (posn-x s))))

(filter x<y? (list (make-posn 10 10) (make-posn 20 10) (make-posn 10 20)))



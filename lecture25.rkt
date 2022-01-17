;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture25) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 2.

; Exercise 3.

; rev : [ListOf X] -> [ListOf X]
; reverses the order of elements in the given list
(check-expect (rev empty) empty)
(check-expect (rev (list "man" "bites" "dog")) (list "dog" "bites" "man"))
(check-expect (rev (list       "bites" "dog")) (list "dog" "bites"))
(check-expect (rev (list               "dog")) (list "dog"))z

(define (rev lx)
  (cond
    [(empty? lx) ...]
    [else ((first lx) ... (rev (rest lx)))]))

; Exercise 4.

; 3.65
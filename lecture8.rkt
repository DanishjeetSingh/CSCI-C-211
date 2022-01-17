;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1

; What’s one thing you learned from Gebru’s talk?
; I learnt that the Artificial Intelligence has it's own limitations.

; What’s one question you have from Gebru’s talk?
; Why haven't we yet formed laws on the collection and utilization of data?

; Gebru discussed runaway feedback loops that amplify societal biases. Give one example
; (it does not have to involve computing) and
; explain why it is a runaway feedback loop that amplifies societal biases.
; The rising hate for Asians in America recently.

;Exercise 2
; A Point is (make-point Number Number)
(define-struct point [x y])
(define here  (make-point 30 50))
(define there (make-point 70 40))
 
; A Person is (make-person String Number)
(define-struct person [name age])
(define me  (make-person "Alice" 37))
(define you (make-person "Bob"   22))

;(- (point-x there) (point-x here))
;40

;(person-name you)
;"Bob"

;(< (person-age me) (person-age you))
;#false

;(- (point-x there) (point-x me))
;point-x: expects a point, given (make-person "Alice" 37)

;(point-x (point-x there))
;point-x: expects a point, given 70

;(make-person "Carol" 21)
;(make-person "Carol" 21)
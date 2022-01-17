;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture26) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Place is String
; A Map is [ListOf Highway]
; A Highway is (make-highway Place Place)
(define-struct highway [start end])

; Exercise 1.

; neighbors : Place Map -> [ListOf Place]
; produces a list of all the Places you can get to in one step from the original
; (define (neighbors p m) ...)
(define map1 (list (make-highway "a" "b") (make-highway "a" "c") (make-highway "c" "d")))

(check-expect (neighbors "a" map1) (list "b" "c"))
(check-expect (neighbors "f" map1) (list))
(check-expect (neighbors "c" map1) (list "d"))

(define (neighbors p m)
  (cond [(empty? m) empty]
        [(string=? p (highway-start (first m)))
         (cons (highway-end (first m)) (neighbors p (rest m)))]
        [else (neighbors p (rest m))]))

; Exercise 2.

; A WayTree is one of:
; - (make-done Place)
; - (make-stop Place [ListOf WayTree])

; A [ListOf WayTree] is one of:
; - empty
; - (cons WayTree [ListOf WayTree])
(define-struct done [at])
(define-struct stop [at children])

(define (process-lowt lowt)
  (cond
    [(empty? lowt) ...]
    [else (... (process-waytree (first lowt))
               (process-lowt (rest lowt)))]))

(define (process-waytree  w)
  (cond
    [(done? w) (... (done-at w))]
    [(stop? w) (... (stop-at w) (process-lowt (stop-children w)))]))


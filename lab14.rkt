;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A ByTwoN is one of:
; - empty
; - (make-two Number ByTwoN Number)
(define-struct two [left rest right])

(define btn1 empty)
(define btn2 (make-two 1 empty 2))
(define btn3 (make-two 1 (make-two 2 empty 3) 4))

; Exercise 1.

; count-bytwon : ByTwoN -> Number
; counts how many numbers are in a ByTwoN
; (define (count-bytwon btn) ...)

(check-expect (count-bytwon btn1) 0)
(check-expect (count-bytwon btn2) 2)
(check-expect (count-bytwon btn3) 4)

;(define (count-bytwon btn)
;  (cond
;    [(empty? btn) ...]
;    [else (... 1 (count-bytwon (two-rest btn)) 1)]))

;(define (count-bytwon btn)
;  (cond
;    [(empty? btn) 0]
;    [else (+ 1 (count-bytwon (two-rest btn)) 1)]))

; Exercise 2.

; sum-bytwon : ByTwoN -> Number
; computes the sum of all the numbers in a ByTwoN
; (define (sum-bytwon btn) ...)

(check-expect (sum-bytwon btn1) 0)
(check-expect (sum-bytwon btn2) 3)
(check-expect (sum-bytwon btn3) 10)

;(define (sum-bytwon btn)
;  (cond
;    [(empty? btn) ...]
;    [else (... (two-left btn) (two-rest btn) (two-right btn))]))

(define (sum-bytwon btn)
  (cond
    [(empty? btn) 0]
    [else (+ (two-left btn) (sum-bytwon (two-rest btn)) (two-right btn))]))

; Exercise 3.

; product-bytwon : ByTwoN -> Number
; computes the product of all the numbers
; (define (product-bytwon btn) ...)

(check-expect (product-bytwon btn1) 1)
(check-expect (product-bytwon btn2) 2)
(check-expect (product-bytwon btn3) 24)

;(define (product-bytwon btn)
;  (cond
;    [(empty? btn) ...]
;    [else (... (two-left btn) (product-bytwon (two-rest btn)) (two-right btn))]))

(define (product-bytwon btn)
  (cond
    [(empty? btn) 1]
    [else (* (two-left btn) (product-bytwon (two-rest btn)) (two-right btn))]))

; Exercise 4.

; count-bytwon/a : ByTwoN Number -> Number
; counts the number in a bytwon
; (define (count-bytwon/a btn current) ...)

; *Accumulator* : current is the number count so far

(check-expect (count-bytwon/a btn1 0) 0)
(check-expect (count-bytwon/a btn2 0) 2)
(check-expect (count-bytwon/a btn3 0) 4)

(define (count-bytwon/a btn current)
  (cond
    [(empty? btn) current]
    [else (count-bytwon/a (two-rest btn) (+ current 2))]))

; sum-bytwon/a : ByTwoN Number -> Number
; computes the sum of the numbers.
; (define (sum-bytwon/a btn current) ...)

; *Accumulator* : current is the number sum so far

(check-expect (sum-bytwon/a btn1 0) 0)
(check-expect (sum-bytwon/a btn2 0) 3)
(check-expect (sum-bytwon/a btn3 0) 10)

(define (sum-bytwon/a btn current)
  (cond
    [(empty? btn) current]
    [else (sum-bytwon/a (two-rest btn) (+ current (two-left btn) (two-right btn)))]))

; product-bytwon/a : ByTwoN Number -> Number
; computes the product of the numbers.
; (define (product-bytwon/a btn current) ...)

; *Accumulator* : current is the number product so far

(check-expect (product-bytwon/a btn1 1) 1)
(check-expect (product-bytwon/a btn2 1) 2)
(check-expect (product-bytwon/a btn3 1) 24)

(define (product-bytwon/a btn current)
  (cond
    [(empty? btn) current]
    [else (product-bytwon/a (two-rest btn) (* current (two-left btn) (two-right btn)))]))

; Exercise 5.

; fold-bytwon : ByTwoN Number [Number Number -> Number] -> Number
; abstarction of sum-bytwon and product-bytwon
; (define (fold-bytwon btn n op) ...)

(check-expect (fold-bytwon btn1 0 +) 0)
(check-expect (fold-bytwon btn2 0 +) 3)
(check-expect (fold-bytwon btn3 1 *) 24)

(define (fold-bytwon btn n op)
  (cond
    [(empty? btn) n]
    [else (op (two-left btn) (fold-bytwon (two-rest btn) n op) (two-right btn))]))

; Exercise 6.

;(define (count-bytwon btn)
;  (fold-bytwon btn 0 (local [
;                             ; help : Number Number Number -> Number
;                             ; calculates the count of numbers in a given input
;                             ; (define (help n1 n2 n3) ...)
;
;                             (define (help n1 n2 n3)
;                               (+ 2 n2))] help)))

(define (count-bytwon btn)
  (fold-bytwon btn 0 (lambda (n1 n2 n3) (+ 2 n2))))

; Exercise 7.

; A ByTwoS is one of:
; - empty
; - (make-two String ByTwoN String)

; Exercise 8.

; NtoS : ByTwoN [Number -> String] -> ByTwoS
; converts ByTwoN to ByTwoS
; (define (ntos btn op) ...)

(check-expect (ntos btn1 number->string) empty)
(check-expect (ntos btn2 number->string) (make-two "1" '() "2"))

(define (ntos btn ns)
  (cond
    [(empty? btn) empty]
    [else (make-two (ns (two-left btn))
          (ntos (two-rest btn) ns)
          (ns (two-right btn)))]))

; Exercise 9.


(check-expect (ston (ntos btn1 number->string) string->number) empty)
(check-expect (ston (ntos btn2 number->string) string->number) (make-two 1 '() 2))

(define (ston btn sn)
  (cond
    [(empty? btn) empty]
    [else (make-two (sn (two-left btn))
          (ston (two-rest btn) sn)
          (sn (two-right btn)))]))

; Exercise 11.

; A StringTree is one of:
; - (make-leaf String)
; - (make-node String [ListOf StringTree])
(define-struct leaf (label))
(define-struct node (label kids))

; a [ListOf StringTree] is one of:
; - empty
; - (cons StringTree [ListOf StringTree])

(define los1 (list (make-leaf "f")))
(define los2 (list (make-leaf "f") (list (make-leaf "f"))))

; Exercise 12.

; st-s : StringTree -> String
; takes a StringTree and returns a String consisting of all the labels of the leaves
; (ignoring the nodes) concatenated together.
; (define (st-s st) ...)

(check-expect (st-s (make-leaf "f")) "f")
(check-expect (st-s (make-node "f" (list (make-leaf "u")))) "u")

(define (st-s st)
  (cond
    [(leaf? st) (leaf-label st)]
    [(node? st) (concat-list (node-kids st))]))

; concat-list : [ListOf StringTree] -> String

(define (concat-list lst)
  (cond
    [(empty? lst) ""]
    [else (string-append (st-s (first lst))
              (concat-list (rest lst)))]))

; Exercise 16.

; short-st : StringTree -> StringTree
; returns a StringTree that shortens each label to just its first letter.
; (define (short-st st) ...)

(check-expect (short-st (make-leaf "abcd")) (make-leaf "a"))
(check-expect (short-st (make-node "abcd" empty)) (make-node "a" empty))

(define (short-st st)
  (cond
    [(leaf? st) (make-leaf (string-ith (leaf-label st) 0))]
    [(node? st) (make-node (string-ith (node-label st) 0) (short-lst (node-kids st)))]))

(define (short-lst lst)
  (cond
    [(empty? lst) empty]
    [else (cons (short-st (first lst)) (short-lst (rest lst)))]))

; Exercise 21.

; A SelectTree is one of:
; - (make-done)
; - (make-select Number SelectTree)
(define-struct done [])
(define-struct select [chosen remain])

(define st1 (make-select 69 (make-done)))
(define st2 (make-select 69 (make-select 420 (make-done)))) 

; select-tree-result : SelectTree -> [ListOf Number]
; takes a SelectTree and produces the sorted list of numbers.
; (define (select-tree-result st) ...)

(check-expect (select-tree-result st1) (list 69))
(check-expect (select-tree-result (make-select 69 (make-select 420 (make-done)))) (list 69 420))

(define (select-tree-result st)
  (cond
    [(done? st) empty]
    [(select? st) (cons (select-chosen st) (select-tree-result (select-remain st)))]))

; Exercise 23.

; A [NEListOf Number] is one of:
; - (cons Number empty)
; - (cons Number [NEListOf Number])

; smallest-number : [NEListOf Number] -> Number
; takes a non-empty list of numbers and finds the smallest number in it.
; (define (smallest-number nelon) ...)

(check-expect (smallest-number (list 1)) 1)
(check-expect (smallest-number (list 1 2 3)) 1)
(check-expect (smallest-number (list 3 2 1)) 1)

(define (smallest-number nelon)
  (cond
    [(empty? (rest nelon)) (first nelon)]
    [else (min (first nelon) (smallest-number (rest nelon)))]))

; Exercise 24.

; remove-number : [NEListOf Number] Number -> [ListOf Number]
; takes a non-empty list of numbers and a number in it,
; and removes the given number to produce a shorter list.
; If the given number occurs multiple times in the given list, then remove the first
; occurrence only.
; (define (remove-number nelon n) ...)

(check-expect (remove-number (list 1 2 3) 1) (list 2 3))
(check-expect (remove-number (list 1) 1) (list))

;(define (remove-number nelon n)
;  (cond
;    [(empty? (rest nelon)) ...]
;    [else ...]))

(define (remove-number nelon n)
  (cond
    [(empty? (rest nelon)) (cond
                             [(= n (first nelon)) empty]
                             [else nelon])]
    [else (cond
            [(= n (first nelon)) (rest nelon)]
            [else (cons (first nelon) (remove-number (rest nelon) n))])]))

; Exercise 25.

; generate-select-tree : [ListOf Number] -> SelectTree
; creates a selecttree out of a list of numbers
; (define (generate-select-tree lon) ...)

(check-expect (generate-select-tree (list 1 2 3))
              (make-select 1 (make-select 2 (make-select 3 (make-done))))) 

(define (generate-select-tree lon)
  (cond
    [(empty? lon) (make-done)]
    [else (make-select (smallest-number lon)
                       (generate-select-tree (remove-number lon (smallest-number lon))))]))

; Exercise 26.

; gst->str : [ListOf Number] -> [ListOf Number]
; takes a unsorted list of numbers and sorts it
; (define (gst->str lon) ...)

(check-expect (gst->str (list 3 2 1)) (list 1 2 3))
(check-expect (gst->str (list 1 2 3)) (list 1 2 3))

(define (gst->str lon) (select-tree-result (generate-select-tree lon)))




  









                    






                            







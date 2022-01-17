;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1.

; A NaturalNumber is one of:
; - 0
; - (+ 1 NaturalNumber)

; power : Number NaturalNumber -> Number
; design an exponent function x^n
; (define (power x n) ...)

(check-expect (power 10 3) 1000)
(check-expect (power 2 10) 1024)
(check-expect (power 1.1 4) 1.4641)

;(define (power x n)
;  (cond [(= n 0) ...]
;        [else ...]))

(define (power x n)
  (cond [(= n 0) 1]
        [else (* x (power x (- n 1)))]))

; Exercise 2.

(time (power 1.0001 10000))

; Exercise 3.

; A PowerTree is one of:
; - (make-zeroth)
; - (make-oddth  PowerTree)
; - (make-eventh PowerTree)
(define-struct zeroth [])
(define-struct oddth  [sub1])
(define-struct eventh [half])

; power-tree-exponent : PowerTree -> NaturalNumber
; returns the meaning of the given PowerTree

(check-expect (power-tree-exponent (generate-power-tree 10000)) 10000)

(define (power-tree-exponent pt)
  (cond [(zeroth? pt) 0]
        [(oddth?  pt) (+ 1 (power-tree-exponent (oddth-sub1  pt)))]
        [(eventh? pt) (* 2 (power-tree-exponent (eventh-half pt)))]))

; generate-power-tree : NaturalNumber -> PowerTree
; takes a natural number and decomposes it into a PowerTree
; (define (generate-power-tree n) ...)

(check-expect (generate-power-tree 0)
              (make-zeroth))
(check-expect (generate-power-tree 1)
              (make-oddth (make-zeroth)))
(check-expect (generate-power-tree 2)
              (make-eventh (make-oddth (make-zeroth))))
(check-expect (generate-power-tree 4)
              (make-eventh (make-eventh (make-oddth (make-zeroth)))))
(check-expect (generate-power-tree 8)
              (make-eventh (make-eventh
               (make-eventh (make-oddth (make-zeroth))))))
(check-expect (generate-power-tree 9)
              (make-oddth (make-eventh (make-eventh
               (make-eventh (make-oddth (make-zeroth)))))))

; TERMINATION ARGUMENT: this function always stops.

(define (generate-power-tree n)
  (cond [(= n 0) (make-zeroth)]
        [(odd? n) (make-oddth (generate-power-tree (- n 1)))]
        [(even? n) (make-eventh (generate-power-tree (/ n 2)))]))

; Exercise 4.

; power-tree-result : Number PowerTree -> Number
; takes a number x and a PowerTree pt and returns the number
; that is x raised to the (power-tree-exponent pt)-th power.
; (define (power-tree-result x pt) ...)

(check-expect (power-tree-result 1 (generate-power-tree 1000)) 1)
(check-expect (power-tree-result 2 (generate-power-tree 4)) 16)
(check-expect (power-tree-result 3 (generate-power-tree 2)) 9)

(define (power-tree-result x pt)
  (cond [(zeroth? pt) 1]
        [(oddth? pt) (* x (power-tree-result x (oddth-sub1 pt)))]
        [(eventh? pt) (sqr (power-tree-result x (eventh-half pt)))]))

; Exercise 5.

; fast-power : Number NaturalNumber -> Number
; takes a number x and a natural number n and returns the number that is x raised to the n-th power.
; (define (fast-power x n) ...)

(check-expect (fast-power 2 2) 4)
(check-expect (fast-power 1 1000) 1)
(check-expect (fast-power 3 2) 9)

(define (fast-power x n)
  (power-tree-result x (generate-power-tree n)))

; Exercise 6.

(time (fast-power 1.0001 10000))

; Exercise 7.

; A DNATree is one of:
; - (make-end)
; - (make-run 1String NaturalNumber DNATree)
(define-struct end [])
(define-struct run [base count rest])


; generate-encoding : String -> DNATree
; DNA string as input and decomposes its encoding problem into a DNATree
; (define (generate-encoding s) ...)

(check-expect (bullshit "AAAABBB") "BBB")
(check-expect (bullshit "AAAACBBB") "CBBB")

(define (bullshit s)
  (cond
    [(= (string-length s) 1) ""]
    [(string=? (substring s 0 1) (substring s 1 2)) (bullshit (substring s 1))]
    [else (substring s 1)]))

(check-expect (generate-encoding "AAAAAAAAAAGCCCCC")
              (make-run "A" 10 (make-run "G" 1 (make-run "C" 5 (make-end)))))
(check-expect (generate-encoding "")
              (make-end))

(define (generate-encoding s)
        (cond [(string=? s "") (make-end)]
              [else (make-run (substring s 0 1) (- (string-length s) (string-length (bullshit s)))
                              (generate-encoding (bullshit s)))]))


                                                










;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A CurveTree is one of:
; - (make-segment Posn Posn)
; - (make-connect CurveTree CurveTree)
(define-struct segment [p1 p2])
(define-struct connect [c1 c2])

; Exercise 1.

(require 2htdp/image)
; draw-curve-tree : CurveTree Image -> Image
; Draw the given CurveTree on the given image
(define (draw-curve-tree c i)
  (cond [(segment? c)
         (scene+line i
                     (posn-x (segment-p1 c))
                     (posn-y (segment-p1 c))
                     (posn-x (segment-p2 c))
                     (posn-y (segment-p2 c))
                     "blue")]
        [(connect? c)
         (draw-curve-tree (connect-c1 c)
                          (draw-curve-tree (connect-c2 c)
                                           i))]))

(define background (empty-scene 200 200))

(define dct1 (make-segment (make-posn 10 10) (make-posn 20 20)))
(define dct2 (make-connect dct1 (make-segment (make-posn 20 20) (make-posn 30 30))))
(define dct3 (make-connect dct2 (make-segment (make-posn 30 30) (make-posn 40 40))))

; Exercise 2.

; midpoint : Posn Posn -> Posn
; takes two Posns as input and returns the Posn that is their midpoint.
; (define (midpoint p1 p2) ...)

(check-expect (midpoint (make-posn 50 100) (make-posn 350 500)) (make-posn 200 300))
(check-expect (midpoint (make-posn 0 0) (make-posn 10 0)) (make-posn 5 0))
(check-expect (midpoint (make-posn 10 10) (make-posn 20 20)) (make-posn 15 15))

;(define (midpoint p1 p2) (make-posn (... (+ (posn-x p1) (posn-x p2)) 2)
;                                    (... (+ (posn-y p1) (posn-y p2)) 2)))

(define (midpoint p1 p2) (make-posn (/ (+ (posn-x p1) (posn-x p2)) 2)
                                    (/ (+ (posn-y p1) (posn-y p2)) 2)))

; Exercise 3.

; almost-midpoint : Posn Posn Number Number -> Posn
; takes two Posns and two Numbers as input and returns the Posn
; that is almost the midpoint of the given Posns,
; except with the given Numbers added to the X and Y coordinates.
; (define (almost-midpoint p1 p2 n1 n2) ...)

(check-expect (almost-midpoint (make-posn 50 100) (make-posn 350 500) -1 2)
              (make-posn 199 302))
(check-expect (almost-midpoint (make-posn 50 100) (make-posn 350 500) 0 0)
              (make-posn 200 300))
(check-expect (almost-midpoint (make-posn 10 10) (make-posn 20 20) 5 5)
              (make-posn 20 20))

;(define (almost-midpoint p1 p2 n1 n2)
;  (make-posn (... (/ (+ (posn-x p1) (posn-x p2)) 2) n1)
;             (... (/ (+ (posn-y p1) (posn-y p2)) 2) n2)))

(define (almost-midpoint p1 p2 n1 n2)
  (make-posn (+ (/ (+ (posn-x p1) (posn-x p2)) 2) n1)
             (+ (/ (+ (posn-y p1) (posn-y p2)) 2) n2)))

; Exercise 4.

; drift : Number -> Number
; pick a random number between (- amount) and amount
(check-random (drift 5) (- (/ (random 10001) 1000) 5))
(define (drift amount)
  (* amount (- (/ (random 10001) 5000) 1)))

; (drift 100) takes something
; (drift 2) takes something

; Exercise 5.

; between : Posn Posn -> Posn
; takes two Posns as input and returns a Posn that is almost their midpoint,
; but randomly moved a little bit.
; (define (between p1 p2) ...)

(check-random (between (make-posn 50 100) (make-posn 350 500))
              (make-posn (+ 200 (drift 100)) (+ 300 (drift 100))))
(check-random (between (make-posn 50 80) (make-posn 60 80))
              (make-posn (+ 55 (drift 2)) (+ 80 (drift 2))))

(define (between p1 p2)
  (almost-midpoint p1 p2 (drift (* 0.2 (dist p1 p2)))  (drift (* 0.2 (dist p1 p2)))))
  
; dist : Posn Posn -> Number
; compute the distance between the given Posns
(check-expect (dist (make-posn 50 100) (make-posn 350 500)) 500)
(check-expect (dist (make-posn 50 80) (make-posn 60 80)) 10)
(define (dist p q)
  (sqrt (+ (sqr (- (posn-x p) (posn-x q)))
           (sqr (- (posn-y p) (posn-y q))))))

; Exercise 6.

; generate-terrain : Posn Posn -> CurveTree
; generate a random terrain connecting the two given points
; *Termination*: The function decreased the distance between two point,
;   and stops when the distance between them is less than 1. 

(define (generate-terrain p q)
  (cond [(< (dist p q) 1)
         (make-segment p q)]
        [else
         (local [; r : Posn
                 (define r (between p q))]
           (make-connect (generate-terrain p r)
                         (generate-terrain r q)))]))

; sum : [ListOf Number] -> Number
; sums the numbers in the given list
(define (sum lon)
  (local [; sum/a : [ListOf Number] Number -> Number
          ; adds the numbers in the list one by one to the second argument
          ; *Accumulator*: sum-so-far is the sum of numbers seen so far
          ;
          ; examples:
          ;   lon                 sum-so-far     output
          ; ------------------------------------------------------
          ;   (list 1 2 3 4 5)              0    (+ 0 1 2 3 4 5)
          ;   (list 2 3 4 5)       0 + 1 =  1    (+ 0 1 2 3 4 5)
          ;   (list 3 4 5)         1 + 2 =  3    (+ 0 1 2 3 4 5)
          ;   (list 4 5)           3 + 3 =  6    (+ 0 1 2 3 4 5)
          ;   (list 5)             6 + 4 = 10    (+ 0 1 2 3 4 5)
          ;   empty               10 + 5 = 15    (+ 0 1 2 3 4 5)
          ;
          (define (sum/a lon sum-so-far)
            (cond [(empty? lon) sum-so-far]
                  [else (sum/a (rest lon)
                               (+ (first lon) sum-so-far))]))]
    (sum/a lon 0)))
(check-expect (sum (list 1 2 3 4 5)) (+ 0 1 2 3 4 5))

; Exercise 7.

; sum/a : [ListOf Number] Number -> Number
; Adds up the elements in a list
; (define (sum/a lon so-far) ...)

(check-expect (sum/a (list 1 2 3 4 5) 0)
              15)
(check-expect (sum/a (list 2 3 4 5) 1)
              15)
(check-expect (sum/a (list 3 4 5) 3)
              15)
(check-expect (sum/a (list 4 5) 6)
              15)
(check-expect (sum/a (list 5) 10)
              15)
(check-expect (sum/a empty 15)
              15)

;ACCUMULATOR : so-far is the current total number that it has added so far.
(define (sum/a lon so-far)
  (cond [(empty? lon) so-far]
        [else (sum/a (rest lon)
                     (+ so-far (first lon)))]))

; Exercise 8

(check-expect (alternating-sum empty) 0)
(check-expect (alternating-sum (list 1 4 9 16 9 7 4 9 11))
              (+ 1 -4 9 -16 9 -7 4 -9 11))

; alternating-sum/a : [ListOf Numbers] Boolean Number -> Number
; sums up the list, but each odd element subtracts instead of adding up.
; (define (alternating-sum/a lon subtract sum-so-far) ...)

(check-expect (alternating-sum/a (list 1 4 9 16 9 7 4 9 11) false 0) -2)
(check-expect (alternating-sum/a (list 4 9 16 9 7 4 9 11) true 1) -2)
(check-expect (alternating-sum/a (list 9 16 9 7 4 9 11) false -3) -2)
(check-expect (alternating-sum/a (list 16 9 7 4 9 11) true 6) -2)
(check-expect (alternating-sum/a (list  9 7 4 9 11) false -10) -2)
(check-expect (alternating-sum/a (list  7 4 9 11) true -1) -2)
(check-expect (alternating-sum/a (list  4 9 11) false -8) -2)
(check-expect (alternating-sum/a (list  9 11) true -4) -2)
(check-expect (alternating-sum/a (list 11) false -13) -2)
(check-expect (alternating-sum/a empty true -2) -2)

; *Accumulator*: subtract is whether to subtract rather than add the next number
; *Accumulator*: sum-so-far is the sum of numbers seen so far

(define (alternating-sum/a lon subtract sum-so-far)
  (cond [(empty? lon) sum-so-far]
        [subtract (alternating-sum/a (rest lon) false (- sum-so-far (first lon)))]
        [else (alternating-sum/a (rest lon) true (+ sum-so-far (first lon)))]))

; alternating-sum : [ListOf Number] -> Number
; sums up the list, but each odd element subtracts instead of adding up.
; (define (alternating-sum lon) ...)

(define (alternating-sum lon)
  (alternating-sum/a lon false 0))

; Exercise 9.

(check-expect (funky empty) empty)
(check-expect (funky (explode "Computer Science")) (explode "CoMpUtEr sCiEnCe"))

; examples:
;   letters                         capitalize    output
; ------------------------------------------------------------------------------
;   (explode "Computer Science")    true          (explode "CoMpUtEr sCiEnCe")
;   (explode  "omputer Science")    false         (explode  "oMpUtEr sCiEnCe")
;   (explode   "mputer Science")    true          (explode   "MpUtEr sCiEnCe")
;   (explode    "puter Science")    false         (explode    "pUtEr sCiEnCe")
;   (explode     "uter Science")    true          (explode     "UtEr sCiEnCe")
;   (explode      "ter Science")    false         (explode      "tEr sCiEnCe")
;   (explode       "er Science")    true          (explode       "Er sCiEnCe")
;   (explode        "r Science")    false         (explode        "r sCiEnCe")
;   (explode         " Science")    true          (explode         " sCiEnCe")
;   (explode          "Science")    false         (explode          "sCiEnCe")
;   (explode           "cience")    true          (explode           "CiEnCe")
;   (explode            "ience")    false         (explode            "iEnCe")
;   (explode             "ence")    true          (explode             "EnCe")
;   (explode              "nce")    false         (explode              "nCe")
;   (explode               "ce")    true          (explode               "Ce")
;   (explode                "e")    false         (explode                "e")
;   (explode                 "")    true          (explode                 "")

; funky : [ListOf 1String] -> [ListOf 1String]
; the output should alternate between upper-case and lower-case.
; (define (funky los) ...)

(define (funky los) (funky/a los true empty))

; funky/a : [ListOf 1String] Boolean String -> [ListOf 1String]
; converts the list into its funky form
; (define (funky/a los capital so-far) ...)

(check-expect (funky/a (explode "cat") false empty) (explode "cAt"))
(check-expect (funky/a (explode "at") true (explode "c")) (explode "cAt"))
(check-expect (funky/a (explode "t") false (explode "cA")) (explode "cAt"))

;ACCUMULATORS : capital is a boolean to check whether the next 1String is going to be a capital letter
;               so-far is the list of the strings that has finished processing so far.

(define (funky/a los capital so-far)
  (cond [(empty? los) so-far]
        [capital (funky/a (rest los) false (append so-far (list (string-upcase (first los)))))]
        [else (funky/a (rest los) true (append so-far (list (string-downcase (first los)))))]))

; Exercise 10.

(check-expect (sentence empty) empty)
(check-expect (sentence (explode "hey. whats up")) (explode "Hey. Whats up"))

; sentence : [ListOf 1String] -> [ListOf 1String]
; outputs a sentence-like list of 1strings
; (define (sentence los) ...)

; examples:
;   letters                      capitalize    output
; ------------------------------------------------------------------------
;   (explode "hey. whats up")    true          (explode "Hey. Whats up")
;   (explode  "ey. whats up")    false         (explode  "ey. Whats up")
;   (explode   "y. whats up")    false         (explode   "y. Whats up")
;   (explode    ". whats up")    false         (explode    ". Whats up")
;   (explode     " whats up")    true          (explode     " Whats up")
;   (explode      "whats up")    true          (explode      "Whats up")
;   (explode       "hats up")    false         (explode       "hats up")
;   (explode        "ats up")    false         (explode        "ats up")
;   (explode         "ts up")    false         (explode         "ts up")
;   (explode          "s up")    false         (explode          "s up")
;   (explode           " up")    false         (explode           " up")
;   (explode            "up")    false         (explode            "up")
;   (explode             "p")    false         (explode             "p")
;   (explode              "")    false         (explode              "")

(define (sentence los)
  (sentence/a los true empty))

; sentence/a : [ListOf 1String] Boolean [ListOf 1String] -> [ListOf 1String]
; outputs a sentence-like list of 1strings
; (define (sentence/a los capital so-far) ...)

;ACCUMULATORS : capital is a boolean to check whether the next 1String is going to be a capital letter
;               so-far is the list of the strings that has finished processing so far.

(check-expect (sentence/a (explode "i. aa") true empty) (explode "I. Aa"))
(check-expect (sentence/a (explode ". aa") false (explode "I")) (explode "I. Aa"))
(check-expect (sentence/a (explode " aa") true (explode "I.")) (explode "I. Aa"))
(check-expect (sentence/a (explode "aa") true (explode "I. ")) (explode "I. Aa"))
(check-expect (sentence/a (explode "a") false (explode "I. A")) (explode "I. Aa"))
(check-expect (sentence/a empty true (explode "I. Aa")) (explode "I. Aa"))

(define (sentence/a los capital so-far)
  (cond [(empty? los) so-far]
        [(string=? "." (first los)) (sentence/a (rest los) true (append so-far (list (first los))))]
        [(and (string=? " " (first los))
              capital) (sentence/a (rest los) true (append so-far (list (first los))))]
        [capital (sentence/a (rest los) false (append so-far (list (string-upcase (first los)))))]
        [else (sentence/a (rest los) false (append so-far (list (first los))))]))

; Exercise 11

; overdrawn? : [ListOf Numbers] -> Boolean
; checks if an account has ever become negative.
; (define (overdrawn? lon) ...)

(check-expect (overdrawn? (list 20 100 -80)) false)
(check-expect (overdrawn? (list 20 -80 100)) true)
(check-expect (overdrawn? (list 100 -80 20)) false)

(define (overdrawn? lon)
  (overdrawn/a lon 0))

;ACCUMULATOR : so-far is the current bank balance.
(define (overdrawn/a lon so-far)
  (cond
    [(empty? lon) false]
    [(negative? so-far) true]
    [else (overdrawn/a (rest lon) (+ so-far (first lon)))]))





















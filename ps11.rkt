;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ps11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Bracket is one of:
; - Team
; - (make-bracket Bracket Bracket)
(define-struct bracket [left right])
 
; A Team is String

(define bracket1 (make-bracket "Bucknell" "Michigan St"))
(define bracket2 (make-bracket "TCU" (make-bracket "Syracuse"
                                                   "Arizona St")))
(define bracket3 (make-bracket bracket1 bracket2))

(define teams3
  (list "Arizona St" "Michigan St" "TCU" "Bucknell" "Syracuse"))
(define teams1 (list "Michigan St" "Bucknell"))
(define teams2 (list "Arizona St" "TCU" "Syracuse"))

; Exercise 1.

; odds : [NEListOf Team] -> [NEListOf Team]
; takes out strings at odd number into another list
; (define (odds nel) ...)

(check-expect (odds  teams3) teams1)
(check-expect (odds  empty ) empty )
(check-expect (evens teams3) teams2)
(check-expect (evens empty ) empty )
(check-expect (odds  (list "a" "b" "c" "d")) (list "b" "d"))
(check-expect (evens (list "a" "b" "c" "d")) (list "a" "c"))

;(define (odds nel)
;  (cond
;    [(empty? nel) ...]
;    [else (... (rest nel))]))

(define (odds nel)
  (cond
    [(empty? nel) empty]
    [else (evens (rest nel))]))

;(define (evens nel)
;  (cond
;    [(empty? nel) ...]
;    [else (cons (first nel) (... (rest nel)))]))

(define (evens nel)
  (cond
    [(empty? nel) empty]
    [else (cons (first nel) (odds (rest nel)))]))

; Exercise 2.

; generate-bracket : [NEListOf Team] -> Bracket
; takes a nonempty list of Teams and generates a Bracket.
; (define (generate-bracket nel) ...)

;termination: this stops when the list goes empty

(check-expect (generate-bracket teams3) bracket3)

;(define (generate-bracket nel)
;  (cond
;    [(empty? (rest nel)) ...]
;    [(cons? (rest nel)) (... (generate-bracket (odds nel))
;                                      (generate-bracket (evens nel)))]))

(define (generate-bracket nel)
  (cond
    [(empty? (rest nel)) (first nel)]
    [(cons? (rest nel)) (make-bracket (generate-bracket (odds nel))
                                      (generate-bracket (evens nel)))]))

; Exercise 3.

; An Outcome is one of:
; - Team
; - (make-outcome Outcome Winner Outcome)
(define-struct outcome [left winner right])
 
; A Winner is one of:
; - "left"
; - "right"

(define outcome3
  (make-outcome (make-outcome "Bucknell"
                              "left"
                              "Michigan St")
                "right"
                (make-outcome "TCU"
                              "left"
                              (make-outcome "Syracuse"
                                            "left"
                                            "Arizona St"))))

; champion : Outcome -> Team
; tells the champion team from an outcome
; (define (champion o) ...)

(check-expect (champion outcome3) "TCU")

;(define (champion o)
;  (cond
;    [(team? o) ...]
;    [(outcome? o) (cond
;                    [(string=? (outcome-winner o) "left") (...(champion (outcome-left o)))]
;                    [(string=? (outcome-winner o) "right") (...(champion (outcome-right o)))])]))

(define (champion o)
  (cond
    [(string? o) o]
    [(outcome? o) (cond
                    [(string=? (outcome-winner o) "left") (champion (outcome-left o))]
                    [(string=? (outcome-winner o) "right") (champion (outcome-right o))])]))

; Exercise 4.

; fake-outcome : Bracket -> Outcome
; takes a Bracket and produces a corresponding Outcome
; in which the team with the shorter name always wins.
; (define (fake-outcome b) ...)

(check-expect (fake-outcome bracket3) outcome3)

;(define (fake-outcome b)
;  (cond [(string? b) ...]
;        [(bracket? b)
;         (cond [(= (string-length (... (fake-outcome (bracket-left b))))
;                   (string-length (... (fake-outcome (bracket-right b)))))
;                (make-outcome (fake-outcome (bracket-left b))
;                              "right"
;                              (fake-outcome (bracket-right b)))]
;               [(> (string-length (... (fake-outcome (bracket-left b))))
;                   (string-length (... (fake-outcome (bracket-right b)))))
;                (make-outcome (fake-outcome (bracket-left b))
;                              "right"
;                              (fake-outcome (bracket-right b)))]
;               [(< (string-length (... (fake-outcome (bracket-left b))))
;                   (string-length (... (fake-outcome (bracket-right b)))))
;                (make-outcome (fake-outcome (bracket-left b))
;                              "left"
;                              (fake-outcome (bracket-right b)))])]))

(define (fake-outcome b)
  (cond [(string? b) b]
        [(bracket? b)
         (cond
;           [(= (string-length (champion (fake-outcome (bracket-left b))))
;                   (string-length (champion (fake-outcome (bracket-right b)))))
;                (make-outcome (fake-outcome (bracket-left b))
;                              "right"
;                              (fake-outcome (bracket-right b)))]
               [(>= (string-length (champion (fake-outcome (bracket-left b))))
                   (string-length (champion (fake-outcome (bracket-right b)))))
                (make-outcome (fake-outcome (bracket-left b))
                              "right"
                              (fake-outcome (bracket-right b)))]
               [(< (string-length (champion (fake-outcome (bracket-left b))))
                   (string-length (champion (fake-outcome (bracket-right b)))))
                (make-outcome (fake-outcome (bracket-left b))
                              "left"
                              (fake-outcome (bracket-right b)))])]))

; A Trip is [ListOf Step]
 
; A Step is one of:
; - (make-draw Number)
; - (make-turn Number)
; - (make-fork Trip)
; *Interpretation*: angle is how many degrees to turn right
(define-struct draw [distance])
(define-struct turn [angle])
(define-struct fork [child])

; Exercise 5.

; generate-spiral : Number -> Trip
; takes a Number as input and generates a Trip that alternates between drawing and turning.
; (define (generate-spiral n) ...)

; *Termination* goes off when the draw-distance becomes the less than 1.

(check-expect
 (generate-spiral 64)
 (list (make-draw 64)                        (make-turn -30)
       (make-draw 48)                        (make-turn -30)
       (make-draw 36)                        (make-turn -30)
       (make-draw 27)                        (make-turn -30)
       (make-draw 20.25)                     (make-turn -30)
       (make-draw 15.1875)                   (make-turn -30)
       (make-draw 11.390625)                 (make-turn -30)
       (make-draw  8.54296875)               (make-turn -30)
       (make-draw  6.4072265625)             (make-turn -30)
       (make-draw  4.805419921875)           (make-turn -30)
       (make-draw  3.60406494140625)         (make-turn -30)
       (make-draw  2.7030487060546875)       (make-turn -30)
       (make-draw  2.027286529541015625)     (make-turn -30)
       (make-draw  1.52046489715576171875)   (make-turn -30)
       (make-draw  1.1403486728668212890625) (make-turn -30)
       (make-draw  0.855261504650115966796875)))

(check-expect
 (generate-spiral 0.6)
 (list (make-draw  0.6)))

;(define (generate-spiral n)
;  (cond
;    [(< n 1) ...]
;    [else (... (list
;                        (make-draw n)
;                        (make-turn -30))
;                       (generate-spiral (* n 0.75)))]))

(define (generate-spiral n)
  (cond
    [(< n 1) (list (make-draw n))]
    [else (append (list
                        (make-draw n)
                        (make-turn -30))
                       (generate-spiral (* n 0.75)))]))

; Exercise 6.

; generate-tree : Number -> Trip
; takes a Number as input and generates a Trip just like generate-spiral does,
; but adds a fork before each turn.
; (define (generate-tree n) ...)

(check-expect
 (generate-tree 2)
 (list (make-draw 2)
       (make-fork (list (make-turn 20)
                        (make-draw 1)
                        (make-fork (list (make-turn 20)
                                         (make-draw 0.5)))
                        (make-turn -30)
                        (make-draw 0.75)))
       (make-turn -30)
       (make-draw 1.5)
       (make-fork (list (make-turn 20) (make-draw 0.75)))
       (make-turn -30)
       (make-draw 1.125)
       (make-fork (list (make-turn 20) (make-draw 0.5625)))
       (make-turn -30)
       (make-draw 0.84375)))
(check-expect
 (generate-tree 1)
 (list (make-draw 1)
       (make-fork (list (make-turn 20)
                        (make-draw 0.5)))
       (make-turn -30)
       (make-draw 0.75)))
(check-expect
 (generate-tree 0.6)
 (list (make-draw 0.6)))

;(define (generate-tree n)
;  (cond
;    [(< n 1) ...]
;    [else (append (list (make-draw n) 
;                        (make-fork (... (list (make-turn 20))
;                                           (generate-tree (* n .50)))) 
;                        (make-turn -30))
;                  (generate-tree (* n .75)))]))

(define (generate-tree n)
  (cond
    [(< n 1) (list (make-draw n))]
    [else (append (list (make-draw n) 
                        (make-fork (append (list (make-turn 20))
                                           (generate-tree (* n .50)))) 
                        (make-turn -30))
                  (generate-tree (* n .75)))]))

; Exercise 7.

; generate-koch : Number -> Trip
;  takes a Number as input and generates a Koch curve.
; (define (generate-koch n) ...)

; *termination* it ends when the number becomes less than 1

(check-expect
 (generate-koch 0.6)
 (list (make-draw 0.6)))
(check-expect
 (generate-koch 1.8)
 (list (make-draw 0.6) (make-turn 60)
       (make-draw 0.6) (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6)))
(check-expect
 (generate-koch 5.4)
 (list (make-draw 0.6) (make-turn 60)
       (make-draw 0.6) (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6)                  (make-turn 60)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6) (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6)                  (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6) (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6)                  (make-turn 60)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6) (make-turn -120)
       (make-draw 0.6) (make-turn 60)
       (make-draw 0.6)))

;(define (generate-koch n)
;  (cond
;    [(< n 1) ...]
;    [else (... (generate-koch (/ n 3))
;                        (list (make-turn 60))
;                        (generate-koch (/ n 3))
;                        (list (make-turn -120))
;                        (generate-koch (/ n 3))
;                        (list (make-turn 60))
;                        (generate-koch (/ n 3)))]))

(define (generate-koch n)
  (cond
    [(< n 1) (list (make-draw n))]
    [else (append (generate-koch (/ n 3))
                        (list (make-turn 60))
                        (generate-koch (/ n 3))
                        (list (make-turn -120))
                        (generate-koch (/ n 3))
                        (list (make-turn 60))
                        (generate-koch (/ n 3)))]))
                        
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Exercise 1. 
; A Wagon is one of:
;  - (make-passenger-wagon Company)
;  - (make-freight-wagon String Number)
 
; A Company is one of:
;  - "Alstom"
;  - "Bombardier"
 
(define-struct passenger-wagon (model))
(define-struct freight-wagon (destination axles))

(define wagon1 (make-passenger-wagon "Alstom"))
(define wagon2 (make-passenger-wagon "Bombardier"))
(define wagon3 (make-freight-wagon "here" 10))

; Exercise 2.

; make-passenger-wagon: model -> Wagon
; make-freight-wagon: String Number -> Wagon
; passenger-wagon-model: Wagon -> model
; freight-wagon-destination: Wagon -> destination
; freight-wagon-axles: Wagon -> axles
; passenger-wagon?: Anything -> Boolean
; freight-wagon?: Anything -> Boolean

; Exercise 3.

;(define (process-wagon w)
;  (cond [(passenger-wagon? w)
;         (... (passenger-wagon-model w) ...)]
;        [(freight-wagon? w)
;         (... (freight-wagon-destination w) ... (freight-wagon-axles w) ...)]))
; 
;(define (process-company c)
;  (cond [(string=? c "Alstom")
;         ...]
;        [(string=? c "Bombardier")
;         ...]))

; Exercise 4.

; It does.

; Exercise 5.

; wagon-weight Wagon -> Number
; computes the weight of the wagon
; (define (wagon-weight w) ...)

(check-expect (wagon-weight wagon1) 45)
(check-expect (wagon-weight wagon2) 60)
(check-expect (wagon-weight wagon3) 60)

;(define (wagon-weight w) (cond
;                           [ (passenger-wagon? w) (cond
;                                                    [(string=? "Alstom"
;                                                               (passenger-wagon-model w)) ...]
;                                                    [(string=? "Bombardier"
;                                                               (passenger-wagon-model w)) ...])]
;                           [ (freight-wagon? w) (... (freight-wagon-axles w)...)]))

(define (wagon-weight w) (cond
                           [ (passenger-wagon? w) (cond
                                                    [(string=? "Alstom" (passenger-wagon-model w)) 45]
                                                    [(string=? "Bombardier"
                                                               (passenger-wagon-model w)) 60])]
                           [ (freight-wagon? w) (* 6 (freight-wagon-axles w))]))

; Exercise 6.

; A Shuttle is one of:
; - (make-none)
; - (make-one Wagon)
; - (make-two Wagon Wagon)

(define-struct none())
(define-struct one (first))
(define-struct two (first second))

; Exercise 7.

(define shuttle1 (make-none))
(define shuttle2 (make-one wagon1))
(define shuttle3 (make-two wagon2 wagon3))

; Exercise 8.

; make-none: None -> Shuttle
; none?: Anything -> Boolean

; make-one: Wagon -> Shuttle
; one-first: Shuttle -> Wagon
; one?: Anything -> Boolean

; make-two: Wagon Wagon -> Shuttle
; two-first: Wagon -> Shuttle
; two-second: Wagon -> Shuttle
; two?: Anything -> Boolean

; Exercise 9.

;(define (process-shuttle s)
;  (cond [(none? s)
;         (...)]
;        [(one? s) (... (one-first s) ...)]
;        [(two? s)
;         (... (two-first s) ... (two-second s) ...)]))

; Exercise 10.

; Yes it does.

; Exercise 11.

; shuttle-weight: Shuttle -> Number
; computes the weight of each shuttle
; (define (shuttle-weight s) ...)

(check-expect (shuttle-weight shuttle1) 130)
(check-expect (shuttle-weight shuttle2) 175)
(check-expect (shuttle-weight shuttle3) 250)

;(define (shuttle-weight s) (cond
;                             [(none? s) 130]
;                             [(one? s) (... 130 (wagon-weight wagon1)]
;                             [(two? s) (... 130 (wagon-weight wagon2) (wagon-weight wagon2))]))

(define (shuttle-weight s) (cond
                             [(none? s) 130]
                             [(one? s) (+ 130 (wagon-weight wagon1))]
                             [(two? s) (+ 130 (wagon-weight wagon2) (wagon-weight wagon2))]))

; Exercise 12.

; A World is a Ring
; A Ring is one of:
; (make-no-ring )
; (make-one-ring Number Number)

(define-struct no-ring [])
(define-struct one-ring [radius x y])

; Exercise 13.

(define ring1 (make-no-ring))
(define ring2 (make-one-ring 10 10 10))
(define ring3 (make-one-ring 20 20 20))

; Exercise 14.

;( define (process-world r)
;   (cond
;     [(no-ring? r) ...]
;     [(one-ring? r) (... (one-ring-radius r) ...
;                        (one-ring-x r) ...
;                        (one-ring-y r) ...)]))

; Exercise 15.

; draw-ring: Ring -> Image
; it takes a ring and displays it in a big-bang function
; (define (draw-ring r) ...)

(define background (empty-scene 300 300))

(check-expect (draw-ring ring1) background)
(check-expect (draw-ring ring2) (place-image (circle (one-ring-radius ring2) "outline" "red")
                                             (one-ring-x ring2) (one-ring-y ring2)
                                             background))
(check-expect (draw-ring ring3) (place-image (circle (one-ring-radius ring3) "outline" "red")
                                             (one-ring-x ring3) (one-ring-y ring3)
                                             background))

(define (draw-ring r)
  (cond
    [(no-ring? r) background]
    [(one-ring? r) (place-image (circle (one-ring-radius r) "outline" "red")
                                (one-ring-x r) 
                                (one-ring-y r)
                                background)]))

; Exercise 15.

; modify-ring: Ring Number Number MouseEvent -> Ring

(check-expect (modify-ring ring1 100 100 "button-down") (make-one-ring 1 100 100))
(check-expect (modify-ring ring1 100 100 "move") ring1)
(check-expect (modify-ring ring2 100 100 "button-down") (make-one-ring 11 100 100))
(check-expect (modify-ring ring2 100 100 "move") ring2)

(define (modify-ring r x y me)
  (cond
    [(no-ring? r)
     (cond
       [(string=? me "button-down") (make-one-ring 1 x y)]
       [ else r])]
    [(one-ring? r)
     (cond
       [(string=? me "button-down") (make-one-ring (+ 1 (one-ring-radius r)) x y)]
       [else r])]))

(big-bang ring1
  [to-draw draw-ring]
  [on-mouse modify-ring])

















                                                    




  

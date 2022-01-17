;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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






;;; Lab 5 upthere



; Exercise 1.

; A TrainOfWagons is one of:
; - (make-none)
; - (make-some Wagon TrainOfWagons)

(define-struct none ())
(define-struct some (first rest))

; Exercise 2.

(define w1 (make-some wagon1 (make-none)))
(define w2 (make-some wagon1 (make-some wagon2 (make-none))))
(define w3 (make-some wagon1 (make-some wagon2 (make-some wagon3 (make-none)))))
 
; Exercise 3.

; make-none
; none?
; mkae-some
; some-first
; some-rest
; some?

; Exercise 4.

(define (process-train-of-wagons t)
  (cond [(none? t)
         (...)]
        [(some? t)
         (...(some-first t) process-train-of-wagons (some-rest t))]))

; Exercise 5.

; yes it does

; Exercise 6.

; yes it does

; Exercise 7.

; train-length: TrainOfWagon -> Numbers
; takes trainofwagons and computes the number of wagons
; (define (train-length t) ...)

(check-expect (train-length w1) 1)
(check-expect (train-length w2) 2)
(check-expect (train-length w3) 3)

;(define (train-length w)
;  (cond
;    [(none? w) (...)]
;    [(some? w) (... train-length(some-rest t) ...)]))

(define (train-length w)
  (cond
    [(none? w) 0]
    [(some? w) (+ 1 (train-length (some-rest w)) )]))

; Exercise 8.

; train-weight: TrainOfWagon -> Number
; takes trainofwagons and computes the weight of wagons
; (define (train-weight w) ...)

(check-expect (train-weight w1) 175)
(check-expect (train-weight w2) 235)
(check-expect (train-weight w3) 295)

;(define (train-weight w)
;  (cond
;    [(none? w) ...]
;    [(some? w) (... (wagon-weight (some-first w)) ... (train-weight (some-rest w)))]))

(define (train-weight w)
  (cond
    [(none? w) 130]
    [(some? w) (+ (wagon-weight (some-first w)) (train-weight (some-rest w)))]))

; Exercise 9.

; has-passenger?: TrainOfWagon -> Boolean
; takes train of wagons and tells if a passengen wagon is present
; (define (has-passenger? w) ...)

(check-expect (has-passenger? w1) true)
(check-expect (has-passenger? w2) true)
(check-expect (has-passenger? w3) true)


(define (has-passenger? w)
              (cond
                [(none? w) ...]
                [(some? w) (cond
                             [(passenger-wagon? (some-first w)) true]
                             [else (has-passenger? (some-rest w))])]))

; Exercise 10.

; freight-only: TrainOfWagons -> TrainOfWagons
; removes the passenger wagons
; (define (freight-only w) ...)

(check-expect (freight-only w1) (make-none))
(check-expect (freight-only w2) (make-none))
(check-expect (freight-only w3) (make-some wagon3 (make-none)))

;(define (freight-only w)
;  (cond
;    [(none? w) ...]
;    [(some? w) (cond
;                 [(passenger-wagon? (some-first w)) ...]
;                 [ else (make-some (some-first w) ...)])]))

(define (freight-only w)
  (cond
    [(none? w) w]
    [(some? w) (cond
                 [(passenger-wagon? (some-first w)) (freight-only (some-rest w))]
                 [ else (make-some (some-first w) (freight-only (some-rest w)))])]))

; Exercise 11

; A World is one of:
; (make-no-ring)
; (make-one-ring Number Number)
; (make-some-ring Ring World)
(define-struct no-ring ())
(define-struct one-ring (x y r))
(define-struct some-ring (ring rest))

(define world1 (make-no-ring))
(define world2 (make-one-ring 10 10 4))
(define world3 (make-one-ring 40 100 10))

(define scene (empty-scene 400 400 "white"))

;;;DRAW;;;

;draw-ring: World -> Image
;Draws a Ring in a world.
;(define (draw-ring ring)...)

;(define (draw-ring ring)
;  (cond [(no-ring? ring) ...]
;        [(one-ring? ring) ...(one-ring-r ring)...(one-ring-x ring)...(one-ring-y ring)]))

(define (draw-ring ring)
  (cond [(no-ring? ring) scene]
        [(one-ring? ring)
         (place-image (circle (one-ring-r ring) "outline" "red") (one-ring-x ring) (one-ring-y ring)
                               (draw-ring (some-ring-rest ring)))]
        [(some-ring? ring)
         (place-image (circle (one-ring-r (some-ring-ring ring)) "outline" "red")
                      (one-ring-x (some-ring-ring ring)) (one-ring-y (some-ring-ring ring))
                               (draw-ring (some-ring-rest ring)))]))

;All 3 tests have passed.

;;;DRAW;;;

;;;MOUSE EVENT;;;

;modify-ring: Ring Number Number MouseEvent -> Image
;Changes the location of the ring by mouse event -> Image
;(define (modify-ring ring x y me)...)

;(define (modify-ring ring x y me)
;  (cond [(no-ring? ring)
;         (cond
;           [(string=? me "button-down") ...]
;           [else ...])]
;        [(one-ring? ring)
;         (cond
;           [(string=? me "button-down") ...]
;           [else ...])]))

(define (modify-ring ring x y me)
  (cond [(no-ring? ring)
         (cond
           [(string=? me "button-down") (make-some-ring (make-one-ring x y 1) (make-no-ring))]
           [else ring])]
        [(one-ring? ring)
         (cond
           [(string=? me "button-down")
            (make-some-ring (make-one-ring x y (+ 1 (one-ring-r ring))) ring)]
           [else ring])]
        [(some-ring? ring)
         (cond
           [(string=? me "button-down")
            (make-some-ring (make-one-ring x y (+ 1 (one-ring-r (some-ring-ring ring)))) ring)]
           [else ring])]))

;All tests have passed.

;;;MOUSE EVENT;;;

; Exercise 12

;the-on-tick: World -> World
; Moves the world up
; (define (the-on-tick ring) ...)

(define (the-on-tick ring)
  (cond
    [(no-ring? ring) ring]
    [(one-ring? ring)
     (make-one-ring (one-ring-x ring) (+ 1 (one-ring-y ring)) (one-ring-r ring))]
    [(some-ring? ring)
     (make-some-ring (the-on-tick (some-ring-ring ring)) (the-on-tick (some-ring-rest ring)))]))


(big-bang world1
  (to-draw draw-ring)
  (on-mouse modify-ring)
  (on-tick the-on-tick))












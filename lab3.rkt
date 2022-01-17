;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;Exercise 1


; 1. Data Definitions
; A Boolean is one of:
; - true
; - false
; Examples:
;   true
;   false
; Non-examples:
;   "true"
;   0

; 2. Signature, Purpose and Header
; fever : Number -> Boolean
; returns whether a given Fahrenheit thermometer reading indicates a fever
; (greater than 100 degrees)
; (define (fever t) ...)

; 3. Function Examples
(check-expect (fever 98) false)
(check-expect (fever 100) false)
(check-expect (fever 100.1) true)
(check-expect (fever 105) true)

; 4. Function Template
;(define (fever t) (cond [(> t 100) ...]
;                        [else ...]))


; 5. Function Definition
(define (fever t) (cond [(> t 100) true]
                        [else false]))
; 6. Testing
; All tests have been passed.

;Exercise 2

; 1. Data Definitions
; A Boolean is one of:
; - true
; - false
; Examples:
;   true
;   false
; Non-examples:
;   "true"
;   0

; 2. Signature, Purpose and Header
; instructor: String -> Boolean
; check whether the lab instructor is correct
; (define (instructor i) ...)

; 3. Function Examples
(check-expect (instructor "Sita") true)
(check-expect (instructor "Rama") true)
(check-expect (instructor "Ravana") false)

; 4. Function Template
;(define (instructor i) (cond [(string=? i "Sita") ...]
;                             [(string=? i "Rama") ...]
;                             [(string=? i "Ravana") ...]

; 5. Function Definition
(define (instructor i)
  (cond
     [(string=? i "Sita") true]
     [(string=? i "Rama") true]
     [(string=? i "Ravana") false]))

; 6. Testing
; All tests have been passed.

;Exercise 3
; Needs to define the data definiitions of Wobble.

;Exercise 4

; A Department is one of:
; - "biology"
; - "business"
; - "computer science"
; - "English"

;-: expected a function call, but there is no open parenthesis before this function

;Exercise 5

; A suit-of-cards is one of:
; - "clubs"
; - "diamonds"
; - "hearts"
; - "spades"

;Exercise 6

; The rainbow-color is one of:
; - hot pink
; - red
; - orange
; - yellow
; - green
; - turquoise
; - indigo
; - violet

; Exercise 7

; A shape is one of:
; - triangle
; - rectangle
; - pentagon
; - hexagon

;Exercise 8

;(define suit-of-cards "clubs")
;(define suit-of-cards "diamonds")

;Exercise 9

;(define rainbow-color "hot pink")
;(define rainbow-color "red")

; Exercise 10

;(define shape "triangle")
;(define shape "rectangle")

; Exercise 11

;(define dans-department "geology")

; Not an example of a Department

; this variable definiton is executed properly and the string "geology" is assigned to variable
; dans-department, because the enumerations are commented out and are not enforced by the Beginning
; Student Language

; Exercise 12

; (define rainbow-color "white")
; (define rainbow-color "black")

; Exercise 13

; (define shape "circle")
; (define shape "square")

; Exercise 14

; draw-department : Department -> Image
; displays the department as image text
; (define (draw-department d) ...)

; This is a function header because it lacks the content of how the function should work, as of now
; only the function variable has been defined

; Exercise 15

; Both the template and data definitons have 4 cases
; They are both equal for every input to get an output

; Exercise 16

;( define ( suit-of-cards s) (cond
;                              [ (string=? s "clubs") ...]
;                              [ (string=? s "diamonds") ...]
;                              [ (string=? s "spades") ...]
;                              [ (string=? s "hearts") ...]))

; Exercise 17

;( define (rainbow-color r) (cond
;                             [ (string=? r "hot pink") ...]
;                             [ (string=? r "red") ...]
;                             [ (string=? r "orange") ...]
;                             [ (string=? r "yellow") ...]
;                             [ (string=? r "green") ...]
;                             [ (string=? r "turquoise") ...]
;                             [ (string=? r "indigo") ...]
;                             [ (string=? r "violet") ...]))

; Exercise 18

;(define (shape s) (cond
;                    [ (string=? s "triangle") ...]
;                    [ (string=? s "rectangle") ...]
;                    [ (string=? s "pentagon") ...]
;                    [ (string=? s "hexagon") ...]      

; Exercise 19

; the designed function has 4 templates and 4 examples
; both of them are equal in order to check the function

; Exercise 20

; 1. Data Definitions
; A suit-of-cards is one of:
; - "clubs"
; - "diamonds"
; - "hearts"
; - "spades"

; 2. Signature, Purpose and Header
; suit-points: String -> Number
; to calculate points of every type of card
; (define ( suit-points s) ...)

; 3. Function Examples
(check-expect (suit-points "clubs") 1)
(check-expect (suit-points "diamonds") 2)
(check-expect (suit-points "hearts") 3)
(check-expect (suit-points "spades") 4)

; 4. Function Template
;( define ( suit-points s) (cond
;                              [ (string=? s "clubs") ...]
;                              [ (string=? s "diamonds") ...]
;                              [ (string=? s "spades") ...]
;                              [ (string=? s "hearts") ...]))

; 5. Function Definition
( define ( suit-points s) (cond
                              [ (string=? s "clubs") 1]
                              [ (string=? s "diamonds") 2]
                              [ (string=? s "hearts") 3]
                              [ (string=? s "spades") 4]))

; 6. Testing
; All tests passed

; 1. Data Definitions
; The rainbow-color is one of:
; - hot pink
; - red
; - orange
; - yellow
; - green
; - turquoise
; - indigo
; - violet

; 2. Signature, Purpose and Header
; next-color: Strinf -> String
; to take a color(string) as input and output the next color(string)
; (define (next-color r) ...)

; 3. Function Examples
(check-expect (next-color "hot-pink") "red")
(check-expect (next-color "red") "orange")
(check-expect (next-color "orange") "yellow")
(check-expect (next-color "yellow") "green")
(check-expect (next-color "green") "turquoise")
(check-expect (next-color "turquoise") "indigo")
(check-expect (next-color "indigo") "violet")
(check-expect (next-color "violet") "hot-pink")

; 4. Function Template
;( define (next-color r) (cond
;                             [ (string=? r "hot pink") ...]
;                             [ (string=? r "red") ...]
;                             [ (string=? r "orange") ...]
;                             [ (string=? r "yellow") ...]
;                             [ (string=? r "green") ...]
;                             [ (string=? r "turquoise") ...]
;                             [ (string=? r "indigo") ...]
;                             [ (string=? r "violet") ...]))

; 5. Function Definition
( define (next-color r) (cond
                             [ (string=? r "hot-pink") "red"]
                             [ (string=? r "red") "orange"]
                             [ (string=? r "orange") "yellow"]
                             [ (string=? r "yellow") "green"]
                             [ (string=? r "green") "turquoise"]
                             [ (string=? r "turquoise") "indigo"]
                             [ (string=? r "indigo") "violet"]
                             [ (string=? r "violet") "hot-pink"]))


; 6. Testing
; All tests passed

; Exercise 22

; 1. Data Definitions
; A shape is one of:
; - triangle
; - rectangle
; - pentagon
; - hexagon

; 2. Signature, Purpose and Header
; side-count: String -> Number
; to count the sides of different shapes
; (define (side-count s) ...)

; 3. Function Examples
(check-expect (side-count "triangle") 3)
(check-expect (side-count "rectangle") 4)
(check-expect (side-count "pentagon") 5)
(check-expect (side-count "hexagon") 6)

; 4. Function Template
;(define (side-count s) (cond
;                    [ (string=? s "triangle") ...]
;                    [ (string=? s "rectangle") ...]
;                    [ (string=? s "pentagon") ...]
;                    [ (string=? s "hexagon") ...]

; 5. Function Definition
(define (side-count s) (cond
                    [ (string=? s "triangle") 3]
                    [ (string=? s "rectangle") 4]
                    [ (string=? s "pentagon") 5]
                    [ (string=? s "hexagon") 6]))

; 6. Testing
; All tests passed



;Exercise 23
(define background (rectangle 956 400 "solid" "black"))

; Exercise 24
(define epigraph1 "A long time ago in a galaxy far,")
(define epigraph2 "far away....")
(define story-text
  (above (text "It is a period of civil war." 40 "yellow")
         (text "Rebel spaceships, striking"   40 "yellow")
         (text "lorem ipsum dolor sit"        40 "yellow")))

(define epigraph-text (above (text epigraph1 40 "blue") (text epigraph2 40 "lightblue")))
(define shot1 (overlay epigraph-text background))

; Exercise 25

( define (shot3 s) (overlay (above (text "STAR" s "yellow") (text "WARS" s "yellow")) background))

;Exercise 26
; A Time is one of:
; - a number less than 150
; - a number at least 150 and less than 200
; - a number at least 200 and less than 300
; - a number at least 300
 
; star-wars : Time -> Image
; returns the image at the given frame number
; in our Star Wars opening crawl
; (define (star-wars t) ...)
(check-expect (star-wars   0) shot1)
(check-expect (star-wars 100) shot1)
(check-expect (star-wars 149) shot1)
(check-expect (star-wars 150) background)
(check-expect (star-wars 199) background)
(check-expect (star-wars 200) (shot3 200))
(check-expect (star-wars 299) (shot3 2))
(check-expect (star-wars 300) (place-image story-text (/ 956 2) 470 background))
(check-expect (star-wars 350) (place-image story-text (/ 956 2) 420 background))
(check-expect (star-wars 400) (place-image story-text (/ 956 2) 370 background))

(define (star-wars t)
  (cond [(< t 150) shot1]
        [(< t 200) background]
        [(< t 300) (shot3(- 200 (* (- t 200) 2)))]
        [else (place-image story-text (/ 956 2) (- (+ t 170) (* 2 (- t 300))) background)]))

(animate star-wars)















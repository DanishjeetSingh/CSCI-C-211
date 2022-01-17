;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Exercise 1.

; The longitude and latitude change, and the last stop/ heading to are also changing.
; The Bus route and number are not changing.

; Exercise 2.

(require 2htdp/json)
 
; read-json/web : String -> JSON
; Retrieves the remote file at the given URL and returns JSON data
 
; read-json/file : String -> JSON
; Retrieves the local file with the given name and returns JSON data

; Exercise 3.

; information is a bit different

; A JSON is one of:
; - String
; - Number
; - [ListOf JSON]
; - (make-object [ListOf Member])
; (define-struct object [members])
 
; A Member is (make-member String JSON)
; (define-struct member [name value])

; Exercise 4.

; IS a JSON :
; (make-object (list make-member "lat" #i39.17601))
; 1

; NOT a JSON :
; (make-member "lat" #i39.17601)
; (make-member "name" "665")

; Exercise 5.

; parse : Anything -> JSON
; Ignore the input. Retrieve bus data.
(define (parse whatever)
  (read-json/web "http://iub.doublemap.com/map/v2/buses"))

; Exercise 6.

(define sample-bus-posns
  (list
   (make-posn -86.52805 39.18395)
   (make-posn -86.52836 39.18398)
   (make-posn -86.50961 39.17321)
   (make-posn -86.52168 39.16847)
   (make-posn -86.51697 39.18409)
   (make-posn -86.52782 39.1801)))

;FROM PS9. -------------------------

(define (convert a1 b1 a2 b2 a)
  (/ (+ (* b1 (- a2 a)) (* b2 (- a a1))) (- a2 a1)))
(define marker (circle 5 "solid" "red"))
(define width 300)
(define height 300)
(define background (empty-scene width height))
(define-struct world [xmin xmax ymin ymax])


(define (draw-lop lop)
  (foldr (lambda (p img) (place-image marker (posn-x p) (posn-y p) img)) background lop))

(define (cartesian->screen w lop) (map (lambda (l) (make-posn
                                                    (convert
                                                     (world-xmin w) 0
                                                     (world-xmax w) width (posn-x l))
                                                    (convert
                                                     (world-ymin w) height
                                                     (world-ymax w) 0 (posn-y l))))lop))

(define bloomington-view
  (make-world -86.5725 -86.4725 39.1150 39.2150))

; draw : [ListOf Posns] -> Image
; draw the buses location on the bus
; (define (draw lop) ...)

(define (draw lop)
  (draw-lop (cartesian->screen bloomington-view lop)))

; Exercise 7.

(draw sample-bus-posns)

; Exercise 8.

; lookup : String [ListOf Member] -> JSON
; looks up a given String name in a given [ListOf Member] and returns the corresponding JSON value.
; If there is no Member whose name is the given String, there should be an error,
; which you should test using check-error.
; (define (lookup s lom) ...)

(define lom1 (list
               (make-member "name" "671")
               (make-member "bus_type" "bus")
               (make-member "lastStop" 10)
               (make-member "lat" #i39.16419)
               (make-member "id" 100417)
               (make-member "lastUpdate" 1638542011)
               (make-member "fields" (make-object '()))
               (make-member "route" 787)
               (make-member "heading" 2)
               (make-member "lon" #i-86.51637)))

(check-within (lookup "lat" lom1) 39.16419 0.1)
(check-within (lookup "lon" lom1) -86.51637 0.1)
(check-error (lookup "dik" lom1) "first: expects a non-empty list; given: '()")

(define (lookup s lom)
  (cond
;    [(empty? lom) empty]
    [(string=? (member-name (first lom)) s) (member-value (first lom))]
    [else (lookup s (rest lom))]))

; Exercise 9.

; project : JSON -> [ListOf Posn]
; The Earth coordinates in each input object should become an output Posn:
; the longitude coordinate in the input should become the x coordinate in the output,
; and the latitude coordinate in the input should become the y coordinate in the output.
; (define (project j) ...)

(define json1 (list  (make-object (list
               (make-member "name" "680")
               (make-member "bus_type" "bus")
               (make-member "lastStop" 76)
               (make-member "lat" 39.18004)
               (make-member "id" 100437)
               (make-member "lastUpdate" 1638542742)
               (make-member "fields" (make-object '()))
               (make-member "route" 819)
               (make-member "heading" 157)
               (make-member "lon" -86.52784)))))

(check-expect (project json1) (list (make-posn -86.52784 39.18004)))

(define (project j)
  (map (lambda (x)
         (make-posn (lookup "lon" (object-members x))
                    (lookup "lat" (object-members x)))) j))

; Exercise 10.

; change : Anything -> [ListOf Posn]
; combination of project and parse
; (define (change a) ...)

(define (change a)
  (project (parse a)))

(big-bang (project (parse 1))
  (to-draw draw)
  (on-tick change 3))






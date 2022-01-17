;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; Exercise 2.

; A SearchTree is one of:
; - (make-not-found)
; - (make-try SearchTree String SearchTree)
(define-struct not-found [])
(define-struct try [left middle right])

(define neighbors (make-try (make-try (make-try (make-try (make-not-found)
                                                          "Brown" (make-not-found))
                                                "Greene" (make-not-found))
                                      "Jackson" 
                            (make-try (make-not-found) "Johnson" (make-not-found)))
                            "Lawrence"
                            (make-try (make-try (make-try (make-not-found)
                                                                    "Martin" (make-not-found))
                                                          "Monroe" (make-not-found))
                                                "Morgan"
                                                (make-try (make-not-found)
                                                          "Owen"
                                                          (make-not-found)))))

; Exercise 3.

; search-tree-contains? : String SearchTree -> Boolean
; determines whether the given SearchTree contains the given string.
; (define (search-tree-contains? st s) ...)

(check-expect (search-tree-contains? "dik" (make-try (make-not-found) "dik" (make-not-found))) true)
(check-expect (search-tree-contains? "Monroe" neighbors) true)
(check-expect (search-tree-contains? "dik" neighbors) false)

(define (search-tree-contains? s st)
  (cond
    [(not-found? st) false]
    [(string=? s (try-middle st)) true]
    [else (or (search-tree-contains? s (try-left st))
          (search-tree-contains? s (try-right st)))]))

; Exercise 4.

; take : {X} NaturalNumber [ListOf X] -> [ListOf X]
; take the first that-many elements of the list
(check-expect (take 2 (list "almond" "pecan" "walnut" "pistachio"))
              (list "almond" "pecan"))
(define (take n l)
  (cond [(or (= n 0) (empty? l)) empty]
        [else (cons (first l) (take (- n 1) (rest l)))]))

; left-half : [ListOf X] -> [ListOf X]
; takes a list as input and returns its first half.
; (define (left-half lx) ...)

(check-expect (left-half (list 1 2 3 4 5 6 7 8 9)) (list 1 2 3 4))

(define (left-half lx) (take (floor (/ (length lx) 2)) lx))

; Exercise 5.

; drop : {X} NaturalNumber [ListOf X] -> [ListOf X]
; drop the first that-many elements of the list
(check-expect (drop 2 (list "almond" "pecan" "walnut" "pistachio"))
              (list "walnut" "pistachio"))
(define (drop n l)
  (cond [(or (= n 0) (empty? l)) l]
        [else (drop (- n 1) (rest l))]))

; middle-element : [ListOf X] -> [ListOf X]
; takes a list as input and returns its middle element
; (define (middle-element lx) ...)

(check-expect (middle-element (list 1 2 3 4)) 3)
(check-expect (middle-element (list 1 2 3 4 5)) 3)

(define (middle-element lx) (first (drop (floor (/ (length lx) 2)) lx)))

; Exercise 6.

; right-half : [ListOf X] -> [ListOf X]
; takes a list as input and returns its second half without its middle element.
; (define (right-half lx) ...)

(check-expect (right-half (list 1 2 3 4)) (list 4))
(check-expect (right-half (list 1 2 3 4 5)) (list 4 5))

(define (right-half lx) (rest (drop (floor (/ (length lx) 2)) lx)))

; Exercise 7.

; generate-search-tree : [ListOf String] -> [ListOf String]
;  decomposes a given [ListOf String] into a SearchTree.
; (define (generate-search-tree ls) ...)

(check-expect (generate-search-tree (list "A" "B" "C"))
 (make-try (make-try (make-not-found) "A" (make-not-found))
           "B"
           (make-try (make-not-found) "C" (make-not-found))))

(define (generate-search-tree ls)
  (cond [(empty? ls) (make-not-found)]
        [else (make-try (generate-search-tree (left-half ls))
                        (middle-element ls)
                        (generate-search-tree (right-half ls)))]))

; Exercise 8.

(define counties (read-lines "counties.txt"))
(define county-tree (generate-search-tree counties))

(check-expect  (search-tree-contains? "Monroe" county-tree) true)
(check-expect  (search-tree-contains? "Decatur" county-tree) true)
(check-expect  (search-tree-contains? "Middlesex" county-tree) false)

                        
                                              
    
  

                                                                     
                            
                                      
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ps10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A PrefixForest is a [NEListOf PrefixTree]
 
; A PrefixTree is one of:
; - (make-end)
; - (make-initial 1String PrefixForest)
 
(define-struct end [])
(define-struct initial [letter forest])
 
; A 1String a String of length 1

(define forest1
  (list
   (make-initial "n"
                 (list
                  (make-end)
                  (make-initial "e" (list (make-end)))))
   (make-initial "f"
                 (list
                  (make-end)
                  (make-initial "f" (list (make-end)))
                  (make-initial "t" (list (make-end)))))
   (make-initial "r" (list (make-end)))))

(define forest2
  (list
   (make-initial "f"
                 (list
                  (make-end)
                  (make-initial "u" (list (make-end)))))
   (make-initial "c"
                 (list
                  (make-end)
                  (make-initial "k" (list (make-end)))))
   (make-end)))

(define forest3
  (list (make-end)))
   
                 
         

(define tree1 (make-initial "o" forest1))

; Exercise 1.

(define tree2 (make-initial "f" forest2))
(define tree3 (make-initial "l" forest3))

; Exercise 2.

;(define (process-tree t)
;  (cond
;    [(end? t) ...]
;    [(initial? t) (initial-letter t) ... (process-forest (initial-forest t))]))
;
;(define (process-forest t)
;  (cond [(empty? t) ...]
;        [else (...(process-tree (first t)) (process-forest (rest t)))]))

; Exercise 3.

; tree-size : PrefixTree -> Number
; counts the number of strings in a tree
; (define (tree-size t) ...)

(check-expect (tree-size tree1) 6)
(check-expect (tree-size tree2) 5)
(check-expect (tree-size tree3) 1)

;(define (tree-size t)
;  (cond
;    [(end? t) ...]
;    [else (forest-size (initial-forest t) ...)]))

(define (tree-size t)
  (cond
    [(end? t) 1]
    [else (forest-size (initial-forest t))]))

; forest-size : PrefixForest -> Number
; counts the number of strings in a tree in a forest.
; (define (forest-size t) ...)

(check-expect (forest-size forest1) 6)

;(define (forest-size t)
;  (cond
;    [(empty? t) ...]
;    [else (... (tree-size (first t)) (forest-size (rest t)))]))

(define (forest-size t)
  (cond
    [(empty? t) 0]
    [else (+ (tree-size (first t)) (forest-size (rest t)))]))

; Exercise 4

; tree->list: tree -> [NEListOf Strings] 
; to return the list of all the charaters in the tree
; (define (tree->list t) ...)

; (define (tree->list t)
;   (cond[(end? t) ...]
;        [else (... (initial-letter t) (forest->list (initial-forest t)))]))

(check-expect (tree->list tree1) (list "on" "one" "of" "off" "oft" "or"))
(check-expect (tree->list tree2) (list "ff" "ffu" "fc" "fck" "f"))
(check-expect (tree->list tree3) (list "l"))

(define (help-list l lf ltf)
  (cond[(empty? lf) empty]
       [else (append (list (string-append l (first lf)))
                     (help-list l (rest lf) ltf))]))

(define (tree->list t)
  (cond[(end? t) (list "")]
       [else (help-list (initial-letter t) (forest->list (initial-forest t)) empty)]))

; forest->list: forest -> [NEListOf Stirngs]
; to return the list of all the charaters in the forest
; (define (forest->list t) ...)

(check-expect(forest->list forest1) (list "n" "ne" "f" "ff" "ft" "r"))
(check-expect(forest->list forest2) (list "f" "fu" "c" "ck" ""))
(check-expect(forest->list forest3) (list ""))

; (define (forest->list f)
;   (cond[(empty? f) ...]
;        [else (... (tree->list (first f)) (forest->list (rest f)))]))

(define (forest->list f)
  (cond[(equal? (rest f) empty) (tree->list (first f))]
       [else (append (tree->list (first f)) (forest->list (rest f)))]))

; Exercise 5

; a Word is a [ListOf 1String]

; word->tree: word -> PrefixTree
; to convert a word to prefix tree
; (define (word->tree w) ...)

(check-expect (word->tree (explode "phuck"))
              (make-initial
               "p"
               (list
                (make-initial
                 "h"
                 (list
                  (make-initial
                   "u"
                   (list
                    (make-initial
                     "c"
                     (list
                      (make-initial
                       "k"
                       (list
                        (make-end))))))))))))
(check-expect (word->tree (explode "ohyeah")) (make-initial
                                               "o"
                                               (list
                                                (make-initial
                                                 "h" (list
                                                      (make-initial
                                                       "y" (list
                                                            (make-initial
                                                             "e" (list
                                                                  (make-initial
                                                                   "a" (list
                                                                        (make-initial
                                                                         "h" (list
                                                                              (make-end))))))))))))))
              
; (define (word->tree w)
;   (cond[(...) (make-end)]
;        [(...) (make-initial (first w) (word->forest (rest w)))]))

(define (word->tree w)
  (cond[(empty? w) (make-end)]
       [else (make-initial (first w) (list (word->tree (rest w))))]))

; Exercise 6

; word-in-tree: PrefixTree Word -> Boolean
; to return is the given word is in the tree
; (define (word-in-tree t) ...)

(check-expect (word-in-tree tree1 (explode "of")) #true)
(check-expect (word-in-tree tree2 (explode "cash")) #false)
(check-expect (word-in-tree tree3 (explode "cash")) #false)

;(define (word-in-tree t w)
;  (cond[(empty? w) ...]
;       [(end? t) ...]
;       [(string=? (initial-letter t) (first w)) (word-in-forest ...)]
;       [else ...]))

(define (word-in-tree t w)
  (cond[(empty? w) true]
       [(end? t) false]
       [(string=? (initial-letter t) (first w)) (word-in-forest (initial-forest t) (rest w))]
       [else false]))

; word-in-forest: PrefixForest Word -> Boolean
; to return is the given word is in the tree
; (define (word-in-forest t) ...)

(check-expect  (word-in-forest forest1 (explode "ne")) #true)
(check-expect  (word-in-forest forest2 (explode "money")) #false)
(check-expect  (word-in-forest forest3 (explode "money")) #false)

;(define (word-in-forest f w)
;  (cond[(empty? f) ...]
;       [else (... (word-in-tree (first f) w)
;                 (word-in-forest (rest f) w))]))

(define (word-in-forest f w)
  (cond[(empty? f) false]
       [else (or (word-in-tree (first f) w)
                 (word-in-forest (rest f) w))]))

; Exercise 7
; add-to-forest : Word PrefixForest -> PrefixForest
; adds the word to the forest, returning a new forest.
; (deifne (add-to-forest w pf) ...)

(check-expect (add-to-tree (explode "oops") tree1)
              (make-initial
               "o"
               (list
                (make-initial "n" (list (make-end) (make-initial "e" (list (make-end)))))
                (make-initial "f" (list (make-end) (make-initial "f" (list (make-end)))
                                        (make-initial "t" (list (make-end)))))
                (make-initial "r" (list (make-end)))
                (make-initial "o" (list (make-initial "p" (list (make-initial "s"
                                                                              (list
                                                                               (make-end))))))))))

(check-expect (add-to-tree (explode "bruh") tree2)
              (make-initial
               "f"
               (list
                (make-initial "f" (list (make-end) (make-initial "u" (list (make-end)))))
                (make-initial "c" (list (make-end) (make-initial "k" (list (make-end)))))
                (make-end)
                (make-initial "r" (list (make-initial "u" (list (make-initial "h"
                                                                              (list
                                                                               (make-end))))))))))
(check-expect (add-to-tree (explode "four") tree3)
              (make-initial
               "l"
               (list (make-end)
                     (make-initial "o"
                                   (list (make-initial "u"
                                                       (list (make-initial "r"
                                                                           (list
                                                                            (make-end))))))))))
                                               
(define (add-to-forest w pf)
  (cond [(empty? pf) (list (word->tree w))]
        [(cons? pf) (cond [(and (end? (first pf))
                                 (empty? w)) pf]
                          [(and (initial? (first pf))
                                (not (empty? w))
                                (string=? (initial-letter (first pf)) (first w)))
                           (cons (add-to-tree w (first pf)) (rest pf))]
                          [else (cons (first pf) (add-to-forest w (rest pf)))])]))
                                                       
   
; add-to-tree : Word PrefixTree -> PrefixTree
(check-expect (add-to-tree (explode "fu")
                           (make-initial "f"
                                         (list
                                          (make-end))))
              (make-initial "f"
                            (list
                             (make-end)
                             (make-initial "u"
                                           (list
                                            (make-end))))))

;(define (add-to-tree w pt)
;  (cond [(end? pt) ...]
;        [(initial? pt) (... (initial-letter pt)
;                                     (add-to-forest (rest w) (initial-forest pt)))]))

(define (add-to-tree w pt)
  (cond [(end? pt) pt]
        [(initial? pt) (make-initial (initial-letter pt)
                                     (add-to-forest (rest w) (initial-forest pt)))]))

; Exercise 8
; list->forest : [NEListOf String] -> PrefixForest
; takes a [NEListOf String] and returns a
; PrefixForest that stores the given words (given as strings this time)
; (define (list->forest nes) ...)

(check-expect (list->forest (list "oh" "yeah"))
              (list
               (make-initial "y"
                             (list
                              (make-initial "e"
                                            (list
                                             (make-initial "a"
                                                           (list
                                                            (make-initial "h"
                                                                          (list (make-end)))))))))
               (make-initial "o" (list (make-initial "h" (list (make-end)))))))
(check-expect (list->forest (list "hey" "lo"))
              (list (make-initial "l" (list (make-initial "o" (list (make-end)))))
                    (make-initial "h"
                                  (list (make-initial "e"
                                                      (list (make-initial "y" (list (make-end)))))))))
;(define (list->forest nes)
;  (cond [(empty? nes) ...]
;        [else (add-to-forest (... (first nes))
;                        (list->forest (rest nes)))]))

(define (list->forest nes)
  (cond [(empty? nes) empty]
        [else (add-to-forest (explode (first nes))
                        (list->forest (rest nes)))]))

             




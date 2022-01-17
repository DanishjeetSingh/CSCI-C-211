;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ps7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; An FT (short for family tree) is one of:
; - (make-no-parent)
; - (make-child FT FT String N String)
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

; Exercise1.
; my distant friend Johnny

; Exercise2.
(define Johnny (make-child (make-no-parent) (make-no-parent ) "Johnny" 1978 "Blue"))

; Exercise 3.
; Johnny has 3 siblings which cannot be represented in this data definition.

; Exercise 4.

; A 1String a String of length 1
 
; rot13 : 1String -> 1String
; returns the letter 13 spaces ahead in the alphabet
; (define (rot13 letter) ...)

(check-expect (rot13 "a") "n")
(check-expect (rot13 "A") "N")
(check-expect (rot13 "n") "a")
(check-expect (rot13 "N") "A")
(check-expect (rot13 " ") " ")

(define (rot13 letter)
  (cond
    [(or (and (string<=? "a" letter) (string<=? letter "m"))
         (and (string<=? "A" letter) (string<=? letter "M")))
     (int->string (+ (string->int letter) 13))]
    [(or (and (string<=? "n" letter) (string<=? letter "z"))
         (and (string<=? "N" letter) (string<=? letter "Z")))
     (int->string (- (string->int letter) 13))]
    [else letter]))

; Exercise 5.

; A Listof1Strings is one of:
; - empty
; - (cons 1String Listof1Strings)

(define l1 (cons "c" '()))
(define l2 (cons "b" l1))
(define l3 (cons "a" l2))

;(define (process-Listof1Strings s)
;  (cond
;    [(empty? s) ...]
;    [(cons? s)
;     (...(first s)...(process-Listof1Strings (rest s)))]))

; Exercise 6.

; combine-1strings: Listof1Strings -> String
; takes a Listof1Strings returns a single string
; (define (combine-1strings s) ...)

(check-expect (combine-1strings l1) "c ")
(check-expect (combine-1strings l2) "bc ")
(check-expect (combine-1strings l3) "abc ")

;(define (combine-1strings s)
;  (cond
;    [(empty? s) ...]
;    [(cons? s)
;     (string-append...(cons-first s)...(combine-1strings (process-Listof1Strings (cons-rest s))))]))

(define (combine-1strings s)
  (cond
    [(empty? s) " "]
    [(cons? s) (string-append (first s) (combine-1strings (rest s)))]))

; Exercise 7.
; so we have an entire exercise where we have to download 5 .txt files *slow claps*

; Exercise 8.

; convert-to-r13: ListOf1Strings -> ListOf1Strings
; takes ListOf1Strings and runs and encrypts it by using rot-13
; (define (convert-to-r13 s) ...)

(check-expect (convert-to-r13 l1) (cons "p" '()))
(check-expect (convert-to-r13 l2) (cons "o" (cons "p" '())))
(check-expect (convert-to-r13 l3) (cons "n" (cons "o" (cons "p" '()))))

(define (convert-to-r13 s)
  (cond
    [(empty? s) empty]
    [(cons? s) (cons (rot13 (first s)) (convert-to-r13 (rest s)))]))

; Exercise 9.

; file-to-r13: String -> ListOf1Strings
; takes a file name in the string and rotates every 1string in it and returns it in ListOf1Strings.
; (define (file-to-r13 s) ...)

(check-expect (file-to-r13 "secretmsg1.txt")
              (list "M" "e" "e" "t" " " "m" "e" " " "a" "t" " " "m" "i" "d" "n" "i" "g" "h" "t" "."))
(check-expect (file-to-r13 "secretmsg2.txt") (list
 "C"
 "o"
 "n"
 "g"
 "r"
 "a"
 "t"
 "s"
 " "
 "o"
 "n"
 " "
 "d"
 "e"
 "c"
 "r"
 "y"
 "p"
 "t"
 "i"
 "n"
 "g"
 " "
 "t"
 "h"
 "i"
 "s"
 " "
 "m"
 "e"
 "s"
 "s"
 "a"
 "g"
 "e"
 "!"
 " "
 "Y"
 "o"
 "u"
 " "
 "a"
 "r"
 "e"
 " "
 "a"
 "w"
 "e"
 "s"
 "o"
 "m"
 "e"
 "."))
(check-expect (file-to-r13 "secretmsg3.txt")
              (list "C" "o" "m" "p" "u" "t" "e" "r" " " "s" "c" "i" "e" "n" "c" "e" " " "i" "s"
                    " " "a" "w" "e" "s" "o" "m" "e" "." " " "D" "o" "n" "'" "t"
                    " " "y" "o" "u" " " "a" "g" "r" "e" "e" "?"))
(check-expect (file-to-r13 "secretmsg4.txt") (list
 "O"
 "n"
 "c"
 "e"
 " "
 "u"
 "p"
 "o"
 "n"
 " "
 "a"
 " "
 "t"
 "i"
 "m"
 "e"
 ","
 " "
 "a"
 " "
 "l"
 "o"
 "n"
 "g"
 " "
 "t"
 "i"
 "m"
 "e"
 " "
 "a"
 "g"
 "o"
 ","
 " "
 "t"
 "h"
 "e"
 "r"
 "e"
 " "
 "w"
 "a"
 "s"
 " "
 "a"
 " "
 "c"
 "o"
 "m"
 "p"
 "u"
 "t"
 "e"
 "r"
 " "
 "s"
 "c"
 "i"
 "e"
 "n"
 "c"
 "e"
 " "
 "s"
 "t"
 "u"
 "d"
 "e"
 "n"
 "t"
 ","
 "\n"
 "a"
 "l"
 "l"
 " "
 "l"
 "o"
 "n"
 "e"
 "l"
 "y"
 " "
 "a"
 "n"
 "d"
 " "
 "w"
 "i"
 "t"
 "h"
 " "
 "n"
 "o"
 " "
 "p"
 "l"
 "a"
 "c"
 "e"
 " "
 "t"
 "o"
 " "
 "g"
 "o"
 "."
 "\n"
 "B"
 "u"
 "t"
 " "
 "t"
 "h"
 "e"
 "n"
 " "
 "t"
 "h"
 "e"
 "y"
 " "
 "d"
 "i"
 "s"
 "c"
 "o"
 "v"
 "e"
 "r"
 "e"
 "d"
 " "
 "C"
 "2"
 "1"
 "1"
 " "
 "a"
 "n"
 "d"
 " "
 "f"
 "o"
 "u"
 "n"
 "d"
 " "
 "t"
 "h"
 "a"
 "t"
 " "
 "i"
 "t"
 " "
 "w"
 "a"
 "s"
 " "
 "h"
 "e"
 "a"
 "v"
 "e"
 "n"
 "."
 "\n"
 "T"
 "h"
 "i"
 "s"
 " "
 "d"
 "e"
 "s"
 "c"
 "r"
 "i"
 "b"
 "e"
 "s"
 " "
 "m"
 "e"
 ","
 " "
 "b"
 "u"
 "t"
 " "
 "I"
 " "
 "h"
 "o"
 "p"
 "e"
 " "
 "i"
 "t"
 "'"
 "s"
 " "
 "t"
 "h"
 "e"
 " "
 "w"
 "a"
 "y"
 " "
 "y"
 "o"
 "u"
 "'"
 "l"
 "l"
 " "
 "c"
 "o"
 "m"
 "e"
 " "
 "t"
 "o"
 " "
 "b"
 "e"
 "."))
(check-expect (file-to-r13 "secretmsg5.txt")
              (list "C" "o" "n" "g" "r" "a" "t" "s" " " "o" "n" " " "c" "o" "m" "i" "n" "g" " "
                    "s" "o" " " "f" "a" "r" "." " " "W" "e" " " "l" "o" "v" "e" " " "y" "o" "u" "."))

;(define (file-to-r13 s)
;  (... (read-1strings s)...))

(define (file-to-r13 s)
  (convert-to-r13 (read-1strings s)))

; Exercise 10.

; decrypt-file: String -> String
; takes a filename and decrypts it and return it in a single string.
; (define (decrypt-file s)...)

(check-expect (decrypt-file "secretmsg1.txt") "Meet me at midnight. ")
(check-expect (decrypt-file "secretmsg2.txt")
              "Congrats on decrypting this message! You are awesome. ")
(check-expect (decrypt-file "secretmsg3.txt") "Computer science is awesome. Don't you agree? ")       
(check-expect (decrypt-file "secretmsg5.txt") "Congrats on coming so far. We love you. ")

;(define (decrypt-file s) (... (file-to-r13 s)...))

(define (decrypt-file s) (combine-1strings (file-to-r13 s)))

; Exercise 11.

; encypt-string: String -> String
; takes a string turns it into a list encrypts it and makes a string of it again.
; (define (encrypt-string s)...)

(check-expect (encrypt-string "abc") "nop ")
(check-expect (encrypt-string "def") "qrs ")
(check-expect (encrypt-string "ghi") "tuv ")

; (define (encrypt-string s) (...convert-to-r13 (explode s)...))

(define (encrypt-string s) (combine-1strings (convert-to-r13 (explode s))))

; Exercise 12.

;encrypt-string-to-file: String String -> String
;takes a string and a file name to be put in the file and returns the encrypted message
;with the string encrypted into it
; (define (encrypt-string-to-file s1 s2) ...)

(check-expect (encrypt-string-to-file "My name is Danish." "output1.txt") "output1.txt")
(check-expect (encrypt-string-to-file "Today is a good day." "output2.txt") "output2.txt")

;(define (encrypt-string-to-file s1 s2) (...write-file s1 (combine-1strings (encrypt-string s2))...))

(define (encrypt-string-to-file s1 s2) (write-file s2 (encrypt-string s1)))

; Exercise 13.

; remove-<=100: ListOfNumbers -> ListOfNumbers
; takes a lon and removes every number <= 100 and returns a lon
; (define (remove-<=100 s) ...)

(check-expect (remove-<=100 (list 100 69 420)) (list 420))
(check-expect (remove-<=100 (list 100 69 420 6969)) (list 420 6969))

;(define (remove-<=100 s)
;  (cond
;    [(empty? s) ...]
;    [(cons? s) (cond
;                 [(<= (first s) 100) (...remove-<=100 (rest s)...)]
;                 [else (cons (first s) (...remove-<=100 (rest s))...)])]))

(define (remove-<=100 s)
  (cond
    [(empty? s) empty]
    [(cons? s) (cond
                 [(<= (first s) 100) (remove-<=100 (rest s))]
                 [else (cons (first s) (remove-<=100 (rest s)))])]))

; Exercise 14.

; A Frequency is String and Number
(define-struct frequency [word count])

(define f1 (make-frequency "hello" 4))
(define f2 (make-frequency "text" 5))
(define f3 (make-frequency "word" 7))

; Exercise 15.

; A Listof1Strings is one of:
; - empty
; - (cons 1String Listof1Strings)

; A ListofFrequencies is one of:
; - empty
; - (cons Frequency ListofFrequencies)

(define lof1 (list f1))
(define lof2 (list f1 f2))
(define lof3 (list f1 f2 f3))

; Exercise 16.

; count-word : ListofFrequencies String -> ListofFrequencies
; takes a lof and a string and adds 1 to the frequency of the word if it is there,
; else creates a new frequency
; (define (count-word l s) ..)

(check-expect (count-word lof1 "hello") (list (make-frequency "hello" 5)))
(check-expect (count-word lof2 "create") (list f1 f2 (make-frequency "create" 1)))

;(define (count-word l s)
;  (cond
;    [(empty? l) (cons (make-frequency s 1) ...)]
;    [else
;     (cond
;       [(string=? s (frequency-word (first l)))
;        (cons (make-frequency (frequency-word (first l)) (... (frequency-count (first l))...))
;              (rest l))]
;       [else
;        (cons (make-frequency (frequency-word (first l)) (frequency-count (first l)))
;              (count-word (rest l) s)...)])]))

(define (count-word l s)
  (cond
    [(empty? l) (cons (make-frequency s 1) empty)]
    [else
     (cond
       [(string=? s (frequency-word (first l)))
        (cons (make-frequency (frequency-word (first l)) (+ 1 (frequency-count (first l))))
              (rest l))]
       [else
        (cons (make-frequency (frequency-word (first l)) (frequency-count (first l)))
              (count-word (rest l) s))])]))

; Exercise 17.

; A ListofStrings is one of:
; - empty
; - (cons String ListofStrings)

(define los1 (list))
(define los2 (list "hello"))
(define los3 (list "hello" "world"))

; count-all-words : ListOfStrings -> ListOfFrequencies
; takes a los and counts the frequency of every string and creates a lof
; (define (count-all-words l) ...)

(check-expect (count-all-words los1) (list))
(check-expect (count-all-words los2) (list (make-frequency "hello" 1)))
(check-expect (count-all-words los3) (list (make-frequency "world" 1) (make-frequency "hello" 1)))

(define (count-all-words los)
  (cond[(empty? los) empty]
       [else (count-word (count-all-words (rest los)) (first los))]))

; Exercise 18.

(define hamlet-frequencies 
 (count-all-words (read-words "pg2265.txt")))

; Exercise 19.

; frequents : ListOfFrequencies -> ListOfFrequencies
; keeps the words that have appeared more than 100 times in the list
; (define (frequents f) ...)

(check-expect (frequents (list (make-frequency "hello" 1) (make-frequency "again" 101)))
              (list (make-frequency "again" 101)))
(check-expect (frequents hamlet-frequencies) (list
 (make-frequency "of" 652)
 (make-frequency "The" 147)
 (make-frequency "are" 122)
 (make-frequency "a" 478)
 (make-frequency "the" 952)
 (make-frequency "but" 148)
 (make-frequency "this" 232)
 (make-frequency "as" 149)
 (make-frequency "for" 182)
 (make-frequency "and" 657)
 (make-frequency "his" 265)
 (make-frequency "And" 255)
 (make-frequency "haue" 154)
 (make-frequency "To" 115)
 (make-frequency "on" 110)
 (make-frequency "he" 151)
 (make-frequency "to" 631)
 (make-frequency "be" 172)
 (make-frequency "But" 104)
 (make-frequency "will" 130)
 (make-frequency "shall" 103)
 (make-frequency "I" 532)
 (make-frequency "that" 245)
 (make-frequency "my" 435)
 (make-frequency "in" 359)
 (make-frequency "with" 215)
 (make-frequency "by" 109)
 (make-frequency "you" 451)
 (make-frequency "me" 164)
 (make-frequency "so" 115)
 (make-frequency "it" 302)
 (make-frequency "our" 131)
 (make-frequency "we" 106)
 (make-frequency "That" 114)
 (make-frequency "is" 302)
 (make-frequency "him" 118)
 (make-frequency "your" 245)
 (make-frequency "or" 107)
 (make-frequency "Ham." 337)
 (make-frequency "what" 110)
 (make-frequency "not" 261)))

;(define (frequents f)
;  (cond
;    [(empty? f) (...)]
;    [(cons? f) (cond
;                 [(>= (frequency-count (first f)) 100) (... (first f) (frequents (rest f))...)]
;                 [else (... (rest f)...)])]))

(define (frequents f)
  (cond
    [(empty? f) (list)]
    [(cons? f) (cond
                 [(>= (frequency-count (first f)) 100) (cons (first f) (frequents (rest f)))]
                 [else (frequents (rest f))])]))
                             
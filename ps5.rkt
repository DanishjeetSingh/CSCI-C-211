;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ps5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Exercise 1.

; draw: String -> Image
; to take a string and put it on a background
; (define (draw d) ...)

(define background (rectangle 400 400 "solid" "black"))

(check-expect (draw "Danish") (overlay (text "Danish" 40 "white")
                                       background))
(check-expect (draw "Johnny") (overlay (text "Johnny" 40 "white")
                                       background))
(check-expect (draw "Rick") (overlay (text "Rick" 40 "white")
                                     background))

;(define (draw d) (overlay ... d ... background))

(define (draw d) (overlay (text d 40 "white") background))

; Exercise 2.

; dn is a String

; string-add: String -> String
; takes a string and adds it to the draw function
; (define (string-add dn ke) ...)

(check-expect (string-add "Danish" "jeet") "Danishjeet")
(check-expect (string-add "Danish" " ") "Danish ")
(check-expect (string-add "Danish" "") "Danish")

; (define (string-add dn ke) (... dn ke ...))

(define (string-add dn ke) (string-append dn ke))

(big-bang "Danish"
  [to-draw draw]
  [on-key string-add])

; Exercise 3.

; a ke is one of:-
; " "
; any character but " "
;
; dn is a String

; string-reset: String -> String
; takes a string and adds it to the draw function but has a cond function in it.
; (define (string-reset dn ke) ...)

(check-expect (string-reset "Danish" "jeet") "Danishjeet")
(check-expect (string-reset "Danish" " ") "")
(check-expect (string-reset "Danish" "") "Danish")

; (define (string-reset dn ke) (... dn ke ...))

(define (string-reset dn ke) (cond
                             [(string=? ke " ") ""]
                             [else (string-append dn ke)]))

(big-bang "Danish"
  [to-draw draw]
  [on-key string-reset])

; Exercise 4.

; A Date is (make-date Number String Number)
; Examples:
;   (make-date 2018 "Sept" 12)
;   (make-date 0 "January" 1)
; Non-examples:
;   (make-date 2018 9 12)
;   "September 12, 2018"

; (make-date [year month day]): Number String Number -> date
; (date-year d): Date -> Year
; (date-month d): Month -> Year
; (date-day d): Date -> day
; date?: Anything -> Boolean

(define-struct date (year month day))

; Exercise 5.

; a street is a string
; an apartment is a string
; a city is a string
; a zip is a number
; An Address is (make-address (street apartment city zip))
; Examples:
; (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 47408)
; (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406)
; Non-Examples:
; (make-address ("ffffff"))
; (make-address (69420))

(define-struct address (street apartment city zip))

; Exercise 6.

;(define (process-address d)
;  ( ... (address-street d) (address-apartment d) (address-city d) (address-zip d) ...))

; Exercise 7.

; indiana?: Address -> Boolean
; takes the zip of the address and compares if the address in Indiana
; (define (indiana d) ...)

(check-expect (indiana? (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 47408)) true)
(check-expect (indiana? (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 69420)) false)

; (define (indiana? d) (cond
;                      [ (<= 46000 (address-zip d) 47999) ...]
;                      [ else ...]))

(define (indiana? d) (cond
                      [ (<= 46000 (address-zip d) 47999) true]
                      [ else false]))

; Exercise 8.

; format-address: Address -> String
; takes up an adress and returns it as a string
; (define (format-address d) ...)

(check-expect (format-address (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 47408))
              "700 N Woodlawn Ave Room 2062 Bloomington 47408")
(check-expect (format-address (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406))
              "501 N Sunrise Drive C609 Bloomington 47406")

; (define (format-address d)
;  (...
;   (address-street d) ...
;   (address-apartment d) ... (address-city d) ... (number->string (address-zip d)) ...))

(define (format-address d)
  (string-append
   (address-street d) " "
   (address-apartment d) " " (address-city d) " " (number->string (address-zip d))))

; Exercise 9.

; smaller-zip: Address Address -> Number
; compares the zip of 2 addresses and return the lower value
; (define (smaller-zipmd1 d2) ...)

(check-expect (smaller-zip (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 47408)
                           (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406))
              (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406))
(check-expect (smaller-zip
               (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406)
               (make-address "700 N Woodlawn Ave" "Room 2062" "Bloomington" 47408))
              (make-address "501 N Sunrise Drive" "C609" "Bloomington" 47406))
               
;(define (smaller-zip d1 d2) (cond
;                              [ (> (address-zip d1) (address-zip d2)) ...]
;                              [ else ...]))

(define (smaller-zip d1 d2) (cond
                              [ (>= (address-zip d1) (address-zip d2)) d2]
                              [ else d1]))

; 3 Book exercises
; Exercise 83.

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; reader: editor -> image
; to produce an image from an editor
; (define (reader e) ...)

(define e1 (make-editor "It's working, " "Oh yeah"))
(define e2 (make-editor "Bhenchod, " "Ki kra"))
(define e3 (make-editor "menu nahi, " "pta"))

(check-expect (render e1) (overlay/align "left" "center"
                 (beside (beside (text "It's working, " 16 "black") cursor)
                         (text "Oh yeah" 16 "black")) background2))
(check-expect (render e2) (overlay/align "left" "center"
                 (beside (beside (text "Bhenchod, " 16 "black") cursor)
                         (text "Ki kra" 16 "black")) background2))
(check-expect (render e3) (overlay/align "left" "center"
                 (beside (beside (text "menu nahi, " 16 "black") cursor)
                         (text "pta" 16 "black")) background2))

;(define (render e)
;  (overlay/align "left" "center"
;                 (... (... (... (editor-pre e) ...) ...)
;                         (... (editor-post e) ...)) ...))

(define background2
  (empty-scene 200 20))

(define cursor
  (rectangle 1 20 "solid" "red"))

(define (render e)
  (overlay/align "left" "center"
                 (beside (beside (text (editor-pre e) 16 "black") cursor)
                         (text (editor-post e) 16 "black")) background2))

; Exercise 84.

; edit: editor ke -> editor
; to return the edited editor
; (define (edit e ke) ...)

(define (len s)
  (string-length s))

(check-expect (edit e1 "\b") (make-editor "It's working," "Oh yeah"))
(check-expect (edit e2 "\b") (make-editor "Bhenchod," "Ki kra"))
(check-expect (edit e3 "\b") (make-editor "menu nahi," "pta"))
(check-expect (edit e1 "hello") (make-editor "It's working, hello" "Oh yeah"))
(check-expect (edit e1 "left") (make-editor "It's working," " Oh yeah"))
(check-expect (edit e1 "right") (make-editor "It's working, O" "h yeah"))
(check-expect (edit e1 "\t") (make-editor "It's working, " "Oh yeah"))
(check-expect (edit e1 "\r") (make-editor "It's working, " "Oh yeah"))

;(define (edit e ke)
;  (cond[(string=? ke "\b")
;        (make-editor (substring (editor-pre e) 0 (- (len (editor-pre e)) 1)) ...))]
;       [else (make-editor (string-append (editor-pre e) ke) ...))])) 

(define (string-first e) (substring (editor-post e) 0 1))
(define (string-rest e) (substring (editor-post e) 1))
(define (string-last e) (substring (editor-pre e) (- (len(editor-pre e)) 1)))
(define (string-remove-last e) (substring (editor-pre e) 0 (- (len(editor-pre e)) 1)))

(define (edit e ke)
  (cond[(string=? ke "\b")
        (make-editor (substring (editor-pre e) 0 (- (len (editor-pre e)) 1))
                     (editor-post e))]
       [(string=? ke "left")
        (make-editor (string-remove-last e)
                               (string-append (string-last e) (editor-post e)))]
       [(string=? ke "right")
        (make-editor (string-append (editor-pre e) (string-first e))
                     (string-rest e))]
       [(string=? ke "\t") e]
       [(string=? ke "\r") e]
       [else (make-editor (string-append (editor-pre e) ke) (editor-post e))]))
  
; Exercise 85.

;run: editor-pre -> World
;to launch an interactive editor using big-bang
;(define (run e) ...)

;(define (run e)
;  (big-bang (... p ...)
;    [to-draw ...]
;    [on-key ...]))

(define (run e)
  (big-bang (make-editor e "")
    [to-draw render]
    [on-key edit]))
 


                               

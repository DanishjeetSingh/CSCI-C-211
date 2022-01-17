;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1

; 1. Data definitions
; A Temperature is a Number
 
; 2. Signature, purpose, header
; ctok : Temperature -> Temperature
; convert Celsius to Kelvin
;(define (ctok c) ...)
 
; 3. Function examples
; given: 0      expect: 273
; givern: 100   expect: 373
 
; 4. Function template
;(define (ctok c) (... c ...))
 
; 5. Function definition
(define (ctok c) (+ c 273))
 
; 6. Testing

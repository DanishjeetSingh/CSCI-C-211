;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ps4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Year is a non-negative integer
; Examples:
;   0
;   1789
;   2018
; Non-examples:
;   -5000
;   "AD 2018"
 
; A Month is one of:
; - "January"
; - "February"
; - "March"
; - "April"
; - "May"
; - "June"
; - "July"
; - "August"
; - "September"
; - "October"
; - "November"
; - "December"
 
; A Day is an integer at least 1 but at most 31
; Examples:
;   1
;   10
;   31
; Non-examples:
;   32
;   "today"


; Exercise 1

; next-month : Month -> Month
; returns the month that comes after the given one

;(define (next-month m) ...)
 
(check-expect (next-month "January"  ) "February" )
(check-expect (next-month "February" ) "March"    )
(check-expect (next-month "March"    ) "April"    )
(check-expect (next-month "April"    ) "May"      )
(check-expect (next-month "May"      ) "June"     )
(check-expect (next-month "June"     ) "July"     )
(check-expect (next-month "July"     ) "August"   )
(check-expect (next-month "August"   ) "September")
(check-expect (next-month "September") "October"  )
(check-expect (next-month "October"  ) "November" )
(check-expect (next-month "November" ) "December" )
(check-expect (next-month "December" ) "January"  )

;(define (next-month m)
;  (cond [(string=? "January")   ...]
;        [(string=? "February")  ...]
;        [(string=? "March")     ...]
;        [(string=? "April")     ...]
;        [(string=? "May")       ...]
;        [(string=? "June")      ...]
;        [(string=? "July")      ...]
;        [(string=? "August")    ...]
;        [(string=? "September") ...]
;        [(string=? "October")   ...]
;        [(string=? "November")  ...]
;        [(string=? "December")  ...]))

(define (next-month m)
  (cond [(string=? m "January")   "February"]
        [(string=? m "February")  "March"]
        [(string=? m "March")     "April"]
        [(string=? m "April")     "May"]
        [(string=? m "May")       "June"]
        [(string=? m "June")      "July"]
        [(string=? m "July")      "August"]
        [(string=? m "August")    "September"]
        [(string=? m "September") "October"]
        [(string=? m "October")   "November"]
        [(string=? m "November")  "December"]
        [(string=? m "December")  "January"]))

; Exercise 2

; A Year is a non-negative integer
; Examples:
;   0
;   1789
;   2018
; Non-examples:
;   -5000
;   "AD 2018"
 
; A Month is one of:
; - "January"
; - "February"
; - "March"
; - "April"
; - "May"
; - "June"
; - "July"
; - "August"
; - "September"
; - "October"
; - "November"
; - "December"
 
; A Day is an integer at least 1 but at most 31
; Examples:
;   1
;   10
;   31
; Non-examples:
;   32
;   "today"

; fall? : Month -> Boolean

; decides whether the given month is between September and November

; (define (fall? m) ...)

(check-expect (fall? "September") true)
(check-expect (fall? "October") true)
(check-expect (fall? "November") true)
(check-expect (fall? "December") false)

(define (fall? m)
  (cond[(string=? m "November")    true]
       [(string=? m "September") true]
       [(string=? m "October")   true]
       [else false]))

; Exercise 3

; calendar : Year Month Day -> Image
; returns an image of a date on a background

; A MonthFormat is one of:
; - "long"
; - "short"
 
; A DateOrder is one of:
; - "MDY"
; - "DMY"

; format-month : Month MonthFormat -> String
; abbreviates Month to three letters or not
; (define (format-month m f) ...)
 
(check-expect (format-month "January"   "long" ) "January"  )
(check-expect (format-month "January"   "short") "Jan"      )
(check-expect (format-month "February"  "long" ) "February" )
(check-expect (format-month "February"  "short") "Feb"      )
(check-expect (format-month "March"     "long" ) "March"    )
(check-expect (format-month "March"     "short") "Mar"      )
(check-expect (format-month "April"     "long" ) "April"    )
(check-expect (format-month "April"     "short") "Apr"      )
(check-expect (format-month "May"       "long" ) "May"      )
(check-expect (format-month "May"       "short") "May"      )
(check-expect (format-month "June"      "long" ) "June"     )
(check-expect (format-month "June"      "short") "Jun"      )
(check-expect (format-month "July"      "long" ) "July"     )
(check-expect (format-month "July"      "short") "Jul"      )
(check-expect (format-month "August"    "long" ) "August"   )
(check-expect (format-month "August"    "short") "Aug"      )
(check-expect (format-month "September" "long" ) "September")
(check-expect (format-month "September" "short") "Sep"      )
(check-expect (format-month "October"   "long" ) "October"  )
(check-expect (format-month "October"   "short") "Oct"      )
(check-expect (format-month "November"  "long" ) "November" )
(check-expect (format-month "November"  "short") "Nov"      )
(check-expect (format-month "December"  "long" ) "December" )
(check-expect (format-month "December"  "short") "Dec"      )

(define (format-month m f)
  (cond[(string=? f "long")
        (cond [(string=? m "January")   m]
              [(string=? m "February")  m]
              [(string=? m "March")     m]
              [(string=? m "April")     m]
              [(string=? m "May")       m]
              [(string=? m "June")      m]
              [(string=? m "July")      m]
              [(string=? m "August")    m]
              [(string=? m "September") m]
              [(string=? m "October")   m]
              [(string=? m "November")  m]
              [(string=? m "December")  m])]
        [(string=? f "short")
         (cond [(string=? m "January")  (substring m 0 3)]
              [(string=? m "February")  (substring m 0 3)]
              [(string=? m "March")     (substring m 0 3)]
              [(string=? m "April")     (substring m 0 3)]
              [(string=? m "May")       (substring m 0 3)]
              [(string=? m "June")      (substring m 0 3)]
              [(string=? m "July")      (substring m 0 3)]
              [(string=? m "August")    (substring m 0 3)]
              [(string=? m "September") (substring m 0 3)]
              [(string=? m "October")   (substring m 0 3)]
              [(string=? m "November")  (substring m 0 3)]
              [(string=? m "December")  (substring m 0 3)])]))

; Exercise 4

; year-month-day->date : Year Month Day DateOrder MonthFormat -> String
; produces a date as a string

; (define (year-month-day->date y m d o f) ...)

; given: 1936 "November" 12 "MDY" "long"   expect: "November 12, 1936"
; given: 1936 "November" 12 "MDY" "short"  expect: "Nov 12, 1936"
; given: 1936 "November" 12 "DMY" "long"   expect: "12 November 1936"
; given: 1936 "November" 12 "DMY" "short"  expect: "12 Nov 1936"
(check-expect (year-month-day->date 1936 "November" 12 "MDY" "long") "November 12, 1936")
(check-expect (year-month-day->date 1936 "November" 12 "MDY" "short") "Nov 12, 1936")
(check-expect (year-month-day->date 1936 "November" 12 "DMY" "long") "12 November 1936")
(check-expect (year-month-day->date 1936 "November" 12 "DMY" "short") "12 Nov 1936")

; (define (year-month-day->date y m d o f)
;  (cond[(string=? o "MDY") (...format-month...)]
;        [(string=? o "DMY") (... format-month...)]))

(define (year-month-day->date y m d o f)
  (cond[(string=? o "MDY")
       (string-append (format-month m f)" " (number->string d) ", " (number->string y))]
       [(string=? o "DMY")
       (string-append (number->string d) " "(format-month m f) " " (number->string y))]))

; Exercise 5.

; calendar: Year Month Day DateOrder MonthFormat Image -> Image
; basically prints the date on a background and calls it a day :)
; (define (calendar y m d) ...)

(check-expect (calendar 2069 "May" 09)
              (overlay (text
                        (year-month-day->date 2069 "May" 09 "DMY" "long") 40 "white") background ))
(check-expect (calendar 2069 "June" 09)
              (overlay (text
                        (year-month-day->date 2069 "June" 09 "DMY" "long") 40 "white") background ))
(check-expect (calendar 2420 "July" 31)
              (overlay (text
                        (year-month-day->date 2420 "July" 31 "DMY" "long") 40 "white") background ))

;(define (calendar y m d) (... year-month-day->date y m d "DMY" "long" ...))

(define background (rectangle 400 400 "solid" "black"))
  
(define (calendar y m d) (overlay (text (year-month-day->date y m d "DMY" "long") 40 "white")
                                  background))

; Exercise 6.

; month->days-in-year : Month -> Number
; returns the days elapsed in the year before the given month
;(define (month->days-in-year y) ...)


(check-expect (month->days-in-year "January") 0)
(check-expect (month->days-in-year "September") 243)

;(define (month->days-in-year m)
;  (cond[(string=? m "January")   0]
;       [(string=? m "February") (+ (month->days-in-year "...") )]
;       [(string=? m "March") (+ (month->days-in-year "...") )]
;       [(string=? m "April") (+ (month->days-in-year "...") )]
;       [(string=? m "May") (+ (month->days-in-year "...") )]
;       [(string=? m "June") (+ (month->days-in-year "...") )]
;       [(string=? m "July") (+ (month->days-in-year "...") )]
;       [(string=? m "August") (+ (month->days-in-year "...") )]
;       [(string=? m "September") (+ (month->days-in-year "...") )]
;       [(string=? m "October") (+ (month->days-in-year "...") )]
;       [(string=? m "November") (+ (month->days-in-year "...") )]
;       [(string=? m "December") (+ (month->days-in-year "...") )]))

(define (month->days-in-year m)
  (cond[(string=? m "January")   0]
       [(string=? m "February") (+ (month->days-in-year "January") 31)]
       [(string=? m "March") (+ (month->days-in-year "February") 28)]
       [(string=? m "April") (+ (month->days-in-year "March") 31)]
       [(string=? m "May") (+ (month->days-in-year "April") 30)]
       [(string=? m "June") (+ (month->days-in-year "May") 31)]
       [(string=? m "July") (+ (month->days-in-year "June") 30)]
       [(string=? m "August") (+ (month->days-in-year "July") 31)]
       [(string=? m "September") (+ (month->days-in-year "August") 31)]
       [(string=? m "October") (+ (month->days-in-year "September") 30)]
       [(string=? m "November") (+ (month->days-in-year "October") 31)]
       [(string=? m "December") (+ (month->days-in-year "November") 30)]))

; Exercise 7.

; year-month-day->days : Year Month Day -> Number
; returns the number of days elapsed since January 1, 0
; (define ( year-month-day->days y m d) ...)

(check-expect ( year-month-day->days 0 "January" 1) 0)
(check-expect ( year-month-day->days 2017 "August" 28) 736444)

;(define ( year-month-day->days y m d) (... (month->days-in-year m) ...)) 

(define ( year-month-day->days y m d) (+ (* 365 y) (- (+ (month->days-in-year m) d) 1)))

; Exercise 8.

; days-between : Year Month Day Year Month Day -> Number
; returns the days elapsed between 2 dates
; (define (days-between y1 m1 d1 y2 m2 d2) ...)

(check-expect (days-between 2021 "September" 15 2021 "September" 13) 2)
(check-expect (days-between 2017 "August" 28 0 "January" 1) 736444)

; (define (days-between y1 m1 d1 y2 m2 d2)...(year-month-day->days y1 m1 d1)...)

(define (days-between y1 m1 d1 y2 m2 d2)
  (- ( year-month-day->days y1 m1 d1) ( year-month-day->days y2 m2 d2)))

; Exercise 9.

; days->year : Number -> Year
; takes days since 1 Jan 0 and returns the year
;(define (days->year y) ...)

(check-expect (days->year 364) 0)
(check-expect (days->year 365) 1)
(check-expect (days->year 736305) 2017)
(check-expect (days->year (year-month-day->days 1999 "December" 31)) 1999)

;(define (days->year d) (floor ...))

(define (days->year d) (floor (/ d 365)))

; Exercise 10.

; DaysInYear is one of:
; - an integer at least   0 but less than  31
; - an integer at least  31 but less than  59
; - an integer at least  59 but less than  90
; - an integer at least  90 but less than 120
; - an integer at least 120 but less than 151
; - an integer at least 151 but less than 181
; - an integer at least 181 but less than 212
; - an integer at least 212 but less than 243
; - an integer at least 243 but less than 273
; - an integer at least 273 but less than 304
; - an integer at least 304 but less than 334
; - an integer at least 334 but less than 365
; *Interpretation*: the number of elapsed days
;                   since the first day of the year
 
; DaysInMonth is an integer at least 0 but less than 31
; *Interpretation*: The number of elapsed days
;                   since the first day of the month

; days-in-year->month : DaysInYear -> Month
; takes days since the first of the year and returns the month
; (define (days-in-year->month m) ...)

(check-expect (days-in-year->month 0) "January")
(check-expect (days-in-year->month 31) "February")
(check-expect (days-in-year->month 242) "August")

;(define (days-in-year->month m) (cond
;                                  [(<= 0 m 30) ...]
;                                  [(<= 31 m 58) ...]
;                                  [(<= 59 m 89) ...]
;                                  [(<= 90 m 119) ...]
;                                  [(<= 120 m 150) ...]
;                                  [(<= 151 m 180) ...]
;                                  [(<= 181 m 211) ...]
;                                  [(<= 212 m 242) ...]
;                                  [(<= 243 m 272) ...]
;                                  [(<= 273 m 303) ...]
;                                  [(<= 304 m 333) ...]
;                                  [(<= 334 m 365) ...]))

(define (days-in-year->month m) (cond
                                  [(<= 0 m 30) "January"]
                                  [(<= 31 m 58) "February"]
                                  [(<= 59 m 89) "March"]
                                  [(<= 90 m 119) "April"]
                                  [(<= 120 m 150) "May"]
                                  [(<= 151 m 180) "June"]
                                  [(<= 181 m 211) "July"]
                                  [(<= 212 m 242) "August"]
                                  [(<= 243 m 272) "September"]
                                  [(<= 273 m 303) "October"]
                                  [(<= 304 m 333) "November"]
                                  [(<= 334 m 365) "December"]))

; days->month : Number -> Month
; takes days since 1 Jan 0 and returns the month
; (define (days->month m) ...)

(check-expect (days->month 59) "March")
(check-expect (days->month 364) "December")
(check-expect (days->month 736445) "August")
(check-expect (days->month (year-month-day->days 1999 "December" 31)) "December")

; (define (days-in-year->days-in-month d)
;   (... (month->days-in-year)...))

(define (days->month d)
  (cond[(< d 365) (days-in-year->month d)]
       [else (days->month (remainder d 365))]))

; given: 59                                        expect: "March"
; given: 364                                       expect: "December"
; given: 736445                                    expect: "August"
; given: (year-month-day->days 1999 "December" 31) expect: "December"


;Exercise 11.

; days-in-year->days-in-month : DaysInYear -> DaysInMonth
; takes days since the first of the year
; and returns days since the first of the month
;(define (days-in-year->days-in-month m) ...)
 
(check-expect (days-in-year->days-in-month 0) 0)
(check-expect (days-in-year->days-in-month 59) 0)
(check-expect (days-in-year->days-in-month 364) 30)

;(define (days-in-year->days-in-month m ) (...month->days-in-year (days-in-year->month m)...))

(define (days-in-year->days-in-month m ) (- m (month->days-in-year (days-in-year->month m))))
 
; days->day : Number -> Day
; takes days since 1 Jan 0 and returns the day of the month
;(define (days->day m) ...)

(check-expect (days->day 0) 1)
(check-expect (days->day 59) 1)
(check-expect (days->day 736324) 30)
(check-expect (days->day (year-month-day->days 1999 "December" 31)) 31)

; given: 0                                         expect: 1
; given: 59                                        expect: 1
; given: 736324                                    expect: 30
; given: (year-month-day->days 1999 "December" 31) expect: 31

(define (days->day d)
  (cond[(< d 365) (+ 1 (days-in-year->days-in-month d))]
       [else (days->day (remainder d 365))]))

; first-day : Number
; The number of days elapsed on August 23, 2021 since January 1, 0
; (define first-day ...)

;Exercise 12.

(define first-day
  (year-month-day->days 2021 "August" 23))

; length-of-semester : Number
; The number of days elapsed on December 17, 2021 since August 23, 2021
; (define length-of-semester ...)

(define length-of-semester
  (days-between 2021 "December" 17 2021 "August" 23))

; a SemesterDay is one of:
; - an integer n, 0 <= n < length-of-semester
;   *Interpretation*: n days have elapsed since August 23, 2021
; - an integer n, n >= length-of-semester
;   *Interpretation*: The semester has ended
 
; semester-cal : SemesterDay -> Image
; takes a number of days since the first day of the semester
; and returns a calendar image of the corresponding date; does
; not advance past the last day of the semester
; (define (semester-cal t) ...)

(define (current-day t)
  (+ first-day t))

(check-expect (semester-cal 0) (calendar 2021 (days->month (current-day 0))
                               (days->day (current-day 0))))
(check-expect (semester-cal 100) (calendar 2021 (days->month (current-day 100))
                               (days->day (current-day 100))))
(check-expect (semester-cal 116) (calendar 2021 (days->month (current-day 116))
                               (days->day (current-day 116))))

;(define (semester-cal t)
;  (cond[(<= 0 t length-of-semester) (calendar 2021 ...)]
;       [else ...]))

(define (semester-cal t)
  (cond[(<= 0 t length-of-semester) (calendar 2021 (days->month (current-day t))
                               (days->day (current-day t)))]
       [else (semester-cal 116)]))

(define cal-rate 1)

(check-expect (semester 0) (semester-cal (quotient (* cal-rate 0) 28)))
(check-expect (semester 100) (semester-cal (quotient (* cal-rate 100) 28)))
(check-expect (semester 116) (semester-cal (quotient (* cal-rate 116) 28)))

(define (semester t)
  (semester-cal (quotient (* cal-rate t) 28)))

(animate semester)





                
                                  







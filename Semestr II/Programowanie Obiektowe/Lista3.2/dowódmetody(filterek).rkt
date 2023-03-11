#lang racket

(define p? positive?)
(define xs (list 1 2 3 4))
(define ys (list -1 -2 5 6))

;Definicja filterka
(define (filter predicate sequence)
(cond [(null? sequence) null]
      [(predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence)))]
      [else (filter predicate (cdr sequence))])
)

;Definicja appendka
(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1)
              (append (cdr list1)
                      list2)))
)

;Teza indukcyjna
(equal? 
    (filter p? (append xs ys))
    (append (filter p? xs) (filter p? ys))
)


;Podstawa indukcji
;xs = null

(equal? 
    (filter p? (append null ys))
    (append (filter p? null) (filter p? ys))
)

;rozpisujemy append

(equal? 
    (filter p? 
    (if (null? null)
        ys
        (cons (car null)
              (append (cdr null ys))))
    )

    (if (null? (filter p? null))
        (filter p? ys)
        (cons (car (filter p? null))
              (append (cdr (filter p? null))
                      (filter p? ys))))
)


;rozpisujemy filter

(equal? 
    (filter p? 
    (if (null? null)
        ys
        (cons (car null)
              (append (cdr null ys))))
    )

    (if (null? 
        (cond 
            ((null? null) null)
            ((p? (car null))
            (cons 
                (car null)
                (filter p? (cdr null))
            )
            )
            (else (filter p? (cdr null))))
        )
        (filter p? ys)
        (cons (car (filter p? null))
              (append (cdr (filter p? null))
                      (filter p? ys)))
    )
)
;;Z definicji if
(equal? 
    (filter p? ys)

    (filter p? ys)
)

;;Czyli podstawa jest supcio zrobionko
;;Czas na krok, hihi

;;Załóżmy że zachodzi P(xs), pokażemy że zachodzi P(cons x xs)
;;czyli (filter p? (append (cons x xs) ys)) == (append (filter p? (cons x xs)) (filter p? ys))

(define x 3)

(equal? 
    (filter p? (append (cons x xs) ys))

    (append (filter p? (cons x xs)) (filter p? ys))
)

;;Z defninicji appenda

(equal? 
    (filter p? 
        (if (null? (cons x xs))
            ys
            (cons (car (cons x xs))
                (append (cdr (cons x xs))
                        ys)))
    )

    (if (null? (filter p? (cons x xs)))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys))))
)

;;Z definicji null? i if

(equal? 
    (filter p? 
            (cons (car (cons x xs))
                (append (cdr (cons x xs))
                        ys))
    )

    (if (null? (filter p? (cons x xs)))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys))))
)

;;Z definicji filter
(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cond ((null?  (cons x xs)) null)
                    ((p? (car  (cons x xs)))
                     (cons (car  (cons x xs))
                     (filter p? (cdr  (cons x xs)))))
                    (else (filter p? (cdr  (cons x xs))))))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;;Z definicji car i cdr

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cond 
                    ((null?  (cons x xs)) null)
                    ((p? x) 
                        (cons x
                            (filter p? xs)))
                    (else (filter p? xs))))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;Musimy rozpatrzyć dwa przypadki
; 1° (p? x) spełnione

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cons x (filter p? xs)))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;Z definicji filter
(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cons x (filter p? xs)))
            (filter p? ys)
            (cons (car 
                    (cond ((null? (cons x xs)) null)
                            ((p? (car (cons x xs)))
                                (cons (car (cons x xs)) (filter p? (cdr (cons x xs))))
                            )
                            (else (filter p? (cdr (cons x xs))))))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;Z definicji car i cdr

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cons x (filter p? xs)))
            (filter p? ys)
            (cons (car 
                    (cond ((null? (cons x xs)) null)
                            ((p? x)
                                (cons x (filter p? xs))
                            )
                            (else (filter p? xs))))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;;Z Conda

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cons x (filter p? xs)))
            (filter p? ys)
            (cons (car (cons x (filter p? xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;;z car'a

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cons x (filter p? xs)))
            (filter p? ys)
            (cons x
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)

;; z if'a

(equal? 
    (filter p? (cons x (append xs ys)))

    
    (cons x
        (append (cdr (filter p? (cons x xs)))
            (filter p? ys)))
)

;; z definicji filter

(equal? 
    (cond [(null? (cons x (append xs ys))) null]
          [(p? (car (cons x (append xs ys))))
                (cons (car (cons x (append xs ys)))
                      (filter p? (cdr (cons x (append xs ys)))))]
          [else (filter p? (cdr (cons x (append xs ys))))])

    
    (cons x 
            (append (cdr (filter p? (cons x xs)))
                    (filter p? ys)))
)

;Teza indukcyjna
(equal? 
    (filter p? (append xs ys))
    (append (filter p? xs) (filter p? ys))
)

; Skracamy
(equal?
        (cons x (filter p? (append xs ys)))

    (cons x
            (append (cdr (filter p? (cons x xs)))
                    (filter p? ys)))
)

; Daj Bóg że to się uda
; rozpisujemy filter, ten pierwszy w drugim
(equal?
    (cons x (filter p? (append xs ys)))

    (cons x
            (append (filter p? xs)
                    (filter p? ys)))
)

;;Z założenia (filter p? (append xs ys)) == (append (filter p? xs)(filter p? ys))
; łatwo
; 
; teraz drugi przypadek...

;2° (p? x) nie jest spełnione

(define y -5)

(equal? 
    (filter p? (cons x (append xs ys)))

    (if (null? (cond
                    ((null? (cons x xs)) null)
                    ((p? x)
                        (cons x
                            (filter p? xs)))
                    (else (filter p? xs))))
            (filter p? ys)
            (cons (car (filter p? (cons x xs)))
              (append (cdr (filter p? (cons x xs)))
                      (filter p? ys)))
    )
)



(equal?
    (filter p? (cons y (append xs ys)))

    (if (null? (filter p? xs))
        (filter p? ys)
        (cons (car (filter p? (cons y xs)))
              (append (cdr (filter p? (cons y xs)))
                      (filter p? ys))))
)

;Z definicji filterka
;
; (equal?
;     (filter p? (cons y (append xs ys)))

;     (if (null? (cond [(null? xs) null]
;                      [(p? (car xs))
;                           (cons (car xs)
;                                 (filter p? (cdr xs)))]
;                      [else (filter p? (cdr xs))]))
;         (filter p? ys)
;         (cons (car (filter p? (cons y xs)))
;               (append (cdr (filter p? (cons y xs)))
;                       (filter p? ys))))
; )

(equal?
; (filter p? (cons y (append xs ys)))
(filter p? (append xs ys))

(if (null? (filter p? xs))
    (filter p? ys)
    (cons (car (filter p? (cons y xs)))
          (append (cdr (filter p? (cons y xs)))
                  (filter p? ys))))
)


;Z definicji filter i z założenia (filter p? (cons y xs)) = (filter p? xs) [można powiedzieć, że to lemacik XDDDDD]

(equal?
(filter p? (append xs ys))

(if (null? (filter p? xs))
    (filter p? ys)
    (cons (car (filter p? xs))
          (append (cdr (filter p? xs))
                  (filter p? ys))))
)

; Z definicji append
(equal?
(filter p? (append xs ys))

(append (filter p? xs) (filter p? ys))
)


;;Z założenia (filter p? (append xs ys)) == (append (filter p? xs)(filter p? ys))
;;KONIEC DOWODU KURWA MAĆ
;;#PROVED
; 1000% proof
; II(krok indukcyjny)
; Załóżmy, że dla dowolnych x, xs, jeśli zachodzi P(xs) to P((cons x xs))
; Załóżmy, że
; (map f (append xs
;                ys))
; =
; (append (map f xs)
;         (map f ys)) ;;;;TUTAJ JEST ZAŁOŻENIE

; Pokażemy że zachodzi P((cons x xs))
;
; (map f (append (cons x xs)
;                ys)
; =
; (append (map f (cons x xs))
;         (map f ys))
;

#lang racket

; xs, ys - dowolne listy
; x - dowolna liczba
; f - dowolona procedura
(define xs '(1 2 3))
(define ys '(4 5 6))
(define x 7)
(define f (lambda (x) (+ x 1)))

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1)
              (append (cdr list1)
                      list2)))
)

(define (map proc items)
    (if (null? items)
        null
        (cons (proc (car items))
              (map proc (cdr items))))
)
; koniec definicji
; teraz kurna dowód

;;Założenie indukcyjne
(equal?
(map f (append xs ys))
(append (map f xs) (map f ys))
)


; Teza indukcyjna
(equal?
(map f (append (cons x xs)
               ys))

(append (map f (cons x xs))
        (map f ys))
)

;Rozpisanie definicji appenda
(equal?
(map f (if (null? (cons x xs))
           ys
           (cons (car (cons x xs))
                 (append (cdr (cons x xs))
                         ys))))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (car (map f (cons x xs)))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

;;Z definicji (cdr list) wnioskujemy, że (cdr (cons x xs)) = xs

(equal?
(map f (if (null? (cons x xs))
           ys
           (cons x
                 (append xs ys))))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (car (map f (cons x xs)))
          (append (cdr (map f (cons x xs))) ;;Rozpisujemy map z definicji
                  (map f ys))))
)

;;Rozpisujemy z definicji map

(equal?
(map f (if (null? (cons x xs))
           ys
           (cons x
                 (append xs ys))))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (car (if (null? (cons x xs)) ;;o tutaj rozpisaliśmy map
                   null
                   (cons (f (car (cons x xs)))
                         (map f (cdr (cons x xs))))))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Wiemy, że (= (null? (cons x xs)) #f)
(equal?
(map f (cons x
             (append xs ys)))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (car (cons (f (car (cons x xs)))
                     (map f (cdr (cons x xs)))))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Wiemy, że (car (cons <expr1> <expr2>)) = <expr1>, więc
(equal?
(map f (cons x
             (append xs ys)))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (f (car (cons x xs)))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Z definicji (map)
(equal?
(if (null? (cons x (append xs ys)))
    null
    (cons (f (car (cons x (append xs ys))))
          (map f (cdr (cons x (append xs ys))))))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (f (car (cons x xs)))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Wiemy, że (cons x (append xs ys)) nie jest null, więc
(equal?
(cons (f (car (cons x (append xs ys))))
      (map f (cdr (cons x (append xs ys)))))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (f (car (cons x xs)))
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Z definicji car i cdr pobierają one element z cons
(equal?
(cons (f x)
      (map f (append xs ys)))

(if (null? (map f (cons x xs)))
    (map f ys)
    (cons (f x)
          (append (cdr (map f (cons x xs)))
                  (map f ys))))
)

; Z definicji map
(equal?
(cons (f x)
      (map f (append xs ys)))

(if (null? (if (null? (cons x xs))
               null
               (cons (f (car (cons x xs)))
                   (map f (cdr (cons x xs))))))
    (map f ys)
    (cons (f x)
          (append (cdr (if (null? (cons x xs))
                           null
                           (cons (f (car (cons x xs)))
                                 (map f (cdr (cons x xs))))))
                  (map f ys))))
)

; Wiemy, że (cons x xs) nie jest null
; I car sram wiadomo
;;Z założońska widać, że prawa równa się lewej, elo
(equal?
(cons (f x)
      (map f (append xs ys)))

(cons (f x)
      (append (map f xs)
              (map f ys)))
)

; Z założenia (map f (append xs ys)) ==(append (map f xs) (map f ys))
; cnd, łatwo
; bdb!
; normalnie
; no i kurwaas
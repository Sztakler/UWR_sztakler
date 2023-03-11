#lang racket

(define list_a (list 1 2 3))

(define (rev l)
  (cond
    ; jeśli pusta, zwróć listę pustą
    [(null? l) '()]
    ; append łączy 2 listy
    [else (append
        ; odwrócone pozostałe elementy listy
        (rev (cdr l))
        ; jednoelementowa lista z początkiem obecnej listy
        (list (car l))
    )]
  )
)

(define (rev-iter l)
    (define (r old new_)
        (if (null? old)
            new_
            (r
                (cdr old)
                ; (car old) to element, wiec robimy
                ; z niego 1-el. listę
                (append (list (car old)) new_)
            )
        )
    )
    (r l '())
)
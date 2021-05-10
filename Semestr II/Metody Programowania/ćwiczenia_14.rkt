#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

;ĆWICZENIE 1

(define %grandson
  (%rel (a b c)
        [(a b)
         (%male a)
         (%parent b c)
         (%parent c a)]))

(define %cousin
  (%rel (a b c d)
        [(a b)
         (%parent c a)
         (%parent d b)
         (%sibling c d)]))

;ĆWICZENIE 2

(%which () (%ancestor 'mark 'john))
(println "-_-_-_-_-_-_")
(%find-all (x) (%ancestor 'adam x))
(println "-_-_-_-_-_-_")
(%which (x) (%sister x 'ivonne))
(println "-_-_-_-_-_-_")
(%find-all (x y) (%cousin x y))
(println "-_-_-_-_-_-_")

;ĆWICZENIE 3

(define %my-append
  (%rel (x xs ys zs)
        [(null ys ys)]
        [((cons x xs) ys (cons x zs))
         (%my-append xs ys zs)]))

(define %my-member
  (%rel (x xs y)
        [(x (cons x xs))]
        [(y (cons x xs))
         (%my-member y xs)]))

(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))

;; prosta rekurencyjna definicja
(define %simple-length
  (%rel (x xs n m)
        [(null 0)]
        [((cons x xs) n)
         (%simple-length xs m)
         (%is n (+ m 1))]))

;; test w trybie +- (działa)
(%find-all (a) (%simple-length (list 1 2) a))
;; test w trybie ++ (działa)
(%find-all () (%simple-length (list 1 2) 2))
;; test w trybie -+ (1 odpowiedź, pętli się)
(%which (xs) (%simple-length xs 2))
;; test w trybie -- (nieskończona liczba odpowiedzi)
(%which (xs a) (%simple-length xs a))



(%which (xs ys) (%my-append xs xs ys))
(println "-_-_-_-_-_-_")
(%which (x) (%select x '(1 2 3 4) '(1 2 4)))
(println "-_-_-_-_-_-_")
(%which (xs) (%append '(1 2 3) xs '(1 2 3 4 5)))

;ĆWICZENIE 4

(define %revapp
  (%rel (x xs ys zs)
       [('() ys ys)]
       [((cons x xs) ys zs)
        (%revapp xs (cons x ys) zs)]))

(define %reverse
  (%rel (xs ys)
        [(xs ys)
         (%revapp xs '() ys)]))

;drzewo przeszukiwań dla zapytania

;ĆWICZENIE 6

(%which (x) (%reverse '(1 2) x))
(%more)

(define %sublist 
  (%rel (x xs ys z)
        [('() xs)]
        [((cons x xs) (cons x ys))
         (%sublist xs ys)]
        [((cons z xs) (cons x ys))
         (%sublist (cons z xs) ys)]))

(%find-all (xs) (%sublist xs '(1 2 3)))
(remove-duplicates (%find-all (xs) (%sublist xs '(1 2 3))))

;ĆWICZENIE 7

(define %perm
  (%rel (x xs ys zs)
        [(null null)]
        [((cons x xs) ys)
         (%select x ys zs)
         (%perm xs zs)]))

(%find-all (xs) (%perm xs '(1 2 3)))

;ĆWICZENIE 8

(define (list->num xs)
  (define (aux acc xs)
    (match xs
      ['() acc]
      [(cons x xs) (aux (+ (* acc 10) x) xs)]))
  (aux 0 xs))


(list->num (list 1 2 3 ))

(define %variation
  (%rel (xs zs ys)
        [(xs zs)
         (%perm ys zs)
         (%sublist xs ys)])) ;wolne jak cholera


(define %is-list-sum
  (%rel (xs ys zs x y z)
        [(xs ys zs)
         (%is x (list->num xs))
         (%is y (list->num ys))
         (%is z (list->num zs))
         (%is z (+ x y))]))

(define %variations
  (%rel ()
        [(xs '())]
        [(cons (h ) 

varia(0,_,[]).
varia(N,L,[H|Varia]):-N>0,N1 is N-1,delete(H,L,Rest),varia(N1,Rest,Varia).

(println "===================")

 (%which (d e m n o r s y)
  (%variation (list d e m n o r s y) (list 0 1 2 3 4 5 6 7 8 9))
         (%is-list-sum
             (list s e n d)
             (list m o r e)
             (list m o n e y)))
    
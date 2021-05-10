#lang racket

;Zadanie wykonane po kilku pytaniach do Cezarego Świtały.

(require "graph.rkt")
(provide bag-stack@ bag-fifo@)

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)

  (define (stack-list b) (second b))
  (define (stack-cons l) (list 'stack l))
  (define (bag? b) (and (list? b)
                        (= (length b) 2)
                        (eq? (first b) 'stack)
                        (list? (second b))))
  (define empty-bag (stack-cons '()))
  (define (bag-empty? b) (empty? (stack-list b)))
  (define (bag-insert b e) (stack-cons (cons e (stack-list b))))
  (define (bag-peek b) (car (stack-list b)))
  (define (bag-remove b) (stack-cons (cdr (stack-list b))))
)

;; struktura danych - kolejka FIFO
(define-unit bag-fifo@
  (import)
  (export bag^)
  (define (fifo-list-in f)  (second f))
  (define (fifo-list-out f) (third f))
  (define (fifo-cons l1 l2) (list 'fifo l1 l2))
  (define (bag? f) (and (list? f)
                        (= (length f) 3)
                        (eq? (first f) 'fifo)
                        (list? (second f))
                        (list? (third f))))
  (define empty-bag (fifo-cons '() '()))
  (define (bag-empty? f) (and (empty? (fifo-list-in f)) 
                              (empty? (fifo-list-out f))))
  (define (bag-insert f e) (fifo-cons (cons e (fifo-list-in f)) 
                                      (fifo-list-out f)))
  (define (bag-peek f) (cond [(empty? (fifo-list-out f)) (first (reverse (fifo-list-in f)))]
                             [else (first (fifo-list-out f))]))
  (define (bag-remove f) (cond [(empty? (fifo-list-out f)) (fifo-cons '() (cdr (reverse (fifo-list-in f))))]
                               [else (fifo-cons (fifo-list-in f) (cdr (fifo-list-out f)))]))
)

;; otwarcie komponentów stosu i kolejki

(define-values/invoke-unit bag-stack@
  (import)
  (export (prefix stack: bag^)))

(define-values/invoke-unit bag-fifo@
  (import)
  (export (prefix fifo: bag^)))

;; testy w Quickchecku
(require quickcheck)

;; testy kolejek i stosów
(define-unit bag-tests@
  (import bag^)
  (export)
  
  ;; test przykładowy: jeśli do pustej struktury dodamy element
  ;; i od razu go usuniemy, wynikowa struktura jest pusta
  (quickcheck
   (property ([s arbitrary-symbol])
             (bag-empty? (bag-remove (bag-insert empty-bag s)))))
  (quickcheck
   (property ([s arbitrary-symbol])
             (bag? (bag-insert empty-bag s))))
  (quickcheck
   (property ([s arbitrary-symbol])
             (eq? s (bag-peek (bag-insert empty-bag s)))))
  (quickcheck
   (property ([s arbitrary-symbol])
             (not (empty? (bag-insert empty-bag s)))))
)

;; uruchomienie testów dla obu struktur danych

(invoke-unit bag-tests@ (import (prefix stack: bag^)))
(invoke-unit bag-tests@ (import (prefix fifo: bag^)))

(define-unit stack-test@
  (import bag^)
  (export)

  (quickcheck
   (property ([s arbitrary-symbol]
              [t arbitrary-symbol])
             (eq? t (bag-peek (bag-insert (bag-insert empty-bag s) t)))))
    
   (quickcheck
   (property ([s arbitrary-symbol]
              [u arbitrary-symbol]
              [t arbitrary-symbol]
              [y arbitrary-symbol])
             (and (eq? y (bag-peek (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))
                  (eq? t (bag-peek (bag-remove 
                            (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y))))
                  (eq? u (bag-peek (bag-remove 
                            (bag-remove (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))))
                  (eq? s (bag-peek (bag-remove
                            (bag-remove 
                                (bag-remove (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))))))))
)

(define-unit fifo-test@
  (import bag^)
  (export)

  (quickcheck
   (property ([s arbitrary-symbol]
              [t arbitrary-symbol])
             (eq? s (bag-peek (bag-insert (bag-insert empty-bag s) t)))))

  (quickcheck
   (property ([s arbitrary-symbol]
              [u arbitrary-symbol]
              [t arbitrary-symbol]
              [y arbitrary-symbol])
             (and (eq? s (bag-peek (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))
                  (eq? u (bag-peek (bag-remove 
                            (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y))))
                  (eq? t (bag-peek (bag-remove 
                            (bag-remove (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))))
                  (eq? y (bag-peek (bag-remove
                            (bag-remove 
                                (bag-remove (bag-insert (bag-insert (bag-insert (bag-insert empty-bag s) u) t) y)))))))))
)

(println '-----------------------------------------------------------------------------)

(invoke-unit stack-test@ (import (prefix stack: bag^)))
(invoke-unit fifo-test@ (import (prefix fifo: bag^)))

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; otwarcie komponentów przeszukiwania 
;; w głąb i wszerz
(define-values/invoke-unit graph-search@
  (import graph^ (prefix stack: bag^))
  (export (prefix dfs: graph-search^)))

(define-values/invoke-unit graph-search@
  (import graph^ (prefix fifo: bag^))
  (export (prefix bfs: graph-search^)))

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))

;; dodane grafy
(define test-graph-longer
  (graph
   (list 1 2 3 4 5 6)
   (list (edge 1 3)
         (edge 1 2)
         (edge 1 4)
         (edge 2 4)
         (edge 3 5)
         (edge 4 6))))

(define test-graph-longest
  (graph
   (list 1 2 3 4 5 6 7)
   (list (edge 1 3)
         (edge 1 2)
         (edge 1 4)
         (edge 2 6)
         (edge 2 7)
         (edge 2 4)
         (edge 3 5)
         (edge 7 1))))


;; uruchomienie przeszukiwania na przykładowym grafie
(bfs:search test-graph 1) ;;fifo
(dfs:search test-graph 1) ;;stack

;; dodane testy
(bfs:search test-graph-longer 1)
(dfs:search test-graph-longer 1)

(bfs:search test-graph-longest 1)
(dfs:search test-graph-longest 1)
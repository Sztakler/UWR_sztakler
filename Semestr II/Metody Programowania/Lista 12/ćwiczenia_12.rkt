#lang racket 

;ćwiczenie 1

(define (average z y)
  (/ (+ z y) 2))

(define (square x)
  (* x x))

(define (dist x y)
  (abs (- x y)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (close-to? a b)
    (< (dist a b) 0.0001))

(define sqrt/c
    (->i ([x positive?])
         [result (x) (and/c positive?
                            (lambda (res) (close-to? x (square res))))]))

(define/contract (sqrt x) sqrt/c
  (define (improve guess)
    (average guess (/ x guess)))

  (define (good-enough? g)
    (< (dist x (square g))
       0.0001))

  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  
  (iter 1.0))

(define/contract wrong-sqrt sqrt/c
    (lambda (x) (- x 1)))

;(sqrt 3)
;(wrong-sqrt 3)


;ćwiczenie 2

(define filter-parametric/c
    (parametric->/c [a]
        (-> (-> a boolean?) (listof a) (listof a))))

;'(1 2) -> '(1 1 2 2)

(define (sublist? xs ys)
    (cond [(null? xs) #t]
          [(null? ys) #f]
          [(if  (equal? (car xs) (car ys))
                (sublist? (cdr xs) (cdr ys))
                (sublist? xs (cdr ys)))]))

(define filter/c
    (parametric->/c [a]
        (->i   ([p? (-> a boolean?)]
                [xs (listof a)])
                [res (listof a)]
                #:post (p? xs res)
                    (sublist? res xs))))

(define (filterek pred xs)
    (parametric->/c [a] (-> (-> a boolean?) (listof a) (listof a)))
    (define (filterek-iter xs ys)
        (cond [(null? xs) ys] ;;poprawnie (reverse ys)
            [(pred (car xs)) (cons (car xs) (filterek-iter (cdr xs) ys))]
            [else (filterek-iter (cdr xs) ys)]))
    (filterek-iter xs '()))

;ćwiczenie 3

(define-signature  monoid^
    (( contracted
        [elem?    (-> any/c  boolean?)]
        [neutral  elem?]
        [oper     (-> elem? elem? elem?)])))

;(define-unit monoid-int@
;  (import)
;  (export monoid^)
;
;    (define (elem? x)
;    (integer? x))
;
;    (define neutral 0)
;
;    (define oper +))

(define-unit monoid-list@
    (import)
    (export monoid^)
    
        (define (elem? l)
            (list? l))
        
        (define neutral '())

        (define oper append))
    
;ćwiczenie 4

(require quickcheck)

;;LICZBY CAŁKOWITE

;(define-values/invoke-unit/infer monoid-int@)
;
;(define left-neutral
;    (property ([x arbitrary-integer])
;        (equal? (oper neutral x) x)))
;
;(define true-neutral
;    (property ([x arbitrary-integer])
;        (and (equal? (oper neutral x) x)
;             (equal? (oper x neutral) x))))
;
;(quickcheck true-neutral)
;
;(define oper-assoc
;;    (property ([a arbitrary-integer]
;;               [b arbitrary-integer]
;;               [c arbitrary-integer])
;;            (equal? (oper (oper a b) c)
;;                    (oper a (oper b c)))))
;;                
;;(quickcheck oper-assoc)
;;
;
;;;LISTY
;
;(define-values/invoke-unit/infer monoid-list@)
;
;(define left-neutral
;    (property ([x arbitrary-integer])
;        (equal? (oper neutral x) x)))
;
;(define true-neutral
;    (property ([xs (arbitrary-list arbitrary-symbol)])
;        (and (equal? (oper neutral xs) xs)
;             (equal? (oper xs neutral) xs))))
;
;(quickcheck true-neutral)
;
;(define oper-assoc
;    (property ([as (arbitrary-list arbitrary-symbol)]
;               [bs (arbitrary-list arbitrary-symbol)]
;               [cs (arbitrary-list arbitrary-symbol)])
;            (equal? (oper (oper as bs) cs)
;                    (oper as (oper bs cs)))))
;
;(quickcheck oper-assoc)
;
;;;ćwiczenie 5

;z wykładu:
(define (sorted? l)
    (cond 
        [(null? l) #t]
        [(null? (cdr l)) #t]
        [else (and (<= (car l) (cadr l))
                   (sorted? (cdr l)))]))

(define-signature intset^
  ((contracted
    [intset?       (-> any/c boolean?)]
    [setmember?    (-> integer? intset? boolean?)]
    [empty-set     intset?]
    [singleton     (-> integer? intset?)]
    [union         (-> intset? intset? intset?)]
    [intersection  (-> intset? intset? intset?)])))

(define (strictly-sorted? l)
  (cond [(null? l) #t]
        [(null? (cdr l)) #t]
        [else (and (< (car l) (cadr l))
                   (strictly-sorted? (cdr l)))]))

(define-unit intset-ordered-list@
  (import)
  (export intset^)

  ; 1. próba:
  ;(define (intset? s)
  ; (and ((listof integer?) s)  (sorted? s)) ;sorted? z k1-sort.rkt

  (define intset?
    (and/c (listof integer?) strictly-sorted?))

  (define (setmember? n ns)
    (cond
      [(null? ns) #f]
      [(= n (car ns)) #t]
      [(> n (car ns)) (setmember? n (cdr ns))]
      [(< n (car ns)) #f]))
;--------------------------------------------------------------
  (define empty-set '())

  (define (singleton x)
    (list x))

  (define (union xs ys)
    (cond [(null? xs) ys]
          [(null? ys) xs]
          [(= (car xs) (car ys)) (cons (car xs) (union (cdr xs) (cdr ys)))]
          [(< (car xs) (car ys)) (cons (car xs) (union (cdr xs) ys))]
          [(> (car xs) (car ys)) (cons (car ys) (union xs (cdr ys)))]))


    (define (intersection xs ys)
        (cond
        [(null? xs) null]
        [(null? ys) null]
        [(= (car xs) (car ys))  (cons (car xs)
                                    (intersection (cdr xs) (cdr ys)))]
        [(< (car xs) (car ys))      (intersection (cdr xs)      ys  )]
        [(> (car xs) (car ys))      (intersection    xs     (cdr ys))]))
)


(define-values/invoke-unit/infer intset-ordered-list@)



(quickcheck  ;; zbiór pusty jest pusty
  (property ([s (arbitrary-list arbitrary-integer)])
    (or (not (equal? s empty-set))
         (equal? s '()))))

(quickcheck ;;singleton zawiera jeden element
    (property ([x arbitrary-integer]
               [y arbitrary-integer])
            (equal? (= x y) (setmember? x (singleton y)))))

(define arbitrary-intlist
    (arbitrary-list arbitrary-integer))
    
(define (intlist->intset xs)
    (if (null? xs)
        empty-set
        (union (singleton (car xs)) (intlist->intset (cdr xs)))))

(quickcheck ;;suma zbiorów
    (property ([xs arbitrary-intlist]
               [ys arbitrary-intlist]
               [a arbitrary-integer])
        (let ([x (intlist->intset xs)]
              [y (intlist->intset ys)])
            (equal? (setmember? a (union x y))
                    (or (setmember? a x) (setmember? a y))))))

(quickcheck ;;iloczyn zbioróœ
    (property ([xs arbitrary-intlist]
               [ys arbitrary-intlist]
               [a arbitrary-integer])
        (let ([x (intlist->intset xs)]
              [y (intlist->intset ys)])
            (equal? (setmember? a (intersection x y))
                    (and (setmember? a x) (setmember? a y))))))

;;suma zbiorów jest rozdzielna względem iloczynu zbiorów

(quickcheck   ; własność niezależna od implementacji
  (property ([xl arbitrary-intlist]
             [yl arbitrary-intlist]
             [zl arbitrary-intlist]
             [a  arbitrary-integer])
  (let ([x (intlist->intset xl)]
        [y (intlist->intset yl)]
        [z (intlist->intset zl)])
    (equal? (setmember? a (union x (intersection y z)))
            (setmember? a (intersection (union x y) (union x z)))))))

;;iloczyn zbiorów jest rozdzielny względem sumy zbiorów

(quickcheck   ; własność niezależna od implementacji
  (property ([xl arbitrary-intlist]
             [yl arbitrary-intlist]
             [zl arbitrary-intlist]
             [a  arbitrary-integer])
  (let ([x (intlist->intset xl)]
        [y (intlist->intset yl)]
        [z (intlist->intset zl)])
    (equal? (setmember? a (intersection x (union y z)))
       (setmember? a (union (intersection x y) (intersection x z))))
  )
))

(cons 3 '(1 2))
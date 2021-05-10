#lang racket

(define test-list (list 6 2 3 1 0 4 5 9))

;; wersja 1
;(define sorts1/c (-> (listof integer?) (listof integer?)))
;
;(define/contract sort1 sorts1/c (lambda (x) (sort x <)))
;
;
;;(sort1 test-list)
;
;(define/contract sort1-id sorts1/c (lambda (x) x))

;(sort1-id test-list)

;; wersja 1
(define sorts1/c (-> (listof integer?) (listof integer?)))

(define/contract sort1 sorts1/c (lambda (x) (sort x <)))

;(sort1 test-list)

(define/contract sort1-id sorts1/c (lambda (x) x))

;(sort1-id test-list)


;; wersja 2

(define (sorted? l)
    (cond 
        [(null? l) #t]
        [(null? (cdr l)) #t]
        [else (and (<= (car l) (cadr l))
                   (sorted? (cdr l)))]))

;(sorted? test-list)
;(sorted? (sort1 test-list))

(define sorts2/c (-> (listof integer?) (and/c (listof integer?) sorted?)))

(define/contract sort2 sorts2/c (lambda (x) (sort x <)))

(define/contract sort2-id sorts2/c (lambda (x) x))

;(sort2 test-list)
;(sort2-id test-list)

(define/contract sort2-null sorts2/c (lambda (x) '()))

;(sort2-null test-list)

;; wersja 3

(define (contains? l1 l2)
    (andmap (lambda (x) (member x l2)) l1))

(define (contains/c l)
    (lambda (l2) (contains? l l2)))

;;KONTRAKT ZALEŻNY

(define sorts3/c 
    (->i ([l (listof integer?)])
         [result (l) (and/c (listof integer?)
                             sorted?
                             (contains/c l))]))

(define/contract sort3 sorts3/c (lambda (x) (sort x <)))

(define/contract sort3-null sorts3/c (lambda (x) '()))

;(sort3 test-list)
;(sort3-null test-list)

(define/contract sort3-add sorts3/c
    (lambda (x) (cons (- (apply min (cons 0 x)) 1) (sort x <))))

;(sort3-add test-list)

;;wersja 4

(define (contained/c l)
    (lambda (l2) (contains? l2 l)))

(define sorts4/c
    (->i ([l (listof integer?)])
         [result (l) (and/c (listof integer?)
                            sorted?
                            (contains/c l)
                            (contained/c l))]))

(define/contract sort4 sorts4/c (lambda (x) (sort x <)))

(define/contract sort4-add sorts4/c
    (lambda (x) (cons (- (apply min (cons 0 x)) 1) (sort x <))))

;(sort4 test-list)
;(sort4-add test-list)

(define/contract sort4-dbl sorts4/c (lambda (x) (sort (append x x) <)))

;(sort4-dbl test-list)

;;wersja 5 POPRAWNY KONTRAKT

(define (permutation? l1 l2)
    (cond [(and (null? l1) (null? l2)) #t]
          [(null? l1) #f]
          [(not (member (car l1) l2)) #f]
          [else (permutation? (cdr l1) (remove (car l1) l2))]))

(define sorts5/c
    (->i ([l (listof integer?)])
        [result (l) (and/c (listof integer?) sorted?)]
        #:post (l result)
        (permutation? l result)))

(define/contract sort5 sorts5/c (lambda (x) (sort x <)))

(define/contract sort5-dbl sorts5/c (lambda (x) (sort (append x x) <)))

;; quickcheck

(require quickcheck)

;(define (is-sorting s)
;    (property ([l (arbitrary-list arbitrary-integer)])
;        (let ([sl (s l)])
;            (and (sorted? sl)
;                 (permutation? l sl)))))

(define (is-sorting s)
  (property ([l (arbitrary-list arbitrary-integer)])
            (let ((sl (s l)))
              (and (sorted? sl) 
                   (permutation? l sl)))))                
            

;(quickcheck (is-sorting sort1))
;(quickcheck (is-sorting sort1-id))

;;QUICKCHECK

(define (square x) (* x x))

(define (close-enough? x y)
    (< (abs (- x y)) 0.000001))


;(quickcheck
;    (property ([x arbitrary-real])
;        (close-enough? x (square (sqrt x)))))

;(square (sqrt 1.25))

;(quickcheck
;    (property ([x arbitrary-real]
;               [y arbitrary-real])
;        (close-enough? (sqrt (* x y)) (* (sqrt x) (sqrt y)))))

(define (close-enough-complex? x y)
    (< (magnitude (- x y)) 0.000001))

;(quickcheck
;    (property ([x arbitrary-real]
;               [y arbitrary-real])
;        (close-enough-complex? (sqrt (* x y)) (* (sqrt x) (sqrt y)))))
;
;(* (sqrt -0.3333333333333333) (sqrt -2.0))
;
;(sqrt (* -0.3333333333333333 -2.0))

;(quickcheck
;    (property ([x arbitrary-real]
;               [y arbitrary-real])
;               (==> (positive? x)
;                    (==> (positive? y)
;        (close-enough-complex? (sqrt (* x y)) (* (sqrt x) (sqrt y)))))))
;
;(quickcheck
;    (property ([x (choose-real 0 1000)]
;               [y (choose-real 0 1000)])
;        (close-enough-complex? (sqrt (* x y)) (* (sqrt x) (sqrt y)))))
;

;(quickcheck
;    (property ([x arbitrary-symbol]
;               [y arbitrary-symbol])
;               (and (eq? x (car (cons x y))) (eq? y (cdr (cons x y))))))

;(quickcheck 
; (property ([l (arbitrary-list arbitrary-symbol)]
;            [p (arbitrary-procedure arbitrary-symbol arbitrary-symbol)])
;            (eq? (length l) (length (map p l)))))

;(quickcheck                                                                
;    (property ([l1 (arbitrary-list arbitrary-symbol)]                          
;               [l2 (arbitrary-list arbitrary-symbol)])                     
;               (eq? (+ (length l1) (length l2)) (length (append l1 l2)))))

;(quickcheck
;    (property ([l1 (arbitrary-list arbitrary-symbol)]
;               [l2 (arbitrary-list arbitrary-symbol)]
;               [p (arbitrary-procedure arbitrary-symbol arbitrary-symbol)])
;               (equal? (map p (append l1 l2)) (append (map p l1) (map p l2)))))

(define/contract (bad-map f xs)
    (parametric->/c [a b] (-> (-> a b) (listof a) (listof b)))
    (define (map-iter xs ys)
        (cond [(null? xs) ys] ;;poprawnie (reverse ys)
              [else (map-iter (cdr xs) (cons (f (car xs)) ys))]))
    (map-iter xs '()))

;(quickcheck
;    (property ([l1 (arbitrary-list arbitrary-symbol)]
;               [l2 (arbitrary-list arbitrary-symbol)]
;               [p (arbitrary-procedure arbitrary-symbol arbitrary-symbol)])
;               (equal? (bad-map p (append l1 l2)) (append (bad-map p l1) (bad-map p l2)))))
;
;(bad-map identity (append '(Z) '(vGD lb)))
;(append (bad-map identity '(Z)) (bad-map identity '(vGD lb)))

;;UNITY I SYGNATURY

;(define-signature dict^
;    (dict? dict-empty? empty-dict dict-insert dict-remove dict-lookup))


;z kontraktami

;(define-signature dict^
;    ((contracted
;        [dict?       (-> any/c boolean?)]
;        [dict-empty? (-> dict? boolean?)]
;        [empty-dict  (and/c dict? dict-empty?)]
;        [dict-insert (-> dict? string? any/c dict?)]
;        [dict-remove (-> dict? string? dict?)]
;        [dict-lookup (-> dict? string? 
;                         (or/c (cons/c string? any/c)
;                               #f))])))

;Z kontraktami zależnymi

(define-signature dict^
    ((contracted
        [dict?       (-> any/c boolean?)]
        [dict-empty? (-> dict? boolean?)]
        [empty-dict  (and/c dict? dict-empty?)]
        [dict-insert (->i ([d dict?] 
                           [k string?]
                           [v any/c])
                           [result (and/c dict? (not/c dict-empty?))]
                           #:post (result k v)
                           (let ([p (dict-lookup result k)])
                            (and (pair? p)
                                 (eq? (car p) k)
                                 (eq? (cdr p) v))))]
        [dict-remove (->i ([d dict?]
                           [k string?])
                           [result dict?]
                           #:post (result k)
                           (eq? #f (dict-lookup result k)))]
        [dict-lookup (->i ([d dict?]
                           [k string?])
                           [result (or/c (cons/c string? any/c) #f)]
                           #:post (result d)
                           (if (dict-empty? d) (eq? #f result) #t))])))


(define-unit dict-list@
   (import)
    (export dict^)

    (define (dict? d)
        (and (list? d)
        (eq? (length d) 2)
        (eq? (car d) 'dict-list)))

    (define (dict-list d) (cadr d))
    (define (dict-cons l) (list 'dict-list l))

    (define (dict-empty? d)
        (eq? (dict-list d) '()))
    
    (define empty-dict (dict-cons '()))

    (define (dict-lookup d k)
        (assoc k (dict-list d)))
    
    (define (dict-remove d k)
        (dict-cons (remf (lambda (p) (eq? (car p) k)) (dict-list d))))

    (define (dict-insert d k v)
        (dict-cons (cons (cons k v)
                         (dict-list (dict-remove d k))))))

;;empty-dict ;póki co nie działa, trzeba dodać:

(define-values/invoke-unit/infer dict-list@)

;empty-dict

(define dx1 (dict-insert empty-dict "x" 1))
(define dx2 (dict-insert dx1 "x" 2))
(define dx1y2 (dict-insert dx1 "y" 2))
;dx1
;dx2
;dx1y2
;(dict-lookup dx1y2 "y")
;(dict-lookup "y" dx1y2)

(define (list->dict l)
    (cond [(null? l) empty-dict]
          [else (dict-insert (list->dict (cdr l)) (caar l) (cdar l))]))

(define arbitrary-list-dict
    (arbitrary-list (arbitrary-pair arbitrary-string arbitrary-integer)))

;(quickcheck
;    (property
;        ([l arbitrary-list-dict]
;         [k arbitrary-string]
;         [v arbitrary-integer])
;        (let* ([d (list->dict l)]
;               [di (dict-insert d k v)]
;               [dl (dict-lookup di k)])
;            (and (pair? dl)
;                 (eq? (car dl) k)
;                 (eq? (cdr dl) v)))))

;===================================================
;===================================================
;===================================================

;;LISTA ZAGADNIEŃ

;ćw. 1

;(quickcheck
;    (property ([x arbitrary-real])
;        (close-enough? x (square (sqrt x)))))

(define sqrt/c
    (->i ([x real?]) 
         [result (x) complex?]
        #:post (result x)
        (close-enough-complex? x (square (sqrt x)))))

(define/contract sqrt-good 
    sqrt/c
    (lambda (x) (sqrt x)))

;(sqrt-good 2)

;===================================================

;ćw. 2

;filter parametrycznie 

;(define (filterek pred xs)
;    (parametric->/c [a] (-> (-> a boolean?) (listof a) (listof a)))
;    (define (filterek-iter xs ys)
;        (cond [(null? xs) ys] ;;poprawnie (reverse ys)
;            [(pred (car xs)) (cons (car xs) (filterek-iter (cdr xs) ys))]
;            [else (filterek-iter (cdr xs) ys)]))
;    (filterek-iter xs '()))

(define (satisfy-pred? pred xs)
    (cond [(null? xs) #t]
          [else (and (pred (car xs)) (satisfy-pred? pred (cdr xs)))]))

(define (satisfying-sublist? pred xs ys)
    (cond [(null? xs) #t]
          [else (let ([v (car xs)])
                  (and (pred v) 
                     (member v ys)
                     (satisfying-sublist? pred (cdr xs) ys)))]))


;(satisfying-sublist? positive? (list 1 3) (list 1 -1 2 -2))

(define filterek/c
    (->i ([p (-> any/c boolean?)]
          [xs (listof any/c)])
          [result (listof any/c)]
          #:post (p xs result)
          (and (satisfy-pred? p result)
               (satisfying-sublist? p result xs))))

(define/contract (filterek pred xs)
    filterek/c
    (define (filterek-iter xs ys)
        (cond [(null? xs) ys]
            [(pred (car xs)) (cons (car xs) (filterek-iter (cdr xs) ys))]
            [else (filterek-iter (cdr xs) ys)]))
    (filterek-iter xs '()))

;(filterek positive? (list 1 -1 2 -2))
;(equal? (filter positive? (list 1 -1 2 -2)) (filterek positive? (list 1 -1 2 -2)))
;(equal? (filter negative? (list 1 -1 2 -2)) (filterek negative? (list 1 -1 2 -2)))
;(equal? (filter negative? (list )) (filterek negative? (list )))
;(equal? (filter number? (list 'a "a" 1 -2)) (filterek number? (list 'a "a" 1 -2)))





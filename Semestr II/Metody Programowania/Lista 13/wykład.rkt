#lang typed/racket

;(define (dist x y)
;    (abs (- x y)))

;; SYGNATURA TYPOWA
(: dist (-> Real Real Real))
(define (dist x y)
    (abs (- x y)))

;(dist 1 2)
;(dist 1 'x) ;;błąd typu

(: average (-> Real Real Real))
(define (average x y)
    (/ (+ x y) 2))

(: square (-> Real Real))
(define (square x)
    (* x x))

(: sqrt (-> Real Real))
(define (sqrt x)
   (: improve (-> Real Real))
    (define (improve approx)
        (average (/ x approx) approx))
    (: good-enough? (-> Real Boolean))
    (define (good-enough? approx)
        (< (dist x (square approx)) 0.0001))
    (: iter (-> Real Real))
    (define (iter approx)
        (cond [(good-enough? approx) approx]
              [else (iter (improve approx))]))
    (iter 1.0))

;(sqrt 2)

;; TYPY ZŁOŻONE

(define-type Rational (Pairof Integer Integer))

(: make-rational (-> Integer Integer Rational))
(define (make-rational n d)
    (let ([c (gcd n d)])
        (cons (quotient n c) (quotient d c))))

;(make-rational 1 2)

(: rat-numer (-> Rational Integer))
(define (rat-numer l)
    (car l))

(: rat-den (-> Rational Integer))  
(define (rat-den l)
    (cdr l))


;; KONWERSJA

(: integer->rational (-> Integer Rational))
(define (integer->rational n)
    (make-rational n 1))

;(: rat? (-> Any Boolean : Rational))
;(define (rat? x)
;    (and (pair? x)
;         (integer? (car x))
;         (integer? (cdr x))))

(define-predicate rational? Rational)

(: to-rat (-> (U Integer Rational) Rational))
(define (to-rat n)
    (cond [(integer? n) (integer->rational n)]
          [(rational? n) n]))

(: div-rat (-> Rational Rational Rational))
(define (div-rat r1 r2)
    (let ([n (* (rat-numer r1) (rat-den r2))]
          [d (* (rat-den r1) (rat-numer r2))])
        (make-rational n d)))

(: print-rat (-> Rational Void))
(define (print-rat r)
    (display (rat-numer r))
    (display "/")
    (display (rat-den r)))

;(print-rat (make-rational 1 2))


;; LISTY

(: length (-> (Listof Any) Nonnegative-Integer))
(define (length xs)
    (if (null? xs)
        0
        (+ 1 (length (cdr xs)))))

;(length (list 1 2 3))
;(length '(1 2))

(: append (All (a) (-> (Listof a) (Listof a) (Listof a))))
(define (append xs ys)
    (if (null? xs)
        ys
        (cons (car xs) (append (cdr xs) ys))))

;(append '(1 2) '( "z" 'y))

(: map (All [a b] (-> (-> a b) (Listof a) (Listof b))))
(define (map f xs)
    (if (null? xs)
        null
        (cons (f (car xs))
              (map f (cdr xs)))))

;(map number->string '(1 2 3))


;; TYPY REKURENCYJNE (drzewa przeszukiwań binarnych)

;(define-type Leaf 'leaf)
;(define-type (Node a) (List 'node a (Tree a) (Tree a)))
;(define-type (Tree a) (U Leaf (Node a)))
;
;(define-predicate leaf? Leaf)
;(define-predicate node? (Node Any))
;(define-predicate tree? (Tree Any))
;
;(: leaf Leaf)
;(define leaf 'leaf)
;
;(: node-val (All [a] (-> (Node a) a)))
;(define (node-val n)
;    (cadr n))
;
;(: node-left (All [a] (-> (Node a) (Tree a))))
;(define (node-left x)
;    (caddr x))
;
;(: node-right (All [a] (-> (Node a) (Tree a))))
;(define (node-right x)
;    (cadddr x))
;
;(: make-node (All [a] (-> a (Tree a) (Tree a) (Node a))))
;(define (make-node v l r)
;    (list 'node v l r))
;
;(: find-bst (-> Real (Tree Real) Boolean))
;(define (find-bst x t)
;    (cond [(leaf? t) false]
;          [(= x (node-val t)) true]
;          [(< x (node-val t)) (find-bst x (node-left t))]
;          [else (find-bst x (node-right t))]))
;
;(define example-tree 
;    (make-node 2 (make-node 1 leaf leaf) (make-node 3 leaf leaf)))
;
;(find-bst 2 example-tree)
;
;(find-bst 1 example-tree)
;
;(find-bst 1.5 example-tree)
;
;(: insert-bst (-> Real (Tree Real) (Tree Real)))
;(define (insert-bst x t)
;    (cond [(leaf? t)
;             (make-node x leaf leaf)]
;          [(< x (node-val t))
;           (make-node (node-val t) 
;                      (insert-bst x (node-left t))
;                      (node-right t))]
;          [else (make-node (node-val t)
;                           (node-left t)
;                           (insert-bst x (node-right t)))]))
;
;(: tree-map (All [a b] (-> (-> a b) (Tree a) (Tree b))))
;(define (tree-map f t)
;    (cond [(leaf? t) t]
;          [else (make-node (f (node-val t))
;                           (tree-map f (node-left t))
;                           (tree-map f (node-right t)))]))

;(tree-map number->string example-tree)

;; TYPOWANE STRUKTURY

(struct leaf () #:transparent)
(struct [a] node ([val : a] [l : (Tree a)] [r : (Tree a)]) #:transparent)

(define-type (Tree a) (U leaf (node a)))

(define-predicate tree? (Tree Any))

(: find-bst (-> Real (Tree Real) Boolean))
(define (find-bst v t)
    (match t
        [(leaf) #f]
        [(node w l r)
         (cond [(= v w) true]
               [(< v w) (find-bst v l)]
               [else (find-bst v r)])]))

(: insert-bst (-> Real (Tree Real) (Tree Real)))
(define (insert-bst v t)
    (match t
        [(leaf) (node v (leaf) (leaf))]
        [(node w l r)
         (if (< v w)
             (node w (insert-bst v l) r)
             (node w l (insert-bst v r)))]))

;(insert-bst 1 (leaf))


;; Typy dla wyrażeń z drugiej tercji


(define-type Expr (U const binop))
(define-type BinopSym (U '+ '- '* '\))
(define-type Value Number)

(define const ([val : Number]) #:transparent)
(define binop ([op : BinopSym] [l : Expr] [r : Expr]) #:transparent)

(define-predicate binop-sym? BinopSym)
(define-predicate expr? Expr)
(define-predicate value? Value)


(: parse (-> Any Expr))
(define (parse q)
    (match q 
        [(? number?) (const q)]
        ;['((? binop-sym? op), e1, e2)
        ;    (binop op (parse e1) (parse e2))]))
        ['(,op ,e1 ,e2)
            #:when (binop-sym? op)
            (binop op (parse e1) (parse e2))]))


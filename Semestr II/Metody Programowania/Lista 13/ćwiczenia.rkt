#lang typed/racket 

;; ćwiczenie 1

(: prefixes (All (a) (-> (Listof a) (Listof (Listof a)))))
(define (prefixes xs)
    (if (null? xs) 
        (list xs)
        (cons null (map (ann (lambda (x) (cons (car xs) x)) (-> (Listof a) (Listof a))) (prefixes (cdr xs))))))
    

;; ćwiczenie 2

(struct vector2  ([x : Real] [y : Real])            #:transparent)
(struct vector3  ([x : Real] [y : Real] [z : Real]) #:transparent)

(require "k1-sqrt.rkt")

(: vector-lenght-match (-> (U vector2 vector3) Number))
(define (vector-lenght-match v)
    (match v
           [(vector2 x y)   (sqrt (+ (* x x) (* y y)))]
           [(vector3 x y z) (sqrt (+ (* x x) (* y y) (* z z)))]))

(: vector-lenght-match (-> (U vector2 vector3) Number))
(define (vector-length-cond v)
    (cond [(vector2? v) 
            (let ([x (vector2-x v)]
                  [y (vector2-y v)])
                (sqrt (+ (* x x) (* y y))))]
          [(vector3? v) 
            (let ([x (vector3-x v)]
                  [y (vector3-y v)]
                  [z (vector3-z v)])
                (sqrt (+ (* x x) (* y y) (* z z))))]))

;(: fold-right (All (a b) (-> (-> a b b) b (Listof a) b)))
;(define (fold-right f acc xs)
;    (if (null? xs)
;      acc
;      (f (car xs) (fold-right f acc (cdr xs)))))

(: fold-right (All (a b) (-> (-> a a a) a (Listof a) a)))
(define (fold-right f acc xs)
    (if (null? xs)
      acc
      (f (car xs) (fold-right f acc (cdr xs)))))

;(fold-right (lambda ([x : Number] [acc : Number]) (+ x acc)) 0 '(1 2 3))


;;błędna implementacja
;(: wrong-fold-right (All (a b) (-> (-> a b b) b (Listof a) b)))
;(define (wrong-fold-right f acc xs)
;  (if (null? xs)
;      acc
;      (car xs)))

; ćwiczenie 4

(struct leaf ()                       #:transparent)
(struct [a b] node ([v : a] [xs : b]) #:transparent)

(define-type (Rosetree a) (U leaf (node a (Listof (Rosetree a)))))

(define-predicate rosetree? (Rosetree Any))


(define example-rosetree
  (node 1 (list (leaf) (node 2 (list)) (node 3 (list)))))

(: map (All (a b) (-> (-> a b) (Listof a) (Listof b))))
(define (map f xs)
  (if (null? xs)
      xs
      (cons (f (car xs)) (map f (cdr xs)))))

(: preorder (All (a) (-> (Rosetree a) (Listof a))))
(define (preorder t)
  (match t
    [(leaf)      (list)]
    [(node v xs) (cons v (apply append (map (ann preorder (-> (Rosetree a) (Listof a))) xs)))]))

(preorder example-rosetree)

;; ćwiczenie 5
#lang racket

(require racket/contract)

(provide (contract-out
    [with-labels  with-labels/c]
    [foldr-map  foldr-map/c]
    [pair-from  pair-from/c ]))

(provide with-labels/c  foldr-map/c  pair-from/c)

(define with-labels/c
    (parametric->/c [x fx] ((x . -> . fx)
                            (listof x) 
                            . -> . 
                            (listof (cons/c fx (cons/c x null))))))

(define (with-labels f xs)
        (if (null? xs)
            null
            (let ([x (car xs)])
                (cons (list (f x) x) 
                      (with-labels f (cdr xs))))))
    
;(with-labels number->string (list 1 2 3))

(define foldr-map/c 
    (parametric->/c [e a ve] (-> (-> e a (cons/c ve a))
                                 a 
                                 (listof e)
                                 (cons/c (listof ve) a))))

(define (foldr-map f a xs)
    (define (it a xs ys)
        (if (null? xs)
            (cons ys a)
            (let [(p (f (car xs) a))]
                (it (cdr p) 
                    (cdr xs) 
                    (cons (car p) ys)))))
    (it a (reverse xs) null))

;(foldr-map (lambda(x a) (cons a (+ a x))) 0'(1 2 3))


(define pair-from/c
    (parametric->/c [x fx gx] ((x . -> . fx)
                               (x . -> . gx)
                               . -> .
                               (x . -> . (cons/c fx gx)))))

(define (pair-from f g)
    (lambda (x) (cons (f x) 
                      (g x))))

;((pair-from (lambda(x) (+ x 1)) (lambda(x) (* x 2))) 2)
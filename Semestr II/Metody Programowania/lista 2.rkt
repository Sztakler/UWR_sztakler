#lang racket

(define (compose f g)
  (lambda (s)
          (f (g s))))

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))
          
;((compose square inc) 5)

;((compose inc square) 5)

(define (identity x)
  x)

(define (repeated p n)
  (if (= n 0)
      (identity p)
      (compose p (repeated p (- n 1)))))

 ;((repeated square 0) 2)
 ;((repeated square 1) 2)
 ;((repeated square 2) 2)


(define (sum val next start end)
  (if (> start end)
      0
      (+ (val start)
         (sum val next (next start) end))))

(define (product-rec val next start end)
  (if (> start end)
      1
      (* (val start) (product-rec val next (next start) end))))

(define (product-iter val next res start end)
  (if (> start end)
      res
      (product-iter val next (* res (val start)) (next start) end)))

(define (product-it val next start end)
  (product-iter val next (val start) (next start) end))

(product-rec (lambda (x) (/ 1 x)) (lambda (x) (+ 1 x)) 1 6)
(product-it (lambda (x) (/ 1 x)) (lambda (x) (+ 1 x)) 1 6)

(* (product-rec (lambda (x) (* (/ x (+ x 1)) (/ (+ x 2) (+ x 1)))) (lambda (x) (+ x 3)) 2 10) 4)


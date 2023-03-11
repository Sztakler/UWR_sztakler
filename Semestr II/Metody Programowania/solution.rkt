#lang racket
(provide cube-root)
(provide cube)

;;kod napisany na podstawie kodu z wykładu

(define (cube x)
    (* x x x))

(define (cube-root x)
  (define (good-enough? guess)
    (< (distance x (cube guess))
       0.000000000001))
  (define (distance x y)
    (abs (- x y)))
  (define (square a)
    (* a a))
  (define (cube-average x y)
    (/ (+ x y) 3))
  (define (improve guess)
    (cube-average (/ x (square guess)) (* 2 guess)))
  
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  (iter 1.0))

(cube (cube-root 8))
(cube (cube-root 216))
(cube (cube-root 718))
(cube (cube-root 42))
(cube (cube-root 999))
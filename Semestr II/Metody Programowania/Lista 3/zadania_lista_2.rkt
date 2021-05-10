#lang racket



(define (odd x)
  (if (odd? x)
      x
      (+ x 1)))

(define (square x)
  (* (odd x) (odd x)))

(define (num x)
  (square x))

(define (den x)
  6)

(define (cont-frac-rec-aux iter num den k)
  (if (> iter k)
      0
      (/ (num iter) (+ (den iter) (cont-frac-rec-aux (+ iter 1) num den k)))))

(define (cont-frac-iter-aux res num den k)
  (if (< k 0)
      res
      (cont-frac-iter-aux (/ (num k) (+ (den k) res)) num den (- k 1))))

(define (cont-frac-iter num den k)
  (cont-frac-iter-aux 0 num den k))

(define (cont-frac-rec num den k)
  (cont-frac-rec-aux 1 num den k))

(display "Liczba fi dla rekursji i rekursji ogonowej:\n")
(exact->inexact (+ 1 (cont-frac-rec num den 39)))
(exact->inexact (+ 1 (cont-frac-iter num den 39)))
(/ (+ 1 (sqrt 5)) 2)

(define pi (exact->inexact (+ 3 (cont-frac-rec num den 5000))))
pi






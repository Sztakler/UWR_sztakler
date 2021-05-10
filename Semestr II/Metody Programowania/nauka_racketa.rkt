#lang racket

(define (fib-iter n i prev res)
  (if (= i n)
      res
      (fib-iter n (+ i 1) res (+ res prev))))

(define (fib n)
  (fib-iter n 1 1 1))

(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


(gcd 41 123)


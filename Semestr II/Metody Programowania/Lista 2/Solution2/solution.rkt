#lang racket

;;Zadanie wykonane wspólnie przez:
;;Piotr Dobiech
;;Bartosz Janikowski
;;Krystian Jasionek

;;Po konsultacji z:
;;Cezary Świtała

(provide nth-root)

(define (average x y)
  (/ (+ x y) 2))
 
(define (close-to? x y)
  (< (abs (- x y)) 0.00001))

(define (fixed-point s f)
  (if (close-to? s (f s))
      s
      (fixed-point (f s) f)))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

;;Funkcja repeated z cw.3

(define (repeated p n)
  (define (compose f g) (lambda (x) (f (g x))))
  (define (identity x) x)
  (if (= n 0)
      identity
      (compose p (repeated p (- n 1)))))


(define (nth-root n x)
  (define (nth-root-aux damp number power)
    (fixed-point 1.0 ((repeated average-damp damp) (lambda (x) (/ number (expt x (- power 1)))))))
  (nth-root-aux (floor (log n 2)) x n))

(nth-root 2 2)
(nth-root 100 1000000000000000000000)
(nth-root 3 -2)
(nth-root 2 0)
(nth-root 2 4)


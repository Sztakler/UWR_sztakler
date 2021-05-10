#lang racket

;;Zadanie wykonane wspólnie przez:
;;Piotr Dobiech
;;Bartosz Janikowski
;;Krystian Jasionek

;;Po konsultacji z:
;;Cezary Świtała


(provide cont-frac)



(define (is-close? a b epsilon)
  (> epsilon (abs (- a b))))


(define (An-iter-aux Num Den i prev_n-1 prev_n-2 n)
  (if (> i n)
      prev_n-1
      (An-iter-aux Num Den (+ i 1) (+ (* (Den i) prev_n-1) (* (Num i) prev_n-2)) prev_n-1 n)))

(define (An-iter Num Den i)
  (An-iter-aux Num Den 1 0 1 i))


(define (Bn-iter-aux Num Den i prev_n-1 prev_n-2 n)
  (if (> i n)
      prev_n-1
      (Bn-iter-aux Num Den (+ i 1) (+ (* (Den i) prev_n-1) (* (Num i) prev_n-2)) prev_n-1 n)))

(define (Bn-iter Num Den i)
  (Bn-iter-aux Num Den 1 1 0 i))



(define (cont-frac-iter Num Den i prev res)
  (if (is-close? prev res 0.00001)
      res
      (cont-frac-iter Num Den (+ i 1) res (/ (An-iter Num Den i) (Bn-iter Num Den i)))))

(define (cont-frac Num Den)
  (cont-frac-iter Num Den 3 (/ (An-iter Num Den 1.0) (Bn-iter Num Den 1.0)) (/ (An-iter Num Den 2.0) (Bn-iter Num Den 2.0))))
  
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0))

(define (arctg x)
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   (sqr (* (- i 1) x))))
             (lambda (i) (- (* 2 i) 1))))

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0))

;;Testy:

(arctg 1.0)
(atan 1.0)

(arctg 1.5)
(atan 1.5)

(arctg 0.5)
(atan 0.5)

(arctg 1.67)
(atan 1.67)



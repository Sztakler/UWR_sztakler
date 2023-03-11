#lang racket

-

(provide (struct-out complex) parse eval)

(struct complex (re im) #:transparent)

(define value?
  complex?)

;; Ponizej znajduje sie interpreter zwyklych wyrazen arytmetycznych.
;; Zadanie to zmodyfikowac go tak, by dzialal z liczbami zespolonymi.

(struct const (val)    #:transparent)
(struct binop (op l r) #:transparent)
(struct i ()           #:transparent)

(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /]))

(define (eval e)
  (match e
    [(const n) (complex n 0)]
    [(i) (complex 0 1)]
    [(binop op l r)
     (let* ([val-l (eval l)]
           [val-r (eval r)]
           [a (complex-re val-l)]
           [b (complex-im val-l)]
           [c (complex-re val-r)]
           [d (complex-im val-r)])
       (cond
         [(eq? op '+) (complex (+ a c) (+ b d))]
         [(eq? op '-) (complex (- a c) (- b d))]
         [(eq? op '*) (complex (- (* a c) (* b d)) (+ (* a d) (* b c)))]
         [(eq? op '/) (complex (/ (+ (* a c) (* b d)) (+ (sqr c) (sqr d)))
                               (/ (- (* b c) (* a d)) (+ (sqr c) (sqr d))))]))]))

(define (parse q)
  (cond [(number? q) (const q)]
        [(eq? q 'i) (i)]
        [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
         (binop (first q) (parse (second q)) (parse (third q)))]))


;Testowanko
(eval (parse '(* (- 3 (* 5 i)) (- 3 (* 5 i)))))
(eval (parse '(+ 3 (* 5 i))))
(eval (parse 'i))
(eval (parse '(* i i)))
(eval (parse '(+ 3 (* i 5))))
(eval (parse '(/ (+ 3 (* 6 i)) (+ 2 (* 9 i)))))
(eval (parse '1))

;Powinno być
;complex -16 -30)
;(complex 3 5)
;(complex 0 1)
;(complex -1 0)
;(complex 3 5)
;(complex 12/17 -3/17)
;(complex 1 0)
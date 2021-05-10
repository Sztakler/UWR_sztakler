#lang racket

(struct const (val)    #:transparent)
(struct binop (op l r) #:transparent)
(struct monop (op arg) #:transparent)
(struct variable ()    #:transparent)

; 2 + 2 * 2
(define 2+2*2 (binop '+ (const 2)
                        (binop '* (const 2)
                                  (const 2))))

; Co to są wyrażenia?
(define (expr? e)
  (match e
    [(variable)     true]
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [_ false]))

; Co to są wartości?
(define (value? v)
  (number? v))

(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /] ['^ expt] ['abs abs]))

(define (eval e)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval l) (eval r))]
    [(monop op arg) ((op->proc op) (eval arg))]))

; ------------------------- ;
; Trochę składni konkretnej ;
; ------------------------- ;

(define (parse q)
  (cond [(number? q) (const q)]
  [(eq? q 'x) (variable)]
        [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
         (binop (first q) (parse (second q)) (parse (third q)))]))

(define (test) (eval (parse '(+ (* 2 3) (* 4 5)))))

;;(define (cont-frac-iter iter num den k)  (if (= k iter) 0 (/ (num iter) (+ (den iter) (cont-frac-iter (+ iter 1) num den k)))))

;;;zadanie 2

(define (pi-expr n)
  (define (num x) (+ 1 (* 2 (- x 1))))
  (define (cont-frac-iter iter num den k)
  (if (= k iter)
      (const 0)
      (binop '/ (const (num iter)) (binop '+ (const (den iter)) (cont-frac-iter (+ iter 1) num den k)))))
  (define (cont-frac num den k) (cont-frac-iter 1 num den k))

  (binop '+ (const 3) (cont-frac (lambda (x) (sqr (num x))) (lambda (x) 6.0) n)))

(eval (pi-expr 10))

;;;zadanie 3

(eval (binop '^ (const 2) (const 4)))

(eval (monop 'abs (const -2)))

;;zadanie 4

(define (pretty-print expr)
  (match expr
    [(const n) (number->string n)]
    [(variable) "x"]
    [(monop op arg) (string-append (symbol->string op) "(" (pretty-print arg) ")")]
    [(binop op l r) (string-append "(" (pretty-print l) (symbol->string op) (pretty-print r) ")")]))

(pretty-print (pi-expr 10))

"\u2202"


(pretty-print (parse '(+ (* 2 x) (* x x))))

;;zadanie 5

(define (D function)
    (match function
    [(const n) (const 0)]
    [(variable) (const 1)]
    [(binop op l r) 
      (cond 
      [(eq? op '+) (binop op (D l) (D r))]
      [(eq? op '*) (binop '+ (binop op (D l) r) (binop op l (D r)))]
      [(and (eq? l r) (eq? op '*) (variable? l)) (binop '* (const 2) l)])]))

(pretty-print (D (parse '(+ (* 2 x) (* x x)))))

(D (parse '(* x (+ 2 x))))
(pretty-print (D (parse '(* x (+ 2 x)))))

;;zadanie 6

(define (simpl expr)
  (match expr
    [(const n) (const n)]
    [(variable) (variable)]
    [(binop '+ (const 0) r) (simpl r)]
    [(binop '+ l (const 0)) (simpl l)]
    [(binop '+ l (binop '* (const n) l)) (simpl (binop '* (const (+ n 1)) (simpl l)))]
    [(binop '+ (binop '* (const n) r) r) (simpl (binop '* (const (+ n 1)) (simpl r)))]
    [(binop '+ l (binop '* l (const n))) (simpl (binop '* (const (+ n 1)) (simpl l)))]
    [(binop '+ (binop '* r (const n)) r) (simpl (binop '* (const (+ n 1)) (simpl r)))]
    [(binop '+ l l) (binop '* (const 2) (simpl l))]
    [(binop '* (const 1) r) (simpl r)]
    [(binop '* l (const 1)) (simpl l)]
    [(binop '* (const 0) r) (const 0)]
    [(binop '* l (const 0)) (const 0)]
    [(binop op l r) (binop op (simpl l) (simpl r))]
    ))

(parse '(* 1 (+ x (+ x x))))
(simpl (parse '(* 1 (+ x (+ x x)))))
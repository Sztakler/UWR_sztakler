#lang racket

;Zadanie wykonane wspólnymi siłami z Piotrem Dobiechem i Bartoszem Janikowskim pod superwizją Cezarego Świtały 

(provide (struct-out const) (struct-out binop) (struct-out var-expr) (struct-out let-expr) (struct-out pos) (struct-out var-free) (struct-out var-bound) annotate-expression)

;; ---------------
;; Jezyk wejsciowy
;; ---------------

(struct pos (file line col)     #:transparent)
  
(struct const    (val)          #:transparent)
(struct binop    (op l r)       #:transparent)
(struct var-expr (id)           #:transparent)
(struct let-expr (loc id e1 e2) #:transparent)

(define (expr? e)
  (match e
    [(const n)      (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x)   (symbol? x)]
    [(let-expr loc x e1 e2)
     (and (pos? loc) (symbol? x) (expr? e1) (expr? e2))]
    [_ false]))


(define (make-pos s)
  (pos (syntax-source s)
       (syntax-line   s)
       (syntax-column s)))

(define (parse e)
  (let ([r (syntax-e e)])
    (cond
      [(number? r) (const r)]
      [(symbol? r) (var-expr r)]
      [(and (list? r) (= 3 (length r)))
       (match (syntax-e (car r))
         ['let (let* ([e-def (syntax-e (second r))]
                      [x     (syntax-e (first e-def))])
                 (let-expr (make-pos (first e-def))
                           (if (symbol? x) x (error "parse error!"))
                           (parse (second e-def))
                           (parse (third r))))]
         [op   (binop op (parse (second r)) (parse (third r)))])]
      [else (error "parse error!")])))

;; ---------------
;; Jezyk wyjsciowy
;; ---------------

(struct var-free  (id)     #:transparent)
(struct var-bound (pos id) #:transparent)

(define (expr-annot? e)
  (match e
    [(const n)         (number? n)]
    [(binop op l r)    (and (symbol? op) (expr-annot? l) (expr-annot? r))]
    [(var-free x)      (symbol? x)]
    [(var-bound loc x) (and (pos? loc) (symbol? x))]
    [(let-expr loc x e1 e2)
     (and (pos? loc) (symbol? x) (expr-annot? e1) (expr-annot? e2))]
    [_ false]))

(struct environment (env-list))

(define env-empty (environment null))

(define (env-add x value env)
  (environment (cons (cons x value) (environment-env-list env))))

(define (env-lookup x env)
  (define (assoc-lookup xs)
    (cond [(null? xs) null]
          [(eq? x (car (car xs))) (cdr (car xs))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environment-env-list env)))


(define (annotate-expression e)
  (define (annotate-expression-env e environment)
    (match e
      [(const n) (const n)]
      [(binop op l r) (binop op
                             (annotate-expression-env l environment)
                             (annotate-expression-env r environment))]
      [(let-expr loc id e1 e2) (let-expr loc
                                         id
                                         (annotate-expression-env e1 environment)
                                         (annotate-expression-env e2 (env-add id loc environment)))]
      [(var-expr x)
       (let ([lookup-pos (env-lookup x environment)])
         (if (null? lookup-pos)
             (var-free x)
             (var-bound lookup-pos x)))]
      [_ (error "not found :-(")]))
  
  (annotate-expression-env e env-empty))
             


;(let-expr
; (pos'|interactions from an unsaved editor| 3 38)
; 'x
; (const  5)
; (binop
;  '*
;  (var-free'y)
;  (var-bound (pos'|interactions  from an  unsaved  editor| 3 38)'x)))

(annotate-expression (let-expr (pos 'unsaved-editor 123 29) 'x (const 5) (var-expr 'y)))
(newline)

(annotate-expression (parse #'(let [x 5] (* y x))))
(newline)

(annotate-expression (parse #'(let [x 3] (let [y (* x z)] (let [x 0] x)))))
(newline)

(define test (parse #'(let [x 5] x)))
test
(newline)
(annotate-expression test)
(newline)
(newline)

(define test2 (parse #'(let [x 5] y)))
test2
(newline)
(annotate-expression test2)
(newline)
(newline)

(define test3 (parse #'(let [x 5] (* y x))))
test3
(newline)
(annotate-expression test3)
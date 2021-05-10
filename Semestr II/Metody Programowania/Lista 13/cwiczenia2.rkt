#lang typed/racket

; --------- ;
; Wyrazenia ;
; --------- ;

(struct     const        ([val : Number])                  #:transparent)
(struct (E) binop    ([op : Symbol] [l : E] [r : E])   #:transparent)
(struct   var-expr     ([id : Symbol])                   #:transparent)
(struct (E) let-expr ([id : Symbol] [e1 : E] [e2 : E]) #:transparent)

(define-type Expr (U const (binop Expr) var-expr (let-expr Expr)))

(define-predicate expr? Expr)
  #|(match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x) (symbol? x)]
    [(let-expr x e1 e2) (and (symbol? x) (expr? e1) (expr? e2))]
    [_ false]))
|#

(define-type Concrete (U Number
                         Symbol
                         (List 'let (List Symbol Concrete) Concrete)
                         (List (U '+ '- '* '/) Concrete Concrete)))

(define-type LetConcr   (List 'let (List Symbol Concrete) Concrete))
(define-type BinopConcr (List (U '+ '- '* '/) Concrete Concrete))

(define-predicate let-concr? LetConcr)
(define-predicate binop-concr? BinopConcr)

(: parse (-> Concrete Expr))
(define (parse q)
  (cond
    [(number? q) (const q)]
    [(symbol? q) (var-expr q)]
    [(let-concr? q)
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(binop-concr? q)
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))

(define (test-parse) (parse '(let [x (+ 2 2)] (+ x 1))))

; ----------------------- ;
; Podstawienie za zmienna ;
; ----------------------- ;

(: subst (-> Expr Symbol Expr Expr))
(define (subst e1 x e2)
  (match e2
    [(var-expr y) (if (eq? x y) e1 (var-expr y))]
    [(const n) (const n)]
    [(binop op l r)
     (binop op (subst e1 x l) (subst e1 x r))]
    [(let-expr y e3 e4)
     (let-expr y (subst e1 x e3) 
                 (if (eq? x y) e4 (subst e1 x e4)))]))

(define (test-subst)
  (subst (parse '(+ 2 2))
         'x
         (parse '(let [y (+ x 1)] (let [x (+ x y)] (+ y x)))))) 
         
; --------- ;
; Ewaluacja ;
; --------- ;

(define-type Value Number)
(define-predicate value? Value)

(: op->proc (-> Symbol (-> Value Value Value)))
(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /]))

(: eval (-> Expr Value))
(define (eval e)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval l) (eval r))]
    [(let-expr x e1 e2)
     (eval (subst (const (eval e1)) x e2))]))

(define (test-eval) (eval (test-subst)))
(test-parse)
(test-subst)
(test-eval)


#lang typed/racket

; --------- ;
; Wyrazenia ;
; --------- ;

(struct const    ([val : Number])      #:transparent)
(struct (E) binop    ([op : Symbol] [l : E] [r : E])   #:transparent)
(struct var-expr ([id : Symbol])       #:transparent)
(struct (E) let-expr ([id : Symbol] [e1 : E] [e2 : E]) #:transparent)

(define-type Expr (U const (binop Expr) var-expr (let-expr Expr)))

(define-predicate expr? Expr)

(define-type (LetConcr X) (List 'let (List Symbol X) X))
(define-type (BinConcr X) (List (U '+ '* '- '/) X X))

(define-type Concr (U
   Number
   Symbol
   (LetConcr Concr)
   (BinConcr Concr)))

(define-predicate let-concr? (LetConcr Any))
(define-predicate bin-concr? (BinConcr Any))

(: parse (-> Concr Expr))
(define (parse q)
  (cond
    [(number? q) (const q)]
    [(symbol? q) (var-expr q)]
    [(let-concr? q)
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(bin-concr? q)
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

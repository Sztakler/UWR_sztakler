#lang typed/racket

; Do let-env.rkt dodajemy wartosci boolowskie
;
; Miejsca, ktore sie zmienily oznaczone sa przez !!!

; --------- ;
; Wyrazenia ;
; --------- ;

(define-type Value (U Number Boolean))
(define-predicate value? Value)

(define-type BinopSym (U '+ '- '* '/ '% '= '< '<= '> '>= 'and 'or))

(define-type Expr (U const binop var-expr let-expr if-expr))
(define-predicate expr? Expr)

(struct const    ([val : Value])      #:transparent)
(struct binop    ([op : BinopSym] [l : Expr] [r : Expr])   #:transparent)
(struct var-expr ([id : Symbol])       #:transparent)
(struct let-expr ([id : Symbol] [e1 : Expr] [e2 : Expr]) #:transparent)
(struct if-expr  ([eb : Expr] [et : Expr] [ef : Expr]) #:transparent)

(define-type (LetConcr X) (List 'let (List Symbol X) X))
(define-type (BinConcr X) (List (U '+ '* '- '/) X X))
(define-type (IfConcr X) (List 'if X X X))

(define-type Concr (U
   Number
   Symbol
   (LetConcr Concr)
   (BinConcr Concr)
   (IfConcr Concr)))

(define-predicate let-concr? (LetConcr Any))
(define-predicate bin-concr? (BinConcr Any))
(define-predicate if-concr?  (IfConcr Any))


(: parse (-> Concr Expr))
(define (parse q)
  (cond
    [(number? q) (const q)]
    [(eq? q 'true)  (const true)]  ; <---------------------------- !!!
    [(eq? q 'false) (const false)] ; <---------------------------- !!!
    [(symbol? q) (var-expr q)]
    [(let-concr? q)
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(if-concr? q) ; <--- !!!
     (if-expr (parse (second q))
              (parse (third q))
              (parse (fourth q)))]
    [(bin-concr? q)
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))

(define (test-parse) (parse '(let [x (+ 2 2)] (+ x 1))))
(test-parse)
; ---------- ;
; Srodowiska ;
; ---------- ;

(struct environ ([xs : (U Null (Listof (Pairof Symbol Expr)))]))
(define-type Env environ)

(: env-empty Env)
(define env-empty (environ null))

(: env-add (-> Symbol Expr Env Env))
(define (env-add x v env)
  (environ (cons (cons x v) (environ-xs env))))

(: env-lookup (-> Symbol Env Value))
(define (env-lookup x env)
  (: assoc-lookup (-> (Listof (Pairof Symbol Value)) Value))
  (define (assoc-lookup xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (car (car xs))) (cdr (car xs))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))

; --------- ;
; Ewaluacja ;
; --------- ;

(: arith->value (-> (-> Number Number Number) (-> Value Value Value)))
(define (arith->value arith-op)
  (lambda (a b) (if (and (number? a) (number? b))
                    (arith-op a b)
                    (error "Invalid Type"))))

(: mod->value (-> (-> Integer Integer Integer) (-> Value Value Value)))
(define (mod->value mod-op)
  (lambda (a b) (if (and (exact-integer? a) (exact-integer? b))
                    (mod-op a b)
                    (error "Invalid Type"))))

(: eq->value (-> (-> Number Number Boolean) (-> Value Value Value)))
(define (eq->value eq-op)
  (lambda (a b) (if (and (number? a) (number? b))
                    (eq-op a b)
                    (error "Invalid Type"))))

(: comp->value (-> (-> Real Real Boolean) (-> Value Value Value)))
(define (comp->value comp-op)
  (lambda (a b) (if (and (real? a) (real? b))
                    (comp-op a b)
                    (error "Invalid Type"))))
(: op->proc (-> Symbol (-> Value Value Value)))
(define (op->proc op)
  (match op ['+ (arith->value +)] ['- (arith->value -)] ['* (arith->value *)] ['/ (arith->value /)] ['% (mod->value modulo)] ; <----------- !!!
            ['= (eq->value =)] ['> (comp->value >)] ['>= (comp->value >=)] ['< (comp->value <)] ['<= (comp->value <=)]
            ['and (lambda (x y) (and x y))]
            ['or  (lambda (x y) (or  x y))]))

(define-type Eval (U Value (-> Value Value Value) Expr))

(: eval-env (-> Expr Env Value))
(define (eval-env e env)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval-env l env)
                                   (eval-env r env))]
    [(let-expr x e1 e2)
     (eval-env e2 (env-add x (eval-env e1 env) env))]
    [(var-expr x) (env-lookup x env)]
    [(if-expr eb et ef) (if (eval-env eb env) ; <----------------- !!!
                            (eval-env et env)
                            (eval-env ef env))]))

(: eval (-> Expr Value))
(define (eval e) (eval-env e env-empty))

(define program
  '(if (or (< (% 123 10) 5)
           true)
       (+ 2 3)
       (/ 2 0)))

;(define (test-eval) (eval (parse program)))

(+ 3 3)
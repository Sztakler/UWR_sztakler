#lang typed/racket

(provide parse typecheck)

; --------- ;
; Wyrazenia ;
; --------- ;

(define-type Value (U Number Boolean))
(define-predicate value? Value)

(define-type EType (U 'real 'boolean))

(define-type Expr (U const binop var-expr let-expr if-expr))
(define-predicate expr? Expr)

(struct const    ([val : Value])                         #:transparent)
(struct binop    ([op : Symbol] [l : Expr] [r : Expr])   #:transparent)
(struct var-expr ([id : Symbol])                         #:transparent)
(struct let-expr ([id : Symbol] [e1 : Expr] [e2 : Expr]) #:transparent)
(struct if-expr  ([eb : Expr] [et : Expr] [ef : Expr])   #:transparent)

; ---------- ;
; Parsowanie ;
; ---------- ;

(define-type BinopConcr (List Symbol Concrete Concrete))
(define-predicate binop-concr? BinopConcr)

(define-type LetConcr   (List 'let (List Symbol Concrete) Concrete))
(define-predicate let-concr? LetConcr)

(define-type IfConcr    (List 'if Concrete Concrete Concrete))
(define-predicate if-concr? IfConcr)

(define-type BoolConcr  (U 'true 'false))
(define-predicate bool-concr? BoolConcr)
                              
(define-type Concrete (U Number BoolConcr Symbol LetConcr IfConcr BinopConcr))
(define-predicate concrete? Concrete)

(: parse (-> Concrete Expr))
(define (parse q)
  (cond
    [(number? q) (const q)]
    [(bool-concr? q)  (if (eq? q 'true)
                          (const true)
                          (const false))]  ; <---------------------------- !!!
    [(symbol? q) (var-expr q)]
    [(let-concr? q)
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(if-concr? q)
     (if-expr (parse (second q))
              (parse (third q))
              (parse (fourth q)))]
    [(binop-concr? q)
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))

(define (test-parse) (parse '(let [x (+ 2 2)] (+ x 1))))

; ---------- ;
; Srodowiska ;
; ---------- ;

#|(define-type EnvList (Listof (Pairof Symbol Value)))

(struct environ ([xs : EnvList]))

(define-type Environment environ)
(define-predicate environment? Environment)

(: env-empty Environment)
(define env-empty (environ null))

(: env-add (-> Symbol Value Environment Environment))
(define (env-add x v env)
  (environ (cons (cons x v) (environ-xs env))))

(: env-lookup (-> Symbol Environment Value))
(define (env-lookup x env)
  (: assoc-lookup (-> EnvList Value))
  (define (assoc-lookup xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (car (car xs))) (cdr (car xs))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))

; --------- ;
; Ewaluacja ;
; --------- ;

(: arith-converter (-> (-> Number Number Number) (-> Value Value Value)))
(define (arith-converter arith-op)
  (lambda (a b) (if (and (number? a) (number? b))
                    (arith-op a b)
                    (error "wrong type" a b))))

(: mod-converter (-> (-> Integer Integer Integer) (-> Value Value Value)))
(define (mod-converter mod-op)
  (lambda (a b) (if (and (exact-integer? a) (exact-integer? b))
                    (mod-op a b)
                    (error "wrong type" a b))))

(: eq-converter (-> (-> Number Number Boolean) (-> Value Value Value)))
(define (eq-converter eq-op)
  (lambda (a b) (if (and (real? a) (real? b))
                    (eq-op a b)
                    (error "wrong type" a b))))

(: comparison-converter (-> (-> Real Real Boolean) (-> Value Value Value)))
(define (comparison-converter comparison-op)
  (lambda (a b) (if (and (real? a) (real? b))
                    (comparison-op a b)
                    (error "wrong type" a b))))

(: op->proc (-> Symbol (-> Value Value Value)))
(define (op->proc op)
  (match op ['+ (arith-converter +)] ['- (arith-converter -)] ['* (arith-converter *)]  ; <----------- !!!
            ['/ (arith-converter /)] ['% (mod-converter modulo)] 
            ['= (eq-converter =)] ['> (comparison-converter >)] ['>= (comparison-converter >=)]
            ['< (comparison-converter <)] ['<= (comparison-converter <=)]
            ['and (lambda (x y) (and x y))]
            ['or  (lambda (x y) (or  x y))]))


(: eval-env (-> Expr Environment Value))
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

(define (test-eval) (eval (parse program)))
|#

; ---------------- ;
; Środowisko typów ;
; ---------------- ;

(define-type TypeEnvList (Listof (Pairof Symbol EType)))

(struct environ ([xs : TypeEnvList]))

(define-type TypeEnvironment environ)
(define-predicate type-environment? TypeEnvironment)

(: env-empty TypeEnvironment)
(define env-empty (environ null))

(: env-add (-> Symbol EType TypeEnvironment TypeEnvironment))
(define (env-add x t env)
  (environ (cons (cons x t) (environ-xs env))))

(: env-lookup (-> Symbol TypeEnvironment EType))
(define (env-lookup x env)
  (: assoc-lookup (-> TypeEnvList EType))
  (define (assoc-lookup xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (car (car xs))) (cdr (car xs))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))

; --------------- ;
; Typecheckowanko ;
; --------------- ;

(: op-type (-> Symbol Symbol))
(define (op-type op)
  (match op
    ['+ 'arith] ['- 'arith] ['* 'arith] ['/ 'arith] ['% 'arith] 
    ['= 'comp] ['> 'comp ] ['>= 'comp]
    ['< 'comp] ['<= 'comp]
    ['and 'bool]
    ['or 'bool]))   

(: typecheck-env (-> Expr TypeEnvironment (U EType #f)))
(define (typecheck-env e env)
  (match e
    [(const n) (if (real? n)
                   'real
                   'boolean)]
    [(var-expr x) (env-lookup x env)]
    [(binop op l r) (cond [(eq? (op-type op) 'arith) (if (and (eq? (typecheck-env l env) 'real)
                                                              (eq? (typecheck-env r env) 'real))
                                                         'real
                                                         #f)]
                          [(eq? (op-type op) 'comp) (if (and (eq? (typecheck-env l env) 'real)
                                                             (eq? (typecheck-env r env) 'real))
                                                         'boolean
                                                         #f)]
                          [(eq? (op-type op) 'bool) (if (and (eq? (typecheck-env l env) 'boolean)
                                                             (eq? (typecheck-env r env) 'boolean))
                                                         'boolean
                                                         #f)]
                          [else #f])]
    [(let-expr x e1 e2) (let ([t (typecheck-env e1 env)])
                          (if (eq? t #f)
                              #f
                              (typecheck-env e2 (env-add x t env))))]
    [(if-expr e1 e2 e3) (let ([t-e1 (typecheck-env e1 env)]
                              [t-e2 (typecheck-env e2 env)]
                              [t-e3 (typecheck-env e3 env)])
                          (if (and (eq? t-e1 'boolean) (eq? t-e2 t-e3))
                                t-e2
                                #f))]))
                                  
(: typecheck (-> Expr (U EType #f)))
(define (typecheck expr)
  (typecheck-env expr env-empty))


;Testy

(typecheck (parse '2))                                     ;'real
(typecheck (parse '(+ 4 2)))                               ;'real
(typecheck (parse '(+ true 2)))                            ;#f
(typecheck (parse '(if true (+ 4 2) 5)))                   ;'real
(typecheck (parse '(if true (+ 4 2) false)))               ;#f
(typecheck (parse '(if (> 666 42) (+ 4 2) 5)))             ;'real
(typecheck (parse '(let (x 42) (if (= 42 42) x 10))))      ;'real
(typecheck (parse '(let (x true) (if (= 42 42) x false)))) ;'boolean
(typecheck (parse '(let (x true) (if (= 42 42) x 5))))     ;#f


#lang racket

;(let ([a 5])
;    (let ([b 3])
;        (+ b a))
;    (+ b a))

;((lambda (a) (+ a a)) 3)

(struct const     (val)           #:transparent)
(struct binop     (op l r)        #:transparent)
(struct var-expr  (name)          #:transparent)
(struct let-expr  (id bound body) #:transparent)
(struct if-expr   (eb et ef)      #:transparent)
(struct pair (left right)         #:transparent)
(struct fst  (val)                #:transparent)
(struct snd  (val)                #:transparent)
(struct is-pair (val)             #:transparent)
(struct null-expr ()              #:transparent)
(struct is-null (val)             #:transparent)
(struct lambda-expr (arg body)    #:transparent)  
(struct app-expr (fun arg)        #:transparent)


(define (operator? op)
    (member op '(+ - * / < > = <= >= and or)))

(define (op->proc op)
    (match op 
    ['+ +] ['- -] ['* *] ['/ /] ['< <] ['> >] ['= =] ['<= <=] ['>= >=]
    ['and (lambda (x y) (and x y))]
    ['or  (lambda (x y) (or  x y))]))

(define (expr? e)
    (match e
        [(const n)                  (or (number? n)
                                        (boolean? n))]
        [(binop op l r)             (and (operator? op)
                                         (expr? l)
                                         (expr? r))]
        [(var-expr x)               (symbol? x)]
        [(let-expr x e1 e2)         (and (symbol? x)
                                         (expr? e1)
                                         (expr? e2))]
        [(if-expr eb et ef)         (and (expr? eb)
                                         (expr? et)
                                         (expr? ef))]
        [(pair e1 e2)               (and (expr? e1)
                                         (expr? e2))]
        [(fst e)                    (expr? e)]
        [(snd e)                    (expr? e)]
        [(is-pair e)                (expr? e)]
        [(is-null e)                (expr? e)]
        [(null-expr)                true]
        [(lambda-expr x e)          (and (symbol? x)
                                         (expr? e))]
        [(app-expr ef ea)           (and (expr? ef)
                                         (expr? ea))]
        [_                          false]))

;(expr? (let-expr 'x (const 2) (let-expr 'y (const 3) (binop '+ (var-expr 'x) (var-expr 'y)))))

(define (desugar-lambda xs e)
    (if (null? xs)
        e
        (lambda-expr (car xs) (desugar-lambda (cdr xs) e))))

(define (desugar-app e es)
    (if (null? es)
        e
        (desugar-app (app-expr e (car es)) (cdr es))))

(define (parse q)
    (cond
        [(number? q)         (const q)]
        [(eq? q 'true)       (const true)]
        [(eq? q 'false)      (const false)]
        ((eq? q 'null)       (null-expr))
        [(symbol? q)    (var-expr q)]
        [(and (list? q)
              (= (length q) 2)
              (eq? (first q) 'car))
         (fst (parse (second q)))]
        [(and (list? q)
              (= (length q) 2)
              (eq? (first q) 'cdr))
         (snd (parse (second q)))]
        [(and (list? q)
              (= (length q) 2)
              (eq? (first q) 'pair?))
         (is-pair (parse (second q)))] 
        [(and (list? q)
              (= (length q) 2)
              (eq? (first q) 'null?))
         (is-null (parse (second q)))]
        [(and (list? q)
              (= (length q) 3)
              (operator? (first q)))
         (binop (first q)
                (parse (second q))
                (parse (third q)))]
        [(and (list? q)
              (= (length q) 3)
              (eq? (first q) 'cons))
         (pair (parse (second q))
               (parse (third q)))]
        [(and (list? q)                ;let wyrazenia zapisujemy jako
              (= (length q) 3)         ;(let (x 2) (let (y 3) (+ x y))
              (eq? 'let (first q))
              (list? (second q))
              (= (length (second q)) 2)
              (symbol? (first (second q)))
         (let-expr (first (second q))
                   (parse (second (second q)))
                   (parse (third q))))]
        [(and (list? q)
              (= (length q) 4)
              (eq? (first q) 'if))
         (if-expr  (parse (second q))
                   (parse (third q))
                   (parse (fourth q)))]
        [(and (list? q)
              (= (length q) 3)
              (eq? (first q) 'lambda)
              (list? (second q))
              (andmap symbol? (second q))
              (cons? (second q)))
         (desugar-lambda (second q) (parse (third q)))]
        [(and (list? q)
              (>= (length q) 2))
         (desugar-app (parse (first q)) (map parse (cdr q)))]
        [else (error "Unrecognized token:" q)]))  

;(parse '(lambda (x y) (+ x y)))
;(parse '((lambda (x y) (+ x y)) 1 2))
;(parse '(let (x 2) (let (y 3) (+ x y))))

;(define (eval e)
;    (match e
;        ))

(define (subst e1 x e2)
    (match e2
        [(const n) (const n)]
        [(var-expr y) (if (eq? x y)
                           e1
                           (var-expr y))]
        [(binop op el er)  (binop op 
                                  (subst e1 x el) 
                                  (subst e1 x er))]
        [(let-expr y ebound ebody)
         (let-expr y (subst e1 x ebound)
                     (if (eq? x y)
                          ebody
                          (subst e1 x ebody)))]))

;(subst (const 5) 'x (parse '(let (y 3) (+ x y))))



(define (reify v)
    (const v))

(define (eval-subst e)
    (match e
        [(const n) n]
        [(binop op l r)
         (let ([vl (eval l)]
               [vr (eval r)])
            ((op->proc op) vl vr))]
        [(let-expr x e1 e2)
         (let* ([v1 (eval e1)]
                [e  (subst (reify v1) x e2)])
            (eval e))]
        [(var-expr x) (error "Unbound identifier" x)]))

;(parse '(let (y 3) (+ x y)))
;(subst (const 5) 'x (parse '(let (y 3) (+ x y))))
;(eval (subst (const 5) 'x (parse '(let (y 3) (+ x y)))))
;(eval (parse 'x))

(struct environ (xs))

(define env-empty (environ null))
(define (env-add x v env)
    (environ (cons (cons x v) (environ-xs env))))
(define (env-lookup x env)
    (define (assoc-lookup xs)
        (cond [(null? xs) (error "Unknown identifier" x)]
              [(eq? x (car (car xs))) (cdr (car xs))]
              [else (assoc-lookup (cdr xs))]))
    (assoc-lookup (environ-xs env)))

(define (eval-env-lazy e env)
    (match e
        [(const n) n]
        [(binop op l r) ((op->proc op) 
                         (eval-env l env)
                         (eval-env r env))]
        [(var-expr x) 
         (env-lookup x env)]
        ;LENIWIE
        ;[(var-expr x) 
        ; (eval-env (env-lookup x env) env)]
        [(let-expr x e1 e2) 
         (let ([v1 (eval-env e1 env)])
               (eval-env e2 (env-add x v1 env)))]
        ;LENIWIE
         ;[(let-expr x e1 e2)  
         ; (eval-env e2 (env-add x e1 env))]
               ))

;; Domknięcia
(struct clo (arg body env))

(define (value? v)
   (or (number?       v)
       (null?         v)
       (boolean?      v)
       (and (cons?    v)
            (value?   (car v))
            (value?   (cdr v)))
       (and (clo? v)
            (symbol?  (clo-arg v))
            (expr?    (clo-body v))
            (environ? (clo-env v)))))

(define (eval-env e env)
    (match e
        [(const n) n]
        [(binop op l r) ((op->proc op) 
                         (eval-env l env)
                         (eval-env r env))]
        [(var-expr x) 
         (env-lookup x env)]
        [(let-expr x e1 e2) 
         (let ([v1 (eval-env e1 env)])
               (eval-env e2 (env-add x v1 env)))]
        [(if-expr eb et ef)
            (match (eval-env eb env)
                [#t (eval-env et env)]
                [#f (eval-env ef env)]
                [v   (error "Not a boolean:" v)])]
        [(null-expr) null]
        [(is-null e) 
            (null? (eval-env e env))]
        [(pair el er) 
            (cons (eval-env el env) 
                  (eval-env er env))]
        [(is-pair e)
            (cons? (eval-env e env))]
        [(fst e) 
            (car (eval-env e env))]
        [(snd e) 
            (cdr (eval-env e env))]
        [(lambda-expr x e)
         (clo x e env)]
        [(app-expr ef ea)
         (let ([vf (eval-env ef env)]
               [va (eval-env ea env)])
            (match vf
                [(clo x e env) 
                 (eval-env e (env-add x va env))]
                [_ (error "Not a function:" vf)]))]))

(define (eval e)
    (eval-env e env-empty))

(eval (parse '(lambda (x y) (+ x y))))
(eval (parse '(let (add (lambda (x y) (+ x y))) (add 1 2))))

;(eval-subst (parse '(let (x 2) (let (x 4) (+ x x)))))
;(eval (parse '(let (x (/ 1 2)) (let (x 4) (+ x x)))))

;(eval (parse '(if (> 3 2) false 17)))
;(eval (parse '(if (or (< 3 2) (> (/ 1 0) 0)) false 17))) ;dzielenie przez zero (gorliwy or i and)

(require racket/set)

(define fenv-empty (set))
(define (fenv-add x env) (set-add env x))
(define (fenv-lookup x env) (set-member? env x))

(define (free-vars e)
    (define (free-vars-env e env)
        (match e
            [(const n) (set)]
            [(binop _ l r) (set-union (free-vars-env l env)
                                      (free-vars-env r env))]
            [(var-expr x) (if (fenv-lookup x env)
                              (set)
                              (list->set (list x)))]
            [(let-expr x e1 e2)
             (set-union (free-vars-env e1 env)
                        (free-vars-env e2 (fenv-add x env)))]))
    (set->list (free-vars-env e fenv-empty)))

;(free-vars (parse '(+ x y)))
;(free-vars (parse '(let (x 2) (+ x y))))
;(free-vars (parse '(let (x z) (+ x y))))
;(eval (parse '(let (x 2) (+ (let (x 3) (+ x x)) x))))
;(free-vars (parse '(let (x 2) (+ (let (x 3) (+ x x)) x))))
;(value? (cons 1 2))
;(value? (list 1 2 3))
;(value? (parse '(car (cdr (cons 1 (cons 2 (cons 3 null)))))))
;(eval (parse '(null? null)))
;(eval (parse '(pair? null)))
;(eval (parse '(null? 1)))
;(eval (parse '(null? true)))
;(eval (parse '(car (cdr (cons 1 (cons 2 (cons 3 null)))))))
;(parse '(lambda (x y) (+ x y)))
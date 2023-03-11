#lang racket
;let-subst.rkt


; --------- ;
; Wyrazenia ;
; --------- ;

;zadanie 1

(struct const    (val)      #:transparent)
(struct binop    (op l r)   #:transparent)
(struct pow      (a b)     #:transparent)
(struct var-expr (id)       #:transparent)
(struct let-expr (id e1 e2) #:transparent)
(struct index_sum (i n m fi) #:transparent)
(struct integral (x a b fx) #:transparent)
(struct indexed_min (i fi) #:transparent)

(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(pow a b) (and (expr? a) (expr? b))]
    [(var-expr x) (symbol? x)]
    [(let-expr x e1 e2) (and (symbol? x) (expr? e1) (expr? e2))]
    [(index_sum i n m fi) (and (symbol? i) (expr? n) (expr? m) (expr? fi))]    
    [(integral x a b fx) (and (symbol? x) (expr? a) (expr? b) (expr? fx))]
    [(indexed_min i fi) (and (symbol? i) (expr? fi))]
    [_ false]));

;zadanie 2
;(define (parse q)
;  (cond
;    [(number? q) (const q)]
;    [(symbol? q) (var-expr q)]
;    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'let))
;     (let-expr (first (second q))
;               (parse (second (second q)))
;               (parse (third q)))]
;    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'index-sum))
;     (index-sum
;                (first (second q))
;                (parse (second (second q)))
;                (parse (third (second q)))
;                (parse (third q)))]
;    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'integral))
;     (integral
;                (first (second q))
;                (parse (second (second q)))
;                (parse (third (second q)))
;                (parse (third q)))]
;    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'index-min))
;     (index-min (first (second q))
;                (parse (third q)))]
;    ;poniższe parsuje też potęgowanie
;    [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
;     (binop (first q)
;            (parse (second q))
;            (parse (third q)))]))

; (parse '(let (x 2) (let (y 3) (+ x y))))

; (parse '(index-sum (i     (+ 1 1)    10)  (** i 2))

; (parse '(integral (x 3 4) (** x 3)))

; (parse '(index-min (i) i))

;zadanie 3

;składnia abstrakcyjna
(struct var-expr (id)     #:transparent)
(struct neg (subf)        #:transparent)
(struct conj (left right) #:transparent)
(struct disj (left right) #:transparent)
(struct exist (id subf)    #:transparent)
(struct forall (if subf)  #:transparent)

(define (formula? f)
  (match f
    [(var-expr id) (symbol? id)]
    [(neg subf) (formula? subf)]
    [(conj left right) (and (formula? left) (formula? right))]
    [(disj left right) (and (formula? left) (formula? right))]
    [(exist id subf) (and (symbol? id) (formula? right))]
    [(forall id subf) (and (symbol? id) (formula? right))]
    [_ (error "not a qbf")]
    ))

;(parse '(exist x (neg x)))
;(parse '(forall x (disj x (neg x))))
;(parse '(exist x (conj x (neg x))))


;składnia konkretna

(define (parse q)
  (cond
    [(symbol? q) (var-expr q)]
    [(and (list? q) (eq? (length q) 2) (eq? (first q) 'neg))
     (neg
      (parse (second q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'conj))
     (conj
      (parse (second q))
      (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'disj))
     (disj
      (parse (second q))
      (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'exist))
     (exist (second q) (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'forall))
     (forall (second q) (parse (third q)))]))

;zadanie 4

;plik let-env.rkt
; ---------- ;
; Srodowiska ;
; ---------- ;

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

; --------- ;
; Ewaluacja ;
; --------- ;

(define (eval-env e env)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval-env l env)
                                   (eval-env r env))]
    [(let-expr x e1 e2)
     (eval-env e2 (env-add x (eval-env e1 env) env))]
    [(var-expr x) (env-lookup x env)]))

(define (eval-qbf-env qbf env)
  (match qbf
    [(var-expr id) (env-lookup id env)]
    [(neg subf) (not (eval-qbf-env subf env))]
    [(conj left right) (and
                        (eval-qbf-env left)
                        (eval-qbf-env right))]
    [(disj left right) (or
                        (eval-qbf-env left)
                        (eval-qbf-env right))]
    [(exist id subf)
     (or
      (eval-qbf-env subf (env-add id #t env))
      (eval-qbf-env subf (env-add id #f env)))]
    [(forall id subf)
     (and
      (eval-qbf-env subf (env-add id #t env))
      (eval-qbf-env subf (env-add id #f env)))]
    [_ (error "not a qbf")]
    ))

(eval-qbf-env (parse '(forall x (disj x (neg x)))) env-empty)
;#t
;>(eval-qbf-env (parse '(exist x (conj x (neg x)))) env-empty)
;#f

;zadanie 5

;Wracamy do let-subst.rkt

(define (ith-symbol i)
  (string->symbol (string-append "x" (number->string i))))

(define (env-size env)
  (length (environ-xs env)))

(define (rename-env e env)
  (match e
    [(const n) e] ; e = (const n)
    [(binop op l r) (binop op
                           (rename-env l env)
                           (rename-env r env))]
    [(var-expr x) (var-expr (env-lookup x env))]
    [(let-expr x e1 e2)
     (let
         ([new-x (ith-symbol (env-size env))])
       (let-expr new-x
                 (rename-env e1 env)
                 (rename-env e2 (env-add x new-x env))))]
    [_ (error "not an expr")]))

(define (rename e)
  (rename-env e env-empty))

;zadanie 6

(rename (parse '(let (x 2) (+ (let (x 3) x) (let (x 4) x)))) ) ≡
≡ (parse '(let (x0 2) (+ (let (x1 3) x1) (let (x1 4) x1))))

(rename2 (parse '(let (x 2) (+ (let (x 3) x) (let (x 4) x)))) ) ≡
≡ (parse '(let (x0 2) (+ (let (x1 3) x1) (let (x2 4) x2))))


(define (rename2-env e env i)
  (match e
    [(const n)   (cons e i)]
    …))

(define (rename2 e)
    (car (rename2-env e env-empty 0)))


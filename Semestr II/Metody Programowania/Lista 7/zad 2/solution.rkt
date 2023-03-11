#lang racket

(provide (struct-out const) (struct-out binop) (struct-out var-expr) (struct-out let-expr) (struct-out var-dead) find-dead-vars)

; --------- ;
; Wyrazenia ;
; --------- ;



(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x) (symbol? x)]
    [(var-dead x) (symbol? x)]
    [(let-expr x e1 e2) (and (symbol? x) (expr? e1) (expr? e2))]
    [_ false]))

(define (parse q)
  (cond
    [(number? q) (const q)]
    [(symbol? q) (var-expr q)]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'let))
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))




; ---------------------------------- ;
; Wyszukaj ostatnie uzycie zmiennych ;
; ---------------------------------- ;

(struct const    (val)      #:transparent)
(struct binop    (op l r)   #:transparent)
(struct var-expr (id)       #:transparent)
(struct var-dead (id)       #:transparent)
(struct let-expr (id e1 e2) #:transparent)




;ŚRODOWISKO
(define empty-env-names (set))
(define (env-add name env)
  (set-add env name))
(define (env-lookup x env)
  (set-member? env x))

;WOLNE ZMIENNE
(define (free-vars-env e env)
  (match e
    [(const n) (set)]
    [(binop op l r)
     (set-union (free-vars-env l env)
                (free-vars-env r env))]
    [(let-expr x e1 e2)
     (set-union (free-vars-env e1 env)
                (free-vars-env e2 (env-add x env)))]
    [(var-expr x)
     (if (env-lookup x env)
         (set) (list->set (list x)))]))


(define (free-variables expr)
  (free-vars-env expr empty-env-names))

;ZABIJANKO

(define (find-dead-vars expr)
  (define (var-killer expr env)
    (match expr
      [(const e) expr]
      [(binop op l r)
       (let ([env-update (set-union (free-variables r) env)])
         (binop op
                (var-killer l env-update)
                (var-killer r env)))]
      [(var-expr var) (if (env-lookup var env)
                          expr
                          (var-dead var))]
      [(let-expr var subst body)
       (let ([env-update (set-union (set-remove (free-variables subst) var) env)])
         (let-expr var
                   (var-killer subst env-update)
                   (var-killer body  (set-remove env var))))]))
  (var-killer expr empty-env-names))
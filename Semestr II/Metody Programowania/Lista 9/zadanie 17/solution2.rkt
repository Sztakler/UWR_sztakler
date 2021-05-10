#lang racket

;Zadanie wykonane wspólnie z Cezarym Świtałą i Bartoszem Janikowskim

(provide eval-while parse-while env-empty env-lookup)

; Do programming.rkt dodajemy instrukcje

; --------- ;
; Wyrazenia ;
; --------- ;

(struct const       (val)      #:transparent)
(struct binop       (op l r)   #:transparent)
(struct var-expr    (id)       #:transparent)
(struct let-expr    (id e1 e2) #:transparent)
(struct letrec-expr (id e1 e2) #:transparent)
(struct if-expr     (eb et ef) #:transparent)
(struct cons-expr   (e1 e2)    #:transparent)
(struct car-expr    (e)        #:transparent)
(struct cdr-expr    (e)        #:transparent)
(struct null-expr   ()         #:transparent)
(struct null?-expr  (e)        #:transparent)
(struct app         (f e)      #:transparent)
(struct lam         (id e)     #:transparent)

(define (expr? e)
  (match e
    [(const n) (or (number? n) (boolean? n) (string? n))]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x) (symbol? x)]
    [(let-expr x e1 e2)
     (and (symbol? x) (expr? e1) (expr? e2))]
    [(letrec-expr x e1 e2)
     (and (symbol? x) (expr? e1) (expr? e2))]
    [(if-expr eb et ef)
     (and (expr? eb) (expr? et) (expr? ef))]
    [(cons-expr e1 e2) (and (expr? e1) (expr? e2))]
    [(car-expr e) (expr? e)]
    [(cdr-expr e) (expr? e)]
    [(null-expr) true]
    [(null?-expr e) (expr? e)]
    [(app f e) (and (expr? f) (expr? e))]
    [(lam id e) (and (symbol? id) (expr? e))]
    [_ false]))

(define (parse q)
  (cond
    [(number? q) (const q)]
    [(eq? q 'true)  (const true)]
    [(eq? q 'false) (const false)]
    [(eq? q 'null)  (null-expr)]
    [(string? q) (const q)]
    [(symbol? q) (var-expr q)]
    [(and (list? q) (eq? (length q) 2) (eq? (first q) 'null?))
     (null?-expr (parse (second q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'cons))
     (cons-expr (parse (second q))
                (parse (third q)))]
    [(and (list? q) (eq? (length q) 2) (eq? (first q) 'car))
     (car-expr (parse (second q)))]
    [(and (list? q) (eq? (length q) 2) (eq? (first q) 'cdr))
     (cdr-expr (parse (second q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'let))
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'letrec))
     (letrec-expr (first (second q))
                  (parse (second (second q)))
                  (parse (third q)))]
    [(and (list? q) (eq? (length q) 4) (eq? (first q) 'if))
     (if-expr (parse (second q))
              (parse (third q))
              (parse (fourth q)))]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'lambda))
     (parse-lam (second q) (third q))]
    [(and (list? q) (pair? q) (not (op->proc (car q))))
     (parse-app q)]
    [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))

(define (parse-app q)
  (define (parse-app-accum q acc)
    (cond [(= 1 (length q)) (app acc (parse (car q)))]
          [else (parse-app-accum (cdr q) (app acc (parse (car q))))]))
  (parse-app-accum (cdr q) (parse (car q))))

(define (parse-lam pat e)
  (cond [(= 1 (length pat))
         (lam (car pat) (parse e))]
        [else
         (lam (car pat) (parse-lam (cdr pat) e))]))

; ---------- ;
; Srodowiska ;
; ---------- ;

(struct blackhole () #:transparent)
(struct environ (xs) #:transparent)

(define env-empty (environ null))
(define (env-add x v env)
  (environ (cons (mcons x v) (environ-xs env))))
(define (env-lookup x env)
  (define (assoc-lookup xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (mcar (car xs)))
             (match (mcdr (car xs))
               [(blackhole) (error "Stuck forever in a black hole!")]
               [x x])]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))

(define (env-member? x env) ;sprawdzamy, czy srodowisko zawiera zmienna
    (define (assoc-lookup xs)
        (cond [(null? xs) false]
              [(eq? x (mcar (car xs))) true]
              [else (assoc-lookup (cdr xs))]))
    (assoc-lookup (environ-xs env)))

(define (env-update! x v xs)
  (define (assoc-update! xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (mcar (car xs))) (set-mcdr! (car xs) v)]
          [else (env-update! x v (cdr xs))]))
  (assoc-update! (environ-xs xs)))

(define (env-update-while x v xs) ; <---------------------------------- !!! 
  (define (assoc-update xs)
    (cond [(null? xs) (list (mcons x v))]
          [(eq? x (mcar (car xs))) (begin
                                        (set-mcdr! (car xs) v)
                                        xs)]
          [else (cons (car xs) (assoc-update (cdr xs)))]))
    (environ (assoc-update (environ-xs xs))))

 (define (env-update x v xs) ; <---------------------------------- !!!
  (define (assoc-update xs)
    (cond [(null? xs) (list (mcons x v))]
          [(eq? x (mcar (car xs))) (cons (mcons x v) (cdr xs))]
          [else (cons (car xs) (assoc-update (cdr xs)))]))
  (environ (assoc-update (environ-xs xs)))) 
   
;(define (env-update x v xs) ; <---------------------------------- !!!
;     (define (assoc-update xs)
;       (cond [(null? xs) (list (mcons x v))]
;             [(eq? x (mcar (car xs))) (cons (mcons x v) (cdr xs))]
;             [else (cons (car xs) (assoc-update (cdr xs)))]))
;     (environ (assoc-update (environ-xs xs))))


; --------- ;
; Ewaluacja ;
; --------- ;

(struct clo (id e env) #:transparent)

(define (value? v)
  (or (number? v)
      (boolean? v)
      (string? v)
      (and (pair? v) (value? (car v)) (value? (cdr v)))
      (null? v)
      (clo? v)
      (blackhole? v)))

(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /] ['% modulo]
            ['= =] ['> >] ['>= >=] ['< <] ['<= <=]
            ['and (lambda (x y) (and x y))]
            ['or  (lambda (x y) (or  x y))]
            ['eq? eq?]
            [_ false]))

(define (eval-env e env env-while)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval-env l env env-while)
                                   (eval-env r env env-while))]
    [(let-expr x e1 e2)
     (eval-env e2 (env-add x (eval-env e1 env env-while) env) env-while)]
    [(letrec-expr x e1 e2)
     (let* ([new-env (env-add x (blackhole) env)]
            [v (eval-env e1 new-env env-while)])
       (begin
          (env-update! x v new-env)
          (eval-env e2 new-env env-while)))]

    [(var-expr x) (if (env-member? x env) ;modyfikacja
                      (env-lookup x env)
                      (env-lookup x env-while))]

    [(if-expr eb et ef) (if (eval-env eb env env-while)
                            (eval-env et env env-while)
                            (eval-env ef env env-while))]
    [(cons-expr e1 e2) (cons (eval-env e1 env env-while)
                             (eval-env e2 env env-while))]
    [(car-expr e) (car (eval-env e env env-while))]
    [(cdr-expr e) (cdr (eval-env e env env-while))]
    [(null-expr) null]
    [(null?-expr e) (null? (eval-env e env env-while))]
    [(lam x e) (clo x e env)]
    [(app f e)
     (let ([vf (eval-env f env env-while)]
           [ve (eval-env e env env-while)])
       (match vf [(clo x body fun-env)
                  (eval-env body (env-add x ve fun-env) env-while)]))]))

(define (eval e) (eval-env e env-empty env-empty))

; ---------------------------------------------------------------- !!!

(struct skip   ()         #:transparent)
(struct assign (x e)      #:transparent)
(struct if-cmd (eb ct cf) #:transparent)
(struct while  (eb cb)    #:transparent)
(struct comp   (c1 c2)    #:transparent)

(define (cmd? c)
  (match c
    [(skip) true]
    [(assign x e) (and (symbol? x) (expr? e))]
    [(if-cmd eb ct cf) (and (expr? eb) (cmd? ct) (cmd? cf))]
    [(while eb ct) (and (expr? eb) (cmd? ct))]
    [else false]))

(define (parse-while q)
  (cond
    [(eq? q 'skip) (skip)]
    [(null? q) (skip)]
    [(and (list? q) (= (length q) 3) (eq? (second q) ':=))
     (assign (first q)
             (parse (third q)))]
    [(and (list? q) (= (length q) 4) (eq? (car q) 'if))
     (if-cmd (parse (second q))
             (parse-while (third q))
             (parse-while (fourth q)))]
     [(and (list? q) (= (length q) 3) (eq? (car q) 'while))
      (while (parse (second q))
             (parse-while (third q)))]
     [(and (list? q) (= (length q) 2))
      (comp (parse-while (first q))
            (parse-while (second q)))]
     [(and (list? q) (> (length q) 2))
      (comp (parse-while (first q))
            (parse-while (cdr q)))]
     [else (error "while parse error")]))

(define (eval-while e env-while)
  (match e
    [(skip) env-while]
    [(assign x e)
     (env-update-while x (eval-env e env-empty env-while) env-while)]
    [(if-cmd eb ct cf)
     (if (eval-env eb env-empty env-while)
         (eval-while ct env-while)
         (eval-while cf env-while))]
    [(while eb cb)
     (if (eval-env eb env-empty env-while)
         (eval-while e (eval-while cb env-while))
         env-while)]
     [(comp c1 c2) (eval-while c2 (eval-while c1 env-while))]))

; zakladamy, ze program startuje z pamiecia w ktorej
; aktwna jest zmienna t
(define WHILE_FACT
  '{(i := 1)
    (while (> t 0)
      {(i := (* i t))
       (t := (- t 1))})})

(define (fact n)
  (let* ([init-env  (env-add 't n env-empty)]
         [final-env
           (eval-while (parse-while WHILE_FACT) init-env)])
    (env-lookup 'i final-env)))
    

(define WHILE_1
  '{(x := 5)
(f := (lambda (y) (+ x y)))(x := 10)(z := (f 0))})

(define WHILE_2
  '{(x := 5)(f := (let [x 50] (lambda (y) (+ x y))))(x := 10)(z := (f 0))})

(define WHILE_3
  '{(x := 5)(f := (let [x 50](let [foo (lambda (y) (+ x y))](let [x 100]foo))))(x := 10)(z := (f 0))})

(define WHILE_4
  '{(x := 5)(f := (let [x x] (lambda (y) (+ x y))))(x := 10)(z := (f 0))})



(define (test1)
  (let* ([init-env  env-empty]
         [final-env
           (eval-while (parse-while WHILE_1) init-env)])
    (env-lookup 'z final-env)))

(define (test2)
  (let* ([init-env  env-empty]
         [final-env
           (eval-while (parse-while WHILE_2) init-env)])
    (env-lookup 'z final-env)))

(define (test3)
  (let* ([init-env  env-empty]
         [final-env
           (eval-while (parse-while WHILE_3) init-env)])
    (env-lookup 'z final-env)))

(define (test4)
  (let* ([init-env  env-empty]
         [final-env
           (eval-while (parse-while WHILE_4) init-env)])
    (env-lookup 'z final-env)))

(test1)
(test2)
(test3)
(test4)

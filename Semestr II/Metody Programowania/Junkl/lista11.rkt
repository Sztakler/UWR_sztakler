#lang racket

;(require rackunit)
(require racket/contract )

;ZADANIE 1

(define/contract (suffixes xs)
    (parametric->/c [a] ((listof a) . -> . (listof (listof a))))
    (if (null? xs)
        (list xs)
        (cons xs (suffixes (cdr xs)))))

;(suffixes '( 1 2 3 4))


;ZADANIE 2

(define/contract (sublists xs)
  (parametric->/c [a] ((listof a) . -> . (listof (listof a))))
  (if   (null? xs)
        (list xs)
        (append-map
            (lambda (ys) (list (cons (car xs) ys) ys))
            (sublists (cdr xs)))))

;(sublists '(1 2))
;(sublists '(1 2 3))

; : - spełnia kontrakt (jest typu)
; xs : (listof a)
; (list xs) : (listof (listof a)), zatem podstawa rekursji jest w porządku
; (cdr xs) : (listof a)
; (sublists (cdr xs)) : (listof (listof a)) <- założenie indukcyjne
; append-map : (parametric->/c [a b] (-> (-> a (listof b)) (listof a) (listof b)))
; (λ(ys) ...) : ((listof (listof a)) . -> . (listof b))
;
;;ZADANIE 3
;
;;a)
;
;(parametric->/c [a b] (-> a b a))
;                          - - +
;
;(define (ignore x y)       ;  także const, K
;    x)
;
;;b)
;(parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
;                                + + -      + -  - +
;
;                       (( a b . -> . c) (a . ->. b) a . -> .c)
;                            + +        -  +       -
;                          |------(-)----| |---(-)---| -        +
;                         |--------------------------------(+)--|
;
;(define (proc2 f g arg)      ; S
;    (f arg (g arg)))
;
;
;
;;c) ;prostsze (-> i j k)        ; (-> i (-> j k))
;                 - - +               -     - +
;
;(parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
;                             + -     + -      - +
;                             2 1     2 1      1 0 ; liczba obrotów
;
;(define zlozenie (g f)         ; B
;  (lambda (x) (g (f x))))
;
;;d)
;(parametric- >/c [a] (-> (-> (-> a a) a) a))
;                                 - +  -  +
;
;(struct var x)
;(struct arrow a r)
;(define (map-polarity contract polarity)
;(define (opposite p)
;  (match p
;    ['+ '-]
;    ['- '+]))
;  (match contract
;    [(var x) (var polarity)]
;    [(arrow a r)  (arrow (map-polarity a (opposite polarity))
;                         (map-polarity r polarity))]))
;
;(parametric- >/c [a] (-> (-> (-> a a) a) a))
;
;(define (proc4 f)
;    (f (lambda (x) x)))
;
;proc4 : (-> (-> (-> a a) a) a)
;f : (-> (-> a a) a)
;(lambda (x) x) : (-> a a)

;ĆWICZENIE 4 (nie da się zrobić uczciwie)

;zwracanie błędu 

(define/contract (proc5 x) 
    (parametric->/c [a b] (-> a b))
    (error "chytre obejście kontraktu"))

;albo zapętlenie się

(define/contract (proc6 x) 
    (parametric->/c [a b] (-> a b))
    (proc6 x))

;(proc6 2)

;; ZADANIE 5

;Pierwszy argument powinien być procedurą przyjmującą dwa argumenty, oznaczające (w kolejności)
;bieżący element listy [e] oraz bieżący akumulator [a], zaś zwracającą parę złożoną z nowego
;elementu listy [ve] oraz nowej wartości akumulatora.
;Pozostałe dwa argumenty powinny zawierać startową wartość akumulatora
;oraz listę ̨ elementów do przetworzenia. Procedura foldl-map zwraca parę złożoną
;z listy wynikowej i końcowej wartości akumulatora.
;Napisz kontrakt parametryczny dla tej definicji. Zastosuj w kontrakcie jak


(define/contract (foldl-map f a xs)
    (parametric->/c [e a ve] (-> (-> e a (cons/c ve a)) ; e - element, a - akumulator
                                 a 
                                 (listof e)
                                 (cons/c (listof ve) a))) 
    (define (it a xs ys)
        (if (null? xs)
            (cons (reverse  ys) 'a)
            (let [(p (f (car xs) a))]
                (it (cdr p) 
                    (cdr xs) 
                    (cons (car p) ys)))))
    (it a xs null))


(foldl-map (lambda (x a) (begin (println (cons a (+ a x))) (cons a (+ a x)))) 0 '(1 2 3))
;'((0 1 3) . 6)

;(foldl-map (lambda (x a) (cons (number->string a) (+ a x))) 0 '(1 2 3))
;'(("0" "1" "3") . 6)


;; ĆWICZENIE 6

(struct const    (val)      #:transparent)
(struct binop    (op l r)   #:transparent)
(struct var-expr (id)       #:transparent)
(struct let-expr (id e1 e2) #:transparent)

(define expr/c
  (flat-rec-contract expr
       (struct/c const number?)
       (struct/c binop symbol? expr expr)
       (struct/c var-expr symbol?)
       (struct/c let-expr symbol? expr expr)))

(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x) (symbol? x)]
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

(define (test-parse) (parse '(let [x (+ 2 2)] (+ x 1))))

; ----------------------- ;
; Podstawienie za zmienna ;
; ----------------------- ;

(define/contract (subst e1 x e2)
    (expr/c symbol? expr/c . -> . expr/c)
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

(define (value? v)
  (number? v))

(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /]))



(define/contract (eval e)
    (expr/c . -> . number?)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval l) (eval r))]
    [(let-expr x e1 e2)
     (eval (subst (const (eval e1)) x e2))]))

(define (test-eval) (eval (test-subst)))

;(test-eval)
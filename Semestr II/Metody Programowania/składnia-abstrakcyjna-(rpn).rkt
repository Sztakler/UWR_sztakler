#lang racket

(struct const (val)     #:transparent)
(struct binop (op l r)  #:transparent)


(define (operator? op)
    (member op '(+ * - /)))

(define  (expr? e)
    (match e
        [(const v) (number? v)]
        [(binop op l r) (and (operator? op)
                             (expr? l)
                             (expr? r))]
        [_ false]
        ))

;(expr? (binop '+ (const 2) (binop '* (const 3) (const 4))))


(define (op->proc op)
    (match op
        ['+ +] ['- -] ['* *] ['/ /]))

(define (value? v)
    (number? v))

(define (eval e)
    (match e
        [(const e)      e]
        [(binop op l r) 
         (let ([vl (eval l)]
               [vr (eval r)]
               [proc (op->proc op)])
            (proc vl vr))]))


;(value? (eval (binop '+ (const 2) (binop '* (const 3) (const 4)))))

(define (rpn-expr? e)
    (and (list? e) ;lista
         (pair? e) ;niepusta
         (andmap (lambda (x) (or (number? x) (operator? x))) e))) ;symboli i operatorów

;(rpn-expr? '(2 +))


(struct stack (xs))

(define empty-stack      (stack null))
(define (empty-stack? s) (null? (stack-xs s)))
(define (top s)          (car (stack-xs s)))
(define (push a s)         (stack (cons a (stack-xs s))))
(define (pop s)          (stack (cdr (stack-xs s))))


(define (rpn-eval e)
    (define (rpn-eval-aux e stack)
        (cond
            [(null?     e)              (top stack)]
            [(number?   (car e))    (rpn-eval-aux (cdr e) (push (car e) stack))]
            [(operator? (car e)) 
                (let* ([vr      (top stack)]
                       [stack   (pop stack)]
                       [vl      (top stack)]
                       [stack   (pop stack)]
                       [v       ((op->proc (car e)) vl vr)])
                    (rpn-eval-aux (cdr e) (push v stack)))]))
    (rpn-eval-aux e empty-stack))

;(rpn-eval '(2 3 4 * +))
;(rpn-eval '(+))


(define (arith->rpn e)
    (match e
        [(const v)          (list v)]
        [(binop op l r)
            (let* ( [vr (arith->rpn r)]
                    [vl (arith->rpn l)])
                (append vl vr (list op)))]))

;(arith->rpn (binop '+ (const 2) (binop '* (const 3) (const 4))))

;(rpn-eval (arith->rpn (binop '+ (const 2) (binop '* (const 3) (const 4)))))


(define (parse p)
    (cond
        [(number? p) (const p)]
        [(and   (list? p)
                (= (length p) 3)
                (operator? (car p)))
         (binop (first p) 
                (parse (second p))
                (parse (third p)))]))

(eval (parse '(+ 2 (* 3 4))))
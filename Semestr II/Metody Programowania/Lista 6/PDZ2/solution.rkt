#lang racket

-

(provide (struct-out const) (struct-out binop) rpn->arith)

;; -------------------------------
;; Wyrazenia w odwr. not. polskiej
;; -------------------------------

(define (rpn-expr? e)
  (and (list? e)
       (pair? e)
       (andmap (lambda (x) (or (number? x) (member x '(+ - * /))))
               e)))

;; ----------------------
;; Wyrazenia arytmetyczne
;; ----------------------

(struct const (val)    #:transparent)
(struct binop (op l r) #:transparent)

(define (arith-expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r)
     (and (symbol? op) (arith-expr? l) (arith-expr? r))]
    [_ false]))

;; ----------
;; Kompilacja
;; ----------


(define (push stack elem)
  (cons elem stack))
(define (delete-top stack)
  (cdr stack))
(define (get-top stack)
  (car stack))
(define (symbol->operator op)
  (match op
    ['+ +]
    ['- -]
    ['* *]
    ['/ /]))

(define (rpn->arith rpn)
  (define (rpn->arith-iter tail stack)
    (cond
      [(empty? tail) (get-top stack)]
      [(number? (car tail))
                (rpn->arith-iter (cdr tail) (push stack (const (car tail))))]
      [(member (car tail) '(+ - * /))
       (let* (
             [second-arg (get-top stack)]
             [stack (delete-top stack)]
             [first-arg (get-top stack)]
             [stack (delete-top stack)])
         
       (rpn->arith-iter (cdr tail)
                        (push stack (binop (car tail) first-arg second-arg))))]
      [else "InvalidInput"]))
  (rpn->arith-iter rpn null))

; Mozesz tez dodac jakies procedury pomocnicze i testy

(rpn->arith '(1 2 -))
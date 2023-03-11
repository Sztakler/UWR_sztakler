#lang racket

(define (var? t)
  (symbol? t))

(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq?'neg (car t))))

(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq?'disj (car t))))

(define (prop? f)
  (or (var? f)
      (and (neg? f)
           (prop? (neg-subf f)))
      (and (disj? f)
           (prop? (disj-left f))
           (prop? (disj-rght f)))
      (and (conj? f)
           (prop? (conj-left f))
           (prop? (conj-rght f)))))


;zad 1
(define (neg f)
  (list 'neg f))

(define (conj f1 f2)
  (list 'conj f1 f2))

(define (disj f1 f2)
  (list 'disj f1 f2))

(define (neg-subf f)
  (cadr f))

(define (disj-left f)
  (cadr f))

(define (disj-rght f)
  (caddr f))

(define (conj-left f)
  (cadr f))

(define (conj-rght f)
  (caddr f))

;zad 2



;zad 3

(define (free-vars f)
  (define (free-vars-aux f)
    (cond
      [(var? f) (list f)]
      [(neg? f) (free-vars-aux (neg-subf f))]
      [(conj? f) (append (free-vars-aux (conj-left f)) (free-vars (conj-rght f)))]
      [(disj? f) (append (free-vars-aux (disj-left f)) (free-vars (disj-rght f)))]))

  (remove-duplicates (free-vars-aux f)))

(define f (conj 'c (disj (neg 'a) 'b)))

(free-vars f)

;zad 4

(define (gen-vals  xs)
  (if (null? xs)
     (list  null)
     (let* (
            (vss   (gen-vals (cdr xs)))
            (x     (car xs))
            (vst   (map (lambda(vs) (cons (list x true)   vs)) vss))
            (vsf   (map (lambda(vs) (cons (list x false) vs)) vss))
            )
       (append  vst  vsf))))

(define (search-value variable lst)
   (if (eq? (car (car lst)) variable)
        (cadr (car lst))
        (search-value variable (cdr lst))))

(define (eval-formula values f)
  (cond
    [(var? f) (search-value f values)]
    [(neg? f)
     (if (eval-formula values (neg-subf f)) #f #t)]
    [(conj? f) (and
                (eval-formula values (conj-rght f))
                (eval-formula values (conj-left f)))]
    [(disj? f) (or
                (eval-formula values (disj-rght f))
                (eval-formula values (disj-left f)))]))

;zad 5

(define (lit? t)
  (or (var? t)
      (and (neg? t) (var? (neg-subf t)))))

(define (nnf? f)
  (cond [(lit? f) true]
        [(conj? f) (and (nnf? (conj-left f)) (nnf? (conj-rght f)))]
        [(disj? f) (and (nnf? (disj-left f)) (nnf? (disj-rght f)))]
        [else false]))

(define (make-elem arg1 arg2)
  (cons arg1 arg2))


(define f1 (disj (neg 'a) 'b))
(free-vars f1)
(search-value 'a (car (gen-vals (free-vars f1))))
(search-value 'b (car (gen-vals (free-vars f1))))
(eval-formula (second (gen-vals (free-vars f1))) f1)
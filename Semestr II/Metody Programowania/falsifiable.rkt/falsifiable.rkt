#lang racket

(require "props.rkt") 
(provide falsifiable-cnf?)

;;;PROCEDURY POMOCNICZE

;; Zadanie 1
(define (var? t)
  (symbol? t))

(define (operator? t)
  (or (eq? t 'neg)
      (eq? t 'conj)
      (eq? t 'disj)))

(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq? 'neg (car t))))

(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'disj (car t))))

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


(define (neg opnd)
    (list 'neg opnd))

(define (conj opnd-a opnd-b)
    (list 'conj opnd-a opnd-b))

(define (disj opnd-a opnd-b)
    (list 'disj opnd-a opnd-b))

(define neg-subf second)

(define conj-left second)

(define conj-rght third)

(define disj-left second)

(define disj-rght third)


(define (literal v)
    (if (neg? v)
         (list 'lit 'neg (neg-subf v))
         (list 'lit 'pos v)))

(define (literal? v)
        (and (list? v)
             (= 3 (length v))
			 (eq? (car v) 'lit)))

(define (positive? v)
		(eq? (second v) 'pos))


;; Zadanie 3


(define p
  (list 'neg (list 'disj (list 'conj 'a 'b) (list 'neg 'a))))
  ;;  ~ ( (a /\ b) \/ ~a)

(define pp (neg (disj (conj 'a 'b) (neg 'a))))

(define (free-vars f)
        (define (free-vars-aux f)
            (cond [(var? f) (list f)]
                  [(literal? f) (list (third f))]
                  [(neg? f) (free-vars-aux (neg-subf f))]
                  [(disj? f)  (append (free-vars-aux (disj-left f))                   
                                      (free-vars-aux (disj-rght f)))]
                  [(conj? f)  (append (free-vars-aux (conj-left f))                   
                                      (free-vars-aux (conj-rght f)))]))
        (remove-duplicates (free-vars-aux f)))


;; Zadanie 4

(define (gen-vals  xs)
  (if (null? xs)
      (list  null)
      (let* ((vss   (gen-vals (cdr xs)))
             (x     (car xs))
             (vst   (map (lambda(vs) (cons (list x true)   vs)) vss))
             (vsf   (map (lambda(vs) (cons (list x false) vs)) vss)))
        (append  vst  vsf))))

(define (eval-formula values formula)
    (define (search-value variable lst)
        (if (eq? (caar lst) variable)
            (cadar lst)
            (search-value variable (cdr lst))))

    (cond [(var? formula) (search-value formula values)]
          [(literal? formula) (if (positive? formula)
                                  (search-value formula values)
                                   (not (search-value formula values)))]
          [(neg? formula) (not (eval-formula values (neg-subf formula)))]  
          [(conj? formula) (and (eval-formula values (conj-left formula)) 
                                (eval-formula values (conj-rght formula)))]
          [(disj? formula) (or (eval-formula values (disj-left formula)) 
                               (eval-formula values (disj-rght formula)))]))

(define valuation (car (gen-vals (free-vars p))))


(define (falsifiable-eval? formula)
        (define (search list-values)
            (if (null? list-values) 
                  false
                  (if (eval-formula (car list-values) formula) 
                      (search (cdr list-values))
                      (car list-values))))
        (search (gen-vals (free-vars formula))))

;;Zadanie 5


(define (nnf? f)
    (or (literal? f)
        (and (conj? f)
             (nnf? (conj-left f))
             (nnf? (conj-rght f)))
        (and (disj? f)
             (nnf? (disj-left f))
             (nnf? (disj-rght f)))))

;;wzajemnie rekurencyjne
(define (even? n)
    (if (= n 0)
        true
        (odd? (- n 1))))

(define (odd? n)
    (if (= n 0)
        false
        (even? (- n 1))))

(define (even1? n)
    (define (even2? n flag)
        (if (= n 0)
            flag
            (even2? (- n 1) (not flag))))
    (even2? n true))

;; Zadanie 6


(define (convert-to-nnf f)
    (define (ctn f flag)
        (cond [(var? f)   (if flag 
                              (literal (neg f))
                              (literal f))]  
              [(neg? f)    (ctn (neg-subf f) (not flag))]
              [(conj? f)   (if flag ;; (A \/ B)
                                (disj (ctn (conj-left f) flag) (ctn (conj-rght f) flag))
                                (conj (ctn (conj-left f) flag) (ctn (conj-rght f) flag)))]
              [(disj? f)   (if flag 
                                (conj (ctn (disj-left f) flag) (ctn (disj-rght f) flag))
                                (disj (ctn (disj-left f) flag) (ctn (disj-rght f) flag)))]
                              ))
    (ctn f #f))
    


(define (forall l p?)
    (if (null? l)
        true
        (and (p? (car l)) (forall (cdr l) p?))))

(define disjs list)
(define (disjs? l)
        (list? l))

(define cnf list)
(define (cnf? f)
    (and (list? f)
         (forall f (lambda (l) (disj? l)))))


(define (convert-to-cnf f)

    (define (ctc-merge xss yss acc)
        (if (null? yss)
            acc
            (ctc-merge xss (cdr yss) 
                (append (map (lambda (xs) (append (car yss) xs)) xss) acc))))
        
        (cond 
            [(literal? f)   (cnf (list f))]
            [(conj? f)      (let 
                                ([l (convert-to-cnf (conj-left f))]
                                 [r (convert-to-cnf (conj-rght f))])
                              (append  l r))]
            [(disj? f)      (let 
                                ([l (convert-to-cnf (disj-left f))]
                                 [r (convert-to-cnf (disj-rght f))])
                              (ctc-merge l r '()))]))
                    


(define (eval-cnf f v)
 (define (search-value variable lst)
        (if (eq? (caar lst) variable)
            (cdar lst)
            (search-value variable (cdr lst))))
 (define (clause xs)
    (if (null? xs)  
        #f
        (if (search-value (car xs) v)
            #t
            (clause (cdr xs)))))
(define (aux f)
 (if (null? f)
     #f
     (if (clause (car f))
        (aux (cdr f))
        #f)))
(aux f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;FALSIFIABLE-CNF

(define (falsifiable-cnf? f)
  (define converted-f (convert-to-cnf (convert-to-nnf f)))

  (define (to-false clausule res)
    (cond
      [(empty? clausule) res]
      [(eq? (second (car clausule)) 'pos) (to-false (cdr clausule) (cons (list (third (car clausule)) #f) res))]
      [(eq? (second (car clausule)) 'neg) (to-false (cdr clausule) (cons (list (third (car clausule)) #t) res))]))

  
  (define (check-duplicates l)
    (define (check-duplicates-aux l x)
      (cond
        [(empty? l) #f]
        [(and (eq? (first x) (first (car l))) (not (equal? (second x) (second (car l))))) #t]
        [else (check-duplicates-aux (cdr l) x)]))

    (cond
      [(empty? l) #f]
      [(check-duplicates-aux (cdr l) (car l)) #t]
      [else (check-duplicates (cdr l))]
    ))

  (define (iter-through-clauses f)
    (cond
      [(empty? f) #f]
      [else
       (let ([lista (to-false (car f) '())])
         (cond
           [(check-duplicates lista) (iter-through-clauses (cdr f))]
           [else (remove-duplicates lista)]))]))

  (iter-through-clauses converted-f))


;;;FALSIFIABLE GORZEJ

(define (falsifiable?-but-worse f)

  (define valuations (gen-vals (free-vars f)))

  (define (falsifiable?-but-worse-aux valuations formula)
    (cond 
      [(empty? valuations) #f]
      [(false? (eval-formula (first valuations) formula)) (first valuations)]
      [else (falsifiable?-but-worse-aux (cdr valuations) formula)]
    ))

  (falsifiable?-but-worse-aux valuations f))

  
  


;(define a1 (conj (disj 'b (neg 'b)) (disj (disj 'b (conj 'd 'c)) (neg 'a))))
;(define a2 (conj (disj 'b (disj 'c (neg 'b))) (disj 'a (neg 'a))))
;(define a3 (disj (neg (conj (disj 'b (neg 'b)) (disj 'a (neg 'a)))) (conj 'a 'b)))
;(define a4 (conj (disj 'b (neg 'b)) (disj 'a (neg 'a))))


;(time (falsifiable-cnf? a1))
;(time (falsifiable?-but-worse a1))
;(time (falsifiable-cnf? a2))
;(time (falsifiable?-but-worse a2))
;(falsifiable-cnf? a3)
;(falsifiable?-but-worse a3)
;(falsifiable-cnf? a4)
;(falsifiable?-but-worse a4)

; Wolniejszą jest procedura falsifiable?-but-worse. Wynika to z faktu, że by zwrócić wynik,
; musi ona ewaluować formułę dla każdego wartościowania, co wiąże się z wywoływaniem procedury eval-formula 2^n razy. Daje to ogromną,
; wykładniczą złożoność. Z kolei procedura falsifiable? wykorzystuje obserwację, że formuła w cnf jest tautologią tylko wtedy, gdy w każdej
; klauzuli tej formuły (nawiasie) znajduje się dysjunkcja pewnej zmiennej i jej negacji. Wtedy wystarczy tylko spróbować sfalsyfikować
; wszystkie alternatywy negując wszystkie literały. Jeśli się to uda, to wiemy, że formuła jest falsyfikowalna, inaczej jest tautologią.
; Takie podejście zapewnia nam znacznie mniejszą złożoność czasową n^2, co czyni ten algorytm zdecydowanie bardziej optymalnym.
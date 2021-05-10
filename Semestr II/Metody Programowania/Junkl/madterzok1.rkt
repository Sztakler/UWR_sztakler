#lang racket

(require racket/contract)

(define/contract foo number? 42)

(define/contract  (dist x y) (-> number? number? number?)
    (abs (- x y)))

(define/contract (average x y) 
    (-> number? number? number?)
    (/ (+ x y) 2))

(define/contract (square x) 
    (-> number? number?)
    (* x x))

(define/contract (sqrt x) 
    (-> positive? positive?)
    (define (improve approx)
        (average (/ x approx) approx))
    (define (good-enough? approx)
        (< (dist x (square approx)) 0.0001))
    (define (iter approx)
        (cond
            [(good-enough? approx) approx]
            [else (iter (improve approx))]))
   (iter 1.0))

(define natural/c ;notacja kontraktów
    (and/c integer? (not/c negative?)))

(define exact-natural/c
    (and/c natural/c exact?))

(define positive-natural/c
    (and/c positive? integer?))

(define/contract (fact n)
    (-> exact-natural/c positive-natural/c)
    (if (= n 0)
        1
        (* n (fact (- n 1)))))  

(define/contract (fact-it n)
    (-> exact-natural/c positive-natural/c)
    (define (fact-it-aux n i res)
        (if (> i n)
            res
            (fact-it-aux n (+ i 1) (* i res))))
    (fact-it-aux n 1 1))

(define/contract (inc x)
    (-> number? number?)
    (+ 1 x))

(define/contract (sum val next start end)
    (-> (-> number? number?) (-> number? number?) number? number? number?)
    (if (> start end)
        0
        (+ (val start)
            (sum val next (next start) end))))

(define/contract (good-enough? x y)
    (-> number? number? boolean?)
    (< (dist x y) 0.00001))

(define/contract (fixed-point f s)
    (-> (-> number? number?) number? number?)
    (define (iter k)
        (let ([new-k (f k)])
            (if (good-enough? k new-k)
                k
                (iter new-k))))
    (iter s))

(define/contract (average-damp f)
    (-> (-> number? number?) (-> number? number?))
    (lambda (x) (average x (f x))))

(define/contract (sqrt-ad x)
    (-> positive? number?)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

;(sqrt-ad 5)

(define/contract (fixed-point-of-transform transform f x)
    (-> (-> (-> number? number?) 
            (-> number? number?))
        (-> number? number?) 
        number? 
        number?)
    (fixed-point ((transform f) x)))

(define (sqrt-ad-t x)
    (fixed-point-of-transform average-damp (lambda (y) (/ x y) 1.0)))

(define/contract (id-weak x)
    (-> any/c any/c)
    'x)

;; KONTRAKTY PARAMETRYCZNE

(define/contract (id x)
    (parametric->/c [a] (-> a a)) ; kontrakt parametryczny (wystąpienie negatywny musi byc
    x)                            ; identyczne z wystąpienie negatywnym)

;(id 1)
;(id 'asdf)

(define/contract l (listof number?) '(1 2 3))

(define/contract (append-weak xs ys)
    (-> list? list? list?)
    (if (null? xs)
        ys
        (cons (car xs) (append (cdr xs) ys)))) ;przepuści '(car xs)


(define/contract (append xs ys)
    (parametric->/c [a] (-> (listof a) (listof a) (listof a)))
    (if (null? xs)
        ys
        (cons (car xs) (append (cdr xs) ys))))
    
;(append '(1 #f 3.4)  '( 4 'b 6))

(define/contract (filter p? xs)
    (parametric->/c [a] (-> (-> a boolean?) (listof a) (listof a)))
    (if (null? xs)
        null
        (if (p? (car xs))
            (cons (car xs)
                  (filter p? (cdr xs)))
            (filter p? (cdr xs)))))

;(filter boolean? '(1 #t x 'abc #f))

(define/contract (map f xs)
    (parametric->/c [a b] (-> (-> a b) (listof a) (listof b)))
    (if (null? xs)  
        null
        (cons (f (car xs)) ;nie widzi różnicy między (f (car xs)) a (car xs) (nie widzi f), trzeba wprowadzic dodatkowa etykietę 'b'
              (map f (cdr xs)))))

;(map (lambda (x) (* 2 x)) '(1 2 3))
;(map boolean? '(1 #t 'x #f))

(define/contract (bad-map f xs)
    (parametric->/c [a b] (-> (-> a b) (listof a) (listof b)))
    (define (map-iter xs ys)
        (cond [(null? xs) ys]
              [else (map-iter (cdr xs) (cons (f (car xs)) ys))]))
    (reverse (map-iter xs '())))

;(bad-map (lambda (x) (* 2 x)) '(1 2 3))
;(bad-map boolean? '(1 #t 'x #f))

; KONTRAKTY DOTYCZĄCE STRUKTUR

(struct node (v l r) #:transparent)
(struct leaf ()      #:transparent)

(define/contract (tree? t)
    (-> any/c boolean?)
    (match t
        [(leaf)       true]
        [(node _ l r) (and (tree? l)
                           (tree? r))]
        [_            false]))

(tree? leaf)
(tree? (leaf))
(tree? (node 1 (leaf) (leaf)))

(define/contract (bad-insert-bst v t)
    (-> any/c tree? tree?)
    (match t
        [(leaf) (node v (leaf) (leaf))] ;znowu problem (dodaje także 'v)
        [(node w l r)
         (if (< v w)
             (node w (insert-bst v l) r)
             (node w l (insert-bst v r)))]))

;(bad-insert-bst 5 (leaf))

(define (treeof-bad c)
    (or/c (struct/c leaf)
          (struct/c node c (treeof-bad c) (treeof-bad c)))) ;rekurencyjnie działa w nieskończoność

(define (treeof c) 
    (flat-rec-contract tree ;oznacza kontrakt rekurencyjny
        (struct/c leaf)
        (struct/c node c tree tree)))

(define/contract (insert-bst v t)
    (-> number? (treeof number?) (treeof number?))
    (match t
        [(leaf) (node v (leaf) (leaf))] ;tutaj z kolei za v można podstawić inną liczbę, np. zawsze dodawać 2
        [(node w l r)
         (if (< v w)
             (node w (insert-bst v l) r)
             (node w l (insert-bst v r)))]))

(insert-bst 5 (leaf))  
         
#lang racket

(provide make-hnode make-elem elem-priority elem-val empty-heap heap-insert heap-merge heap-min heap-pop heap-empty?)
 
(define (tagged-list? len sym x)
  (and (list? x)
       (= (length x) len)
       (eq? (first x) sym)))

(define (elem-val x) (cdr x))

;;;  leftist  heaps (after  Okasaki)
;; data  representation

(define leaf 'leaf)

(define (leaf? h)
  (eq? 'leaf h))

(define (hnode? h)
  (and (tagged-list? 5 'hnode h)
       (natural? (caddr h))))

(define (make-hnode  elem  heap-a  heap-b)
  (cond
    [(> (rank heap-a) (rank heap-b)) (list 'hnode elem (inc (rank heap-b)) heap-a heap-b)]
    [else (list 'hnode elem (inc (rank heap-b)) heap-b heap-a)]))

(define (hnode-elem h)
  (second h))

(define (hnode-left h)
  (fourth h))

(define (hnode-right h)
  (fifth h))

(define (hnode-rank h)
  (third h))

(define (hord? p h)
 (or (leaf? h)
     (<= p (elem-priority (hnode-elem h)))))

(define (inc x)
  (+ 1 x))



(define (elem-priority x)
  (car x))

(define (elt p d)
  (cons p d))

(define (elt-prio c)
  (car c))

(define (elt-data c)
  (cdr c))


(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (hnode-left h))
           (heap? (hnode-right h))
           (<= (rank (hnode-right h))
               (rank (hnode-left h)))
           (= (rank h) (inc (rank (hnode-right h))))
           (hord? (elem-priority (hnode-elem h))
                  (hnode-left h)))))

(define (rank h)
  (if (leaf? h)
      0
      (hnode-rank h)))

;; operations

(define empty-heap  leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-merge heap_a heap_b)
  (cond [(leaf? heap_a) heap_b]
        [(leaf? heap_b) heap_a]
        [else
         (let*
               ([min_a (heap-min heap_a)]
                [min_b (heap-min heap_b)])
             (if (<= (car min_a) (car min_b))
                 (let*
                     ((e min_a)
                     (hl (hnode-left heap_a))
                     (hr (hnode-right heap_a))
                     (h heap_b))
                   
                     (make-hnode e (heap-merge hr h) hl))
                 
                 (let*
                     ((e min_b)
                     (hl (hnode-left heap_b))
                     (hr (hnode-right heap_b))
                     (h heap_a))
                   
                     (make-hnode e (heap-merge hr h) hl))))]))

(define (heap-insert  elt  heap)
  (heap-merge  heap (make-hnode  elt  leaf  leaf)))

(define (heap-min  heap)
  (hnode-elem  heap))

(define (heap-pop  heap)
  (heap-merge (hnode-left  heap) (hnode-right  heap)))

(define heap empty-heap)

(define (make-elem pri val)
  (cons pri val))



  

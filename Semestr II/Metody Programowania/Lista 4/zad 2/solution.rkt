#lang racket

(require "leftist.rkt")
(provide heapsort) 

(define (heapsort lista)
  (define (make-heap lista)
  (if (null? lista)
       empty-heap
      (heap-insert (make-elem (car lista) (car lista)) (make-heap (cdr lista)))))
  (define (heapsort-aux heap)
    (if (heap-empty? heap)
        null
        (cons (car (heap-min heap)) (heapsort-aux (heap-pop heap)))))
  (let ([heap (make-heap lista)])
    (heapsort-aux heap)))
#lang racket

(provide split merge mergesort)

;-


(define (split l1)
  (define half (floor (/ (length l1) 2)))
  (define (split-iter l1 i res)
    (if (> i half)
        (cons res l1)
        (split-iter (cdr l1) (+ i 1) (append res (list (car l1))))))   
  (split-iter l1 1 '()))

;;(define a (list 1 2 3 4 5))

(define (merge l1 l2)
  (define (merge-aux res l1 l2)
    (cond [(and (empty? l1) (empty? l2)) res]
          [(empty? l1) (merge-aux (append res l2) l1 '())]
          [(empty? l2) (merge-aux (append res l1) '() l2)]
          [else (if (< (car l1) (car l2))
                    (merge-aux (append res (list (car l1))) (cdr l1) l2)
                    (merge-aux (append res (list (car l2))) l1 (cdr l2)))]))
  (merge-aux '() l1 l2))

(define (mergesort l)
  (if (<= (length l) 1)
      l
      (let* [
             (splitted (split l))
             (half1 (car splitted))
             (half2 (cdr splitted))
             ]
        (merge (mergesort half1) (mergesort half2)))))

;;Testy pochodzą z https://stackoverflow.com/questions/15123988/tests-cases-for-merge-in-merge-sort
(define l1 (list 12 15 23 4 6 10 35 28)) ;;Even number of element
(define l2 '()) ;;Empty list 
(define l3 null) ;;Null pointer
(define l4 (list 4 6 10 12 15 23 28 35)) ;;already sorted list
(define l5 (list 12 15 23 4  6 10 35)) ;;odd length list
(define l6 (list 35 28 23 15 12 10 6 4)) ;;descending sorted array input
(define l7 (list 12)) ;;one element
(define l8 (list 12 4)) ;; two elements
(define l9 (list 12 15 23 4 6 10 35 28 100 130 500 1000 235 554 75 345 800 222 333 888 444 111 666 777 60)) ;;large list of elements 
(define l10 (list 12 15 -23 -4 6 10 -35 28)) ;;negative elements
(define l11 (list 12 12 23 4 6 6 10 -35 28)) ;;duplicate elements
(define l12 (list 12 12 12 12 12)) ;;Same element        

(mergesort l1)
(mergesort l2)
(mergesort l3)
(mergesort l4)
(mergesort l5)
(mergesort l6)
(mergesort l7)
(mergesort l8)
(mergesort l9)
(mergesort l10)
(mergesort l11)
(mergesort l12)


#lang racket

(provide partition quicksort)

;Zadanie rozwiązane przy współracy z Czarek Świtała, Bartosz Janikowski i Piotr Dobiech

(define (partition n xs)
  (define (partition-aux n xs lleft lright)
    (if (empty? xs)
        (cons lleft lright)
        (if (<= (car xs) n)
            (partition-aux n (cdr xs) (cons (car xs) lleft) lright)
            (partition-aux n (cdr xs) lleft (cons (car xs) lright)))))
  (partition-aux n (cdr xs) '() '()))

(define (quicksort xs)
  (if (<= (length xs) 1)
      xs
      (let*(
          [n (car xs)]
          [halves (partition n xs)]
          [left (car halves)]
          [right (cdr halves)]
          )
        (append (quicksort left) (list n) (quicksort right)))))


;;Testy pochodzą z https://stackoverflow.com/questions/15123988/tests-cases-for-merge-in-merge-sort
(define l1 (list 12 15 23 4 6 10 35 28)) ;;Even number of element
(define l2 '()) ;;Empty list 
(define l3 null) ;;Null pointer
(define l4 (list 4 6 10 12 15 23 28 35)) ;;already sorted list
(define l5 (list 12 15 23 4 6 10 35)) ;;odd length list
(define l6 (list 35 28 23 15 12 10 6 4)) ;;descending sorted array input
(define l7 (list 12)) ;;one element
(define l8 (list 12 4)) ;; two elements
(define l9 (list 12 15 23 4 6 10 35 28 100 130 500 1000 235 554 75 345 800 222 333 888 444 111 666 777 60)) ;;large list of elements 
(define l10 (list 12 15 -23 -4 6 10 -35 28)) ;;negative elements
(define l11 (list 12 12 23 4 6 6 10 -35 28)) ;;duplicate elements
(define l12 (list 12 12 12 12 12)) ;;Same element        


(quicksort l1)
(quicksort l2)
(quicksort l3)
(quicksort l4)
(quicksort l5)
(quicksort l6)
(quicksort l7)
(quicksort l8)
(quicksort l9)
(quicksort l10)
(quicksort l11)
(quicksort l12)



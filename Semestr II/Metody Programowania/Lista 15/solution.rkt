#lang racket

#|
Zadanie wykonane wspólnie z Piotrem Dobiechem
|#

(provide philosopher)

#|
(define (random-sleep)
  (sleep (/ (random) 1000)))

(define (make-table)
  (define forks (build-list 5 (lambda (_) (make-semaphore 1))))
  (define (pick-fork k)
    (random-sleep)
    (semaphore-wait (list-ref forks k)))
  (define (put-fork k)
    (random-sleep)
    (semaphore-post (list-ref forks k)))

  (lambda (op)
    (match op
      ['pick-fork pick-fork]
      ['put-fork put-fork])))
|#

(define (philosopher table philosopher-number)
  (let ([left-hand (modulo (+ philosopher-number 1) 5)]
        [right-hand philosopher-number])
    (if (= philosopher-number 0)
        (begin
          ((table 'pick-fork) left-hand)
          ((table 'pick-fork) right-hand)
          ((table 'put-fork) left-hand)
          ((table 'put-fork) right-hand))
        (begin
          ((table 'pick-fork) right-hand)
          ((table 'pick-fork) left-hand)
          ((table 'put-fork)  right-hand)
          ((table 'put-fork)  left-hand)))))

#|
(define (run-concurrent . thunks)
  (define threads (map thread thunks))
  (for-each thread-wait threads))

(define (test2)
  (define table (make-table))
  (run-concurrent
    (lambda()  (for ([i 5]) (philosopher table 0)))
    (lambda() (for ([i 2]) (philosopher table 1)))
    (lambda()  (for ([i 1]) (philosopher table 2)))
    (lambda() (for ([i 3]) (philosopher table 3)))
    (lambda() (for ([i 7]) (philosopher table 4)))))

; test2 tysiąc razy.
(for ([i 1000]) (begin (displayln (string-append "<szamanko noises> " (number->string i)))
                       (test2)))
|#
#lang racket

(define input
  ((compose string->list
            first
            file->lines)
   "input.txt"))

(call/cc
  (lambda (return)
    (foldl (lambda (c fp)
             (let ([p (cdr fp)]
                   [f (car fp)])
               (cond
                 [(< f 0) (return p)]
                 [(char=? c #\() (cons (+ f 1) (+ p 1))]
                 [(char=? c #\)) (cons (- f 1) (+ p 1))])))
           (cons 0 0)
           input)))

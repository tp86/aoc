#lang racket

(define input
  ((compose string->list
            first
            file->lines)
   "input.txt"))

(call/cc
  (λ (return)
    (foldl (λ (c fp)
             (let* ([p (cdr fp)]
                    [f (car fp)]
                    [new-p (+ p 1)])
               (cond
                 [(< f 0) (return p)]
                 [(char=? c #\() (cons (+ f 1) new-p)]
                 [(char=? c #\)) (cons (- f 1) new-p)])))
           (cons 0 0)
           input)))

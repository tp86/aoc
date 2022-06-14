#lang racket

(define input
  ((compose string->list
            first
            file->lines)
   "input.txt"))

(foldl (λ (c f)
         (cond
           [(char=? c #\() (+ f 1)]
           [(char=? c #\)) (- f 1)]))
       0
       input)

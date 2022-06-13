#lang racket

(define input
  ((compose string->list
            first
            file->lines)
   "input.txt"))

(foldl (lambda (c f)
         (cond
           [(char=? c #\() (+ f 1)]
           [(char=? c #\)) (- f 1)]))
       0
       input)

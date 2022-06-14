#lang racket

(define input
  (string->list
    (first (file->lines "input.txt"))))

; part 1
(set-count
  (list->set
    (for/fold
      ([houses (list (cons 0 0))])
      ([c input])
      (let ([x (caar houses)]
            [y (cdar houses)])
        (case c
          [(#\<) (cons (cons (- x 1) y) houses)]
          [(#\>) (cons (cons (+ x 1) y) houses)]
          [(#\^) (cons (cons x (- y 1)) houses)]
          [(#\v) (cons (cons x (+ y 1)) houses)]))

; part 2
(set-count
  (list->set
    (call-with-values
      (λ ()
        (for/fold
          ([houses (list (cons 0 0))]
           [other-houses (list (cons 0 0))])
          ([c input])
          (let ([x (caar houses)]
                [y (cdar houses)])
            (values other-houses
              (case c
                [(#\<) (cons (cons (- x 1) y) houses)]
                [(#\>) (cons (cons (+ x 1) y) houses)]
                [(#\^) (cons (cons x (- y 1)) houses)]
                [(#\v) (cons (cons x (+ y 1)) houses)])))))
      append)))

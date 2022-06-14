#lang racket

(define (present-wrap-area l w h)
  (let* ([lw (* l w)]
         [wh (* w h)]
         [hl (* h l)]
         [smallest (min lw wh hl)])
    (apply + smallest (map (λ (x) (* 2 x)) (list lw wh hl)))))

(define input
  (let ([lines (file->lines "input.txt")])
    (map (λ (line)
           (map string->number (string-split line "x")))
         lines)))

(for/sum ([dims input])
  (apply present-wrap-area dims))

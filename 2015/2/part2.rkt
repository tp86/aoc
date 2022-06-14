#lang racket

(define (present-ribbon-area l w h)
  (let* ([lw (+ l w)]
         [wh (+ w h)]
         [hl (+ h l)]
         [smallest (min lw wh hl)]
         [bow (* l w h)])
    (+ (* 2 smallest) bow)))

(define input
  (let ([lines (file->lines "input.txt")])
    (map (λ (line)
           (map string->number (string-split line "x")))
         lines)))

(for/sum ([dims input])
  (apply present-ribbon-area dims))

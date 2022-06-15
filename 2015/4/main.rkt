#lang racket

(require file/md5)

(define input "yzbqklnj")

(define (solve number-of-zeros)
  (let ([prefix (make-bytes number-of-zeros (char->integer #\0))])
    (let loop ([n 0])
      (let* ([m (md5 (string-append input (number->string n)))]
             [beq (bytes=? (subbytes m 0 number-of-zeros) prefix)])
        (cond
          [beq n]
          [else
            (loop (+ n 1))])))))

; part 1
(solve 5)

; part 2
(solve 6)

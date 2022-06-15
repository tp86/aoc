#lang racket

(require file/md5)

(define input "yzbqklnj")

(define number-of-zeros 5)

(define prefix (make-bytes number-of-zeros (char->integer #\0)))

(let loop ([n 1])
  (let* ([m (md5 (string-append input (number->string n)))]
         [beq (bytes=? (subbytes m 0 5) prefix)])
    (cond
      [beq n]
      [else
        (loop (+ n 1))])))

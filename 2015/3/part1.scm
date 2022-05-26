(import (chicken io))
(require-extension srfi-113)
(require-extension srfi-133)
(require-extension srfi-128)

(define vec=
  (make-vector-comparator
    (make-comparator exact-integer? = < number-hash)
    vector?
    vector-length
    vector-ref))

(print
  (with-input-from-file
    "input.txt"
    (lambda ()
      (let ((current-position (vector 0 0)))
        (let loop ((c (read-char))
                   (current-position current-position)
                   (houses (set vec= current-position)))
          (cond
            ((eof-object? c) (set-size houses))
            (else
              (let* ((x (vector-ref current-position 0))
                     (y (vector-ref current-position 1))
                     (pos (vector
                            (case c
                              ((#\<) (- x 1))
                              ((#\>) (+ x 1))
                              (else x))
                            (case c
                              ((#\v) (- y 1))
                              ((#\^) (+ y 1))
                              (else y)))))
                (loop
                  (read-char)
                  pos
                  (set-adjoin
                    houses
                    pos))))))))))

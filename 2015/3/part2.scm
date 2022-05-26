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
      (let* ((current-position (vector 0 0))
             (position current-position)
             (other-position current-position))
        (let loop ((c (read-char))
                   (position position)
                   (other-position other-position)
                   (houses (set vec= position))
                   (other-houses (set vec= other-position)))
          (cond
            ((eof-object? c)
             (set-size (set-union houses other-houses)))
            (else
              (let* ((x (vector-ref position 0))
                     (y (vector-ref position 1))
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
                  other-position
                  pos
                  other-houses
                  (set-adjoin
                    houses
                    pos))))))))))

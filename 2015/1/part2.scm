(import (chicken io))

(print
  (with-input-from-file
    "input.txt"
    (lambda ()
      (let loop ((c (read-char))
                 (floor 0)
                 (pos 0))
        (cond
          ((= floor -1) pos)
          (else
            (loop
              (read-char)
              ((case c
                 ((#\() (lambda (f) (+ f 1)))
                 ((#\)) (lambda (f) (- f 1)))
                 (else identity))
               floor)
              (+ pos 1))))))))

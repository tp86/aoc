(define input-file-path "input.txt")

(define (count-distinct-positions positions)
  (let loop ((count 0)
             (posl positions))
    (cond
      ((null? posl) count)
      (else
        (if (member (car posl) (cdr posl))
          (loop count (cdr posl))
          (loop (+ count 1) (cdr posl)))))))

(define (move c pos)
  (let ((x (car pos))
        (y (cdr pos)))
    (case c
      ((#\<) (cons (- x 1) y))
      ((#\>) (cons (+ x 1) y))
      ((#\^) (cons x (+ y 1)))
      ((#\v) (cons x (- y 1)))
      (else pos))))

(define (process-file)
  (let ((starting-position (cons 0 0)))
    (let loop ((c (read-char))
               (position starting-position)
               (visited-positions (list)))
      (cond
        ((eof-object? c) (count-distinct-positions visited-positions))
        (else
          (loop (read-char)
                (move c position)
                (cons position visited-positions)))))))

(define result
  (with-input-from-file
    input-file-path
    process-file))

result

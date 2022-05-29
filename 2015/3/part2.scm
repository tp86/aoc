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

(define starting-position (cons 0 0))
(define-record santa-houses pos houses)
(define santa (make-santa-houses starting-position (list)))
(define robo-santa (make-santa-houses starting-position (list)))

(define (process-file)
    (let loop ((c (read-char))
               (santas (cons santa robo-santa)))
      (cond
        ((eof-object? c) (count-distinct-positions
                           (append (santa-houses-houses (car santas))
                                   (santa-houses-houses (cdr santas)))))
        (else
          (let* ((curr-santa (car santas))
                 (other-santa (cdr santas))
                 (pos (santa-houses-pos curr-santa))
                 (houses (santa-houses-houses curr-santa)))
            (santa-houses-pos-set! curr-santa (move c pos))
            (santa-houses-houses-set! curr-santa (cons pos houses))
            (loop (read-char)
                  (cons other-santa curr-santa)))))))

(define result
  (with-input-from-file
    input-file-path
    process-file))

result

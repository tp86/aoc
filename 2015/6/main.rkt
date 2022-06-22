#lang racket

; part 1
(define size 1000)
(define grid
  (let ([g (make-vector size #f)])
    (for/vector ([row g])
      (make-vector size 'off))))

(define (get-light grid x y)
  (vector-ref (vector-ref grid x) y))

(define (set-light! grid x y state)
  (let ([row (vector-ref grid x)])
    (vector-set! row y state)))

(define (light-on! grid x y)
  (set-light! grid x y 'on))

(define (light-off! grid x y)
  (set-light! grid x y 'off))

(define (light-toggle! grid x y)
  (let ([light (get-light grid x y)])
    (case light
      [(on) (light-off! grid x y)]
      [(off) (light-on! grid x y)])))

(define (do-instruction instr)
  (match-let ([(list _ action x1 y1 x2 y2)
               (regexp-match #px"^(.*) (\\d+),(\\d+) through (\\d+),(\\d+)$" instr)])
    (let ([x1 (string->number x1)]
          [x2 (string->number x2)]
          [y1 (string->number y1)]
          [y2 (string->number y2)])
      (case action
        [("turn on") (lights-on! grid x1 y1 x2 y2)]
        [("toggle") (lights-toggle! grid x1 y1 x2 y2)]
        [("turn off") (lights-off! grid x1 y1 x2 y2)]))))

(define (lights-on! grid x1 y1 x2 y2)
  (for* ([x (in-range x1 (add1 x2))]
         [y (in-range y1 (add1 y2))])
    (light-on! grid x y)))

(define (lights-off! grid x1 y1 x2 y2)
  (for* ([x (in-range x1 (add1 x2))]
         [y (in-range y1 (add1 y2))])
    (light-off! grid x y)))

(define (lights-toggle! grid x1 y1 x2 y2)
  (for* ([x (in-range x1 (add1 x2))]
         [y (in-range y1 (add1 y2))])
    (light-toggle! grid x y)))

(define (do-all-instructions file-path)
  (for ([instr (in-list (file->lines file-path))])
    (do-instruction instr)))

(define (solve)
  (do-all-instructions "input.txt")
  (for*/sum ([x (in-range size)]
             [y (in-range size)])
    (let ([l (get-light grid x y)])
      (if (eq? l 'on)
        1
        0))))

; part 2
(define grid
  (let ([g (make-vector size #f)])
    (for/vector ([row g])
      (make-vector size 0))))

(define (light-on! grid x y)
  (let ([l (get-light grid x y)])
    (set-light! grid x y (add1 l))))

(define (light-off! grid x y)
  (let ([l (get-light grid x y)])
    (unless (<= l 0)
      (set-light! grid x y (sub1 l)))))

(define (light-toggle! grid x y)
  (let ([l (get-light grid x y)])
    (set-light! grid x y (+ 2 l))))

(define (solve)
  (do-all-instructions "input.txt")
  (for*/sum ([x (in-range size)]
             [y (in-range size)])
    (get-light grid x y)))

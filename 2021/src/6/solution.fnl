(local {: view} (require :fennel))
(fn pp [...]
  (each [_ value (ipairs [...])]
    (print (view value))))

(fn parse-input [input]
  (icollect [entry (input:gmatch "(%d+)")]
    (tonumber entry)))

(fn make-population [input]
  (local population [])
  (each [_ state (ipairs input)]
    (tset population state (+ 1 (or (. population state) 0))))
  population)

(fn next-day [population]
  (local next-population [])
  (for [state 0 8]
    (let [count (or (. population state) 0)]
      (case state
        0 (do
            (tset next-population 6 (+ count (or (. next-population 6) 0)))
            (tset next-population 8 count))
        7 (tset next-population 6 (+ count (or (. next-population 6) 0)))
        _ (tset next-population (- state 1) count))))
  next-population)

(fn run [input days]
  (let [initial (make-population input)
        final (faccumulate [population initial
                            _ 1 days]
                (next-day population))]
    (pp final)
    (accumulate [sum 0
                 _ count (pairs final)]
      (+ sum count))))

(fn solve-1 [input]
  (run input 80))

(fn solve-2 [input]
  (run input 256))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}

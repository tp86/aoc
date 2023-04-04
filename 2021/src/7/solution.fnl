(local {: view} (require :fennel))
(fn pp [...]
  (each [_ value (ipairs [...])]
    (print (view value))))

(fn parse-input [input]
  (icollect [entry (input:gmatch "(%d+)")]
    (tonumber entry)))

(fn solve-1 [input]
  (let [solutions []
        max-pos (math.max (table.unpack input))]
    (each [_ num (ipairs input)]
      (for [pos 0 max-pos]
        (tset solutions pos (+ (math.abs (- num pos))
                               (or (. solutions pos) 0)))))
    (accumulate [min math.huge
                 _ fuel (ipairs solutions)]
      (if (< fuel min) fuel min))))

(fn solve-2 [input]
  (let [solutions []
        max-pos (math.max (table.unpack input))
        sums (faccumulate [(sums running) (values [] 0)
                           n 0 max-pos]
               (let [running (+ n running)]
                 (tset sums n running)
                 (values sums running)))]
    (each [_ num (ipairs input)]
      (for [pos 0 max-pos]
        (tset solutions pos (+ (. sums (math.abs (- num pos)))
                               (or (. solutions pos) 0)))))
    (accumulate [min math.huge
                 _ fuel (ipairs solutions)]
      (if (< fuel min) fuel min))))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}

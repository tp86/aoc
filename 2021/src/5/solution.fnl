(fn parse-input [input]
  (icollect [entry (input:gmatch "[^\n]+")]
    entry))

(fn solve-1 [input])

(fn solve-2 [input])

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}

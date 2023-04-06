(local {: view} (require :fennel))
(fn pp [...]
  (each [_ value (ipairs [...])]
    (print (view value))))

(fn parse-input [input]
  (icollect [input-segments output-segments (input:gmatch "([^|]+) %| ([^\n]+)\n?")]
    {:inputs (icollect [segments (input-segments:gmatch "%a+")] segments)
     :outputs (icollect [segments (output-segments:gmatch "%a+")] segments)}))

(fn solve-1 [input]
  (accumulate [count 0
               _ {: outputs} (ipairs input)]
    (+ count (accumulate [count 0
                          _ segment (ipairs outputs)]
               (case (length segment)
                 2 (+ count 1)
                 3 (+ count 1)
                 4 (+ count 1)
                 7 (+ count 1)
                 _ count)))))

(fn solve-2 [input])

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}

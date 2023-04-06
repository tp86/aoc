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

(fn permutations [str]
  (let [n (length str)
        tbl (icollect [c (str:gmatch ".")] c)
        swap (fn [tbl i1 i2]
               (let [(v1 v2) (values (. tbl i1) (. tbl i2))]
                 (tset tbl i2 v1)
                 (tset tbl i1 v2)))
        permgen (fn recur [tbl n]
                  (if (= n 0)
                    (coroutine.yield (table.concat tbl))
                    (for [i 1 n]
                      (swap tbl i n)
                      (recur tbl (- n 1))
                      (swap tbl i n))))
        co (coroutine.create (fn [] (permgen tbl n)))]
    (fn []
      (let [(_ res) (coroutine.resume co)]
        res))))

(fn str-set= [s1 s2]
  (if (not= (length s1) (length s2))
    false
    (accumulate [result true
                 c1 (s1:gmatch ".")
                 &until (not result)]
      (and result (s2:find c1)))))

(fn solve-2 [input])

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}

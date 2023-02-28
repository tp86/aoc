(import-macros {: test} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local samples-1 [["" nil]])

(test
  part-1
  (each [_ sample (ipairs samples-1)]
    (let [[input expected] sample]
      (lu.assertEquals (solve-1 input) expected))))

(local samples-2 [["" nil]])

(test
  part-2
  (each [_ sample (ipairs samples-2)]
    (let [[input expected] sample]
      (lu.assertEquals (solve-2 input) expected))))

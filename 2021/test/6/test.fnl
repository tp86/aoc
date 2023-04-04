(import-macros {: test-fn} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "3,4,3,1,2")
(local answer-1 5934)
(local answer-2 26984457539)

(test-fn
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test-fn
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))

{: part-1
 : part-2}

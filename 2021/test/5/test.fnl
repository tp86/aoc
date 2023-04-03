(import-macros {: test-fn} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "")
(local answer-1 nil)
(local answer-2 nil)

(test-fn
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test-fn
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))

{: part-1
 : part-2}

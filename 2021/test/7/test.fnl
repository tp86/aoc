(import-macros {: test-fn} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "16,1,2,0,4,2,7,1,2,14")
(local answer-1 37)
(local answer-2 168)

(test-fn
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test-fn
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))

{: part-1
 : part-2}

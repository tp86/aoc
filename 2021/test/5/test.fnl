(import-macros {: test-fn} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2")
(local answer-1 5)
(local answer-2 12)

(test-fn
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test-fn
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))

{: part-1
 : part-2}

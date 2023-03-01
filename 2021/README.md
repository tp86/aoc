# Year 2021 in Fennel

Solutions for 2021 year in Fennel with TDD

## Setup

- obtain session cookie for adventofcode.com and store in .aoc-session file
- `tester/tester.fnl setup`
- `./helper setup`

## AOC solution flow

- `./helper day <day>`
- fill sample data in test/<day>/test.fnl
- `./helper test <day>`
- solve!
- `./helper run <day>` to get answers for input

### Issues

- `helper` requires refactoring

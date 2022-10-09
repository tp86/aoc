local aoc = require('aoc')

local input = aoc.readlines('input.txt')

local threevowelspat = table.concat({'[aeiou]', '[aeiou]', '[aeiou]' }, '.*')
local doubleletterpat = '(.)%1'
local naughtypats = { 'ab', 'cd', 'pq', 'xy' }
local function isnice1(s)
  if not string.match(s, threevowelspat) then return false end
  if not string.match(s, doubleletterpat) then return false end
  for _, pat in ipairs(naughtypats) do
    if string.match(s, pat) then return false end
  end
  return true
end

local doubletwoletterspat = '(..).*%1'
local surroundpat = '(.).%1'
local function isnice2(s)
  if not string.match(s, doubletwoletterspat) then return false end
  if not string.match(s, surroundpat) then return false end
  return true
end

local function solve(input, fn)
  local count = 0
  for _, s in ipairs(input) do
    if fn(s) then count = count + 1 end
  end
  return count
end

print('1', solve(input, isnice1))
print('2', solve(input, isnice2))

local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local input = rawinput[1]

local function alldifferent(chars)
  local chartbl = {}
  local l = 0
  for c in string.gmatch(chars, ".") do
    if not chartbl[c] then l = l + 1 end
    chartbl[c] = true
  end
  return l == #chars
end

local function solve1(input)
  for p = 1, #input - 4 do
    local chars = string.sub(input, p, p + 3)
    if alldifferent(chars) then
      return p + 3
    end
  end
end

print("1", solve1(input))

local function solve2(input)
  local l = 14
  for p = 1, #input - l do
    local e = p + l - 1
    local chars = string.sub(input, p, e)
    if alldifferent(chars) then
      return e
    end
  end
end

print("2", solve2(input))

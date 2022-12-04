local aoc = require "aoc"

local function parse(line)
  local a1, b1, a2, b2 = string.match(line, "(%d+)-(%d+),(%d+)-(%d+)")
  return { { tonumber(a1), tonumber(b1) },
           { tonumber(a2), tonumber(b2) } }
end

local input = aoc.parseinput(aoc.readlines("input.txt"), parse)

local function fulloverlap(entry)
  local s1, e1, s2, e2 = entry[1][1], entry[1][2], entry[2][1], entry[2][2]
  return (s1 <= s2 and e1 >= e2) or (s1 >= s2 and e1 <= e2)
end

local function solve1(input)
  local overlapping = 0
  for _, entry in ipairs(input) do
    if fulloverlap(entry) then
      overlapping = overlapping + 1
    end
  end
  return overlapping
end

print("1", solve1(input))

local function overlap(entry)
  local s1, e1, s2, e2 = entry[1][1], entry[1][2], entry[2][1], entry[2][2]
  return not (e1 < s2 or e2 < s1)
end

local function solve2(input)
  local overlapping = 0
  for _, entry in ipairs(input) do
    if overlap(entry) then
      overlapping = overlapping + 1
    end
  end
  return overlapping
end

print("2", solve2(input))

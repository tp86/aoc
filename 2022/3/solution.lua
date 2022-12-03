local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parseentry(line)
  local entry = {}
  entry[1] = line
  local split = #line / 2
  local c1, c2 = line:sub(1, split), line:sub(split + 1, -1)
  entry[2], entry[3] = c1, c2
  entry[4], entry[5] = {}, {}
  for c in c1:gmatch(".") do
    entry[4][c] = (entry[4][c] or 0) + 1
  end
  for c in c2:gmatch(".") do
    entry[5][c] = (entry[5][c] or 0) + 1
  end
  return entry
end

local input = aoc.parseinput(rawinput, parseentry)

local priorities = {
  a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10, k=11, l=12, m=13,
  n=14, o=15, p=16, q=17, r=18, s=19, t=20, u=21, v=22, w=23, x=24, y=25, z=26,
  A=27, B=28, C=29, D=30, E=31, F=32, G=33, H=34, I=35, J=36, K=37, L=38, M=39,
  N=40, O=41, P=42, Q=43, R=44, S=45, T=46, U=47, V=48, W=49, X=50, Y=51, Z=52,
}

local function solve1(input)
  local prio_sum = 0
  for _, entry in ipairs(input) do
    for c in pairs(entry[4]) do
      if entry[5][c] then
        prio_sum = prio_sum + priorities[c]
        break
      end
    end
  end
  return prio_sum
end

print("1", solve1(input))

local function solve2(input)
  local groups_sum = 0
  for g = 1, #input, 3 do
    local e1, e2, e3 = input[g], input[g+1], input[g+2]
    local longest, len = e1, #e1[1]
    if #e2[1] > len then
      longest, len = e2, #e2[1]
    end
    if #e3[1] > len then
      longest, len = e3, #e3[2]
    end
    for c in longest[1]:gmatch(".") do
      if (e1[4][c] or e1[5][c])
      and (e2[4][c] or e2[5][c])
      and (e3[4][c] or e3[5][c]) then
        groups_sum = groups_sum + priorities[c]
        break
      end
    end
  end
  return groups_sum
end

print("2", solve2(input))

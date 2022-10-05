local aoc = require('aoc')

local input = aoc.readlines('input.txt')

print(input[1])

local function parseentry(entry)
  local dimensions = {}
  for n in string.gmatch(entry, '(%d+)') do
    dimensions[#dimensions + 1] = tonumber(n)
  end
  return dimensions
end

local function size1(entry)
  local dims = parseentry(entry)
  local area1, area2, area3 = dims[1] * dims[2], dims[2] * dims[3], dims[3] * dims[1]
  local minarea = math.min(area1, area2, area3)
  return (area1 + area2 + area3) * 2 + minarea
end

local function size2(entry)
  local dims = parseentry(entry)
  local perim1, perim2, perim3, volume = dims[1] + dims[2], dims[2] + dims[3], dims[3] + dims[1], dims[1] * dims[2] *
      dims[3]
  local minperim = math.min(perim1, perim2, perim3)
  return 2 * minperim + volume
end

local function solve(input, func)
  local total = 0
  for _, entry in ipairs(input) do
    total = total + func(entry)
  end
  return total
end

local function solve1(input)
  return solve(input, size1)
end

print(1, solve1(input))

local function solve2(input)
  return solve(input, size2)
end

print(2, solve2(input))

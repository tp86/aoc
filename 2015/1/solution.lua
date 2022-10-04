local function readlines(filename)
  local f = assert(io.open(filename))
  local lines = {}
  for line in f:lines("l") do
    lines[#lines+1] = line
  end
  f:close()
  return lines
end

local input = readlines('input.txt')

local function updatefloor(floor, c)
  if c == '(' then
    return floor + 1
  elseif c == ')' then
    return floor - 1
  end
end

local function solve1(input)
  local floor = 0
  for c in string.gmatch(input, '[%(%)]') do
    floor = updatefloor(floor, c)
  end
  return floor
end

local floor = solve1(input[1])
print('1', floor)

local function solve2(input)
  local floor = 0
  for p = 1, #input do
    local c = input:sub(p, p)
    floor = updatefloor(floor, c)
    if floor < 0 then return p end
  end
  return #input
end

local position = solve2(input[1])
print('2', position)

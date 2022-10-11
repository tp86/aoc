local aoc = require('aoc')

local input = aoc.readlines('input.txt')

local function solve1(input)
  local code, memory = 0, 0
  for _, line in ipairs(input) do
    local decoded = load('return ' .. line)()
    code = code + #line
    memory = memory + #decoded
  end
  return code - memory
end

local function solve2(input)
  local code, encoded = 0, 0
  for _, line in ipairs(input) do
    local encodedstr = string.gsub(line, '[\\"]', '\\%1')
    code = code + #line
    encoded = encoded + #encodedstr + 2
  end
  return encoded - code
end

print('1', solve1(input))
print('2', solve2(input))

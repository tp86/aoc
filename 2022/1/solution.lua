local aoc = require 'aoc'

local rawinput = aoc.readlines("input.txt")

local function parse(input)
  local parsed = { { total = 0 } }
  local elf = 1
  for _, line in ipairs(input) do
    if line == '' then
      elf = elf + 1
      parsed[elf] = { total = 0 }
    else
      local elfcalories = parsed[elf]
      local calories = tonumber(line)
      elfcalories[#elfcalories+1] = calories
      elfcalories.total = elfcalories.total + calories
    end
  end
  return parsed
end

local caloriesbyelf = parse(rawinput)

local function solve1(cbe)
  local max = -math.huge
  for _,elfcalories in ipairs(cbe) do
    local total = elfcalories.total
    if total > max then
      max = total
    end
  end
  return max
end

print("1", solve1(caloriesbyelf))

local function solve2(cbe)
  table.sort(cbe, function(e1, e2) return e1.total > e2.total end)
  return cbe[1].total + cbe[2].total + cbe[3].total
end

print("2", solve2(caloriesbyelf))

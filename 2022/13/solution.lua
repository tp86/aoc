local lpeg = require "lpeg"

local V, P, R, Ct = lpeg.V, lpeg.P, lpeg.R, lpeg.Ct
local match = lpeg.match

local grammar = {
  V"list",
  value = V"list" + V"number",
  number = R"09"^1 / tonumber,
  list = Ct(P"[" * (V"value" * (P"," * V"value")^0)^-1 * P"]"),
}

local function compare(left, right)
  local tl, tr = type(left), type(right)
  if tl == "number" and tr == "number" then
    if left < right then return true
    elseif left > right then return false
    else return nil
    end
  elseif tl == "table" and tr == "table" then
    for i = 1, math.min(#left, #right) do
      local c = compare(left[i], right[i])
      if c then return true
      elseif c == false then return false
      end
    end
    if #left < #right then return true
    elseif #left > #right then return false
    else return nil
    end
  else
    if tl == "number" then return compare({left}, right)
    elseif tr == "number" then return compare(left, {right})
    else print(left) print(right) assert(false, "unreachable ")
    end
  end
end

local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parseinput(input)
  local parsed = {}
  local packets = {}
  for _, line in ipairs(input) do
    if line ~= "" then
      packets[#packets+1] = match(grammar, line)
    else
      parsed[#parsed+1] = packets
      packets = {}
    end
  end
  return parsed
end

local input = parseinput(rawinput)

local function solve1(input)
  local sum = 0
  for index, packets in ipairs(input) do
    local left, right = packets[1], packets[2]
    if compare(left, right) then
      sum = sum + index
    end
  end
  return sum
end

print("1", solve1(input))

local dividers = {
  {{2}},
  {{6}},
}

local function flatten(input)
  local flattened = {}
  for _, pair in ipairs(input) do
    flattened[#flattened+1] = pair[1]
    flattened[#flattened+1] = pair[2]
  end
  return flattened
end

local function solve2(input)
  local packets = flatten(input)
  packets[#packets+1] = dividers[1]
  packets[#packets+1] = dividers[2]
  table.sort(packets, compare)
  local di1, di2
  for index, packet in ipairs(packets) do
    if packet == dividers[1] then
      di1 = index
    elseif packet == dividers[2] then
      di2 = index
    end
  end
  return di1 * di2
end

print("2", solve2(input))

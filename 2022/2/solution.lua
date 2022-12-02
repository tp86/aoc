local aoc = require "aoc"

local rawinput = aoc.readlines "input.txt"

local selections = {
  rock = {
    rock = 1 + 3,
    paper = 1 + 0,
    scissors = 1 + 6,
  },
  paper = {
    rock = 2 + 6,
    paper = 2 + 3,
    scissors = 2 + 0,
  },
  scissors = {
    rock = 3 + 0,
    paper = 3 + 6,
    scissors = 3 + 3,
  },
}

local inputs = {
  A = "rock",
  X = "rock",
  B = "paper",
  Y = "paper",
  C = "scissors",
  Z = "scissors",
}

local function round_score(sel1, sel2)
  return selections[sel2][sel1]
end

local function parseinput1(input)
  local parsed = {}
  for _, line in ipairs(input) do
    local op, pl = string.match(line, '(%u) (%u)')
    parsed[#parsed+1] = { inputs[op], inputs[pl] }
  end
  return parsed
end

local input1 = parseinput1(rawinput)

local function solve(input)
  local total = 0
  for _, scores in ipairs(input) do
    local op, pl = table.unpack(scores)
    total = total + round_score(op, pl)
  end
  return total
end

print('1', solve(input1))

local inputs2 = {
  A = {
    X = "scissors",
    Y = "rock",
    Z = "paper",
  },
  B = {
    X = "rock",
    Y = "paper",
    Z = "scissors",
  },
  C = {
    X = "paper",
    Y = "scissors",
    Z = "rock",
  },
}

local function parseinput2(input)
  local parsed = {}
  for _, line in ipairs(input) do
    local op, res = string.match(line, '(%u) (%u)')
    parsed[#parsed+1] = { inputs[op], inputs2[op][res] }
  end
  return parsed
end

local input2 = parseinput2(rawinput)

print('2', solve(input2))

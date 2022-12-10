local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function noop(state)
  state[#state + 1] = state.X
end

local function addx(state, x)
  state[#state + 1] = state.X
  state[#state + 1] = state.X
  state.X = state.X + x
end

local function parse(line)
  if string.match(line, "noop") then
    return noop
  end
  local x = string.match(line, "addx ([-%d]+)")
  if x then
    return function(s) addx(s, tonumber(x)) end
  end
end

local program = aoc.parseinput(rawinput, parse)

local function strength(state, cycle)
  return cycle * state[cycle]
end

local function solve1()
  local state = { X = 1 }
  for _, instruction in ipairs(program) do
    instruction(state)
  end
  return strength(state, 20) + strength(state, 60) +
      strength(state, 100) + strength(state, 140) +
      strength(state, 180) + strength(state, 220)
end

print("1", solve1())

local function solve2()
  local state = { X = 1 }
  for _, instruction in ipairs(program) do
    instruction(state)
  end
  for cycle = 1, #state do
    local pixel = (cycle - 1) % 40
    local x = state[cycle]
    if math.abs(x - pixel) <= 1 then
      io.write("#")
    else
      io.write(".")
    end
    if cycle % 40 == 0 then
      io.write("\n")
    end
  end
end

print("2")
solve2()

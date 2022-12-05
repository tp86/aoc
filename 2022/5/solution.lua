local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parsestacks(input)
  local stacks = { {}, {}, {}, {}, {}, {}, {}, {}, {} }
  for _, line in ipairs(input) do
    if line == "" then break end
    for pos, m in string.gmatch(line, "()%[(%u)%]") do
      pos = (pos - 1) // 4 + 1
      table.insert(stacks[pos], 1, m)
    end
  end
  return stacks
end

local function parseinstructions(input)
  local instructions = {}
  for _, line in ipairs(input) do
    local quantity, from, to = string.match(line, "move (%d+) from (%d) to (%d)")
    if quantity then
      instructions[#instructions + 1] = { tonumber(quantity), tonumber(from), tonumber(to) }
    end
  end
  return instructions
end

local instructions = parseinstructions(rawinput)

local function move1(stacks, from, to)
  local crate = table.remove(stacks[from])
  table.insert(stacks[to], crate)
end

local function execute1(stacks, instruction)
  local quantity, from, to = table.unpack(instruction)
  for _ = 1, quantity do
    move1(stacks, from, to)
  end
end

local function solve1(stacks)
  for _, instruction in ipairs(instructions) do
    execute1(stacks, instruction)
  end
  local stackstops = {}
  for _, stack in ipairs(stacks) do
    stackstops[#stackstops + 1] = stack[#stack]
  end
  return table.concat(stackstops)
end

print("1", solve1(parsestacks(rawinput)))

local function move2(stacks, quantity, from, to)
  local crates = {}
  for _ = 1, quantity do
    crates[#crates+1] = table.remove(stacks[from])
  end
  for _ = 1, quantity do
    table.insert(stacks[to], table.remove(crates))
  end
end

local function execute2(stacks, instruction)
  local quantity, from, to = table.unpack(instruction)
  move2(stacks, quantity, from, to)
end

local function solve2(stacks)
  for _, instruction in ipairs(instructions) do
    execute2(stacks, instruction)
  end
  local stackstops = {}
  for _, stack in ipairs(stacks) do
    stackstops[#stackstops + 1] = stack[#stack]
  end
  return table.concat(stackstops)
end

print("2", solve2(parsestacks(rawinput)))


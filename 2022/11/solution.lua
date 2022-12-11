local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parsemonkey(lines)
  local i = string.match(lines[1], "Monkey (%d+):")
  local items = string.match(lines[2], "Starting items: ([ %d,]+)")
  local op = string.match(lines[3], "Operation: ([ %w%+%*%=]+)")
  local divisible = string.match(lines[4], "Test: divisible by (%d+)")
  local truecond = string.match(lines[5], "If true: throw to monkey (%d+)")
  local falsecond = string.match(lines[6], "If false: throw to monkey (%d+)")
  i = tonumber(i)
  divisible = tonumber(divisible)
  truecond = tonumber(truecond)
  falsecond = tonumber(falsecond)
  local startingitems = {}
  for item in string.gmatch(items, "%d+") do
    startingitems[#startingitems + 1] = tonumber(item)
  end
  local function buildupdater(op)
    local fn = [[return function(old)
      local new
      ]] ..
        op ..
        [[
      return new
    end]]
    return load(fn)()
  end
  return {
    i = i,
    items = startingitems,
    inspect = function(self)
      self.inspected = (self.inspected or 0) + 1
      local item = table.remove(self.items, 1)
      item = self.updateworry(item)
      item = item // 3
      return item
    end,
    updateworry = buildupdater(op),
    throwto = function(item)
      if item % divisible == 0 then
        return truecond
      else
        return falsecond
      end
    end,
    divisible = divisible,
  }
end

local function parsemonkeys(input)
  local monkeylines = {}
  local monkeys = { n = 0 }
  for _, line in ipairs(input) do
    if line == "" then
      local monkey = parsemonkey(monkeylines)
      monkeylines = {}
      monkeys[monkey.i] = monkey
      monkeys.n = monkeys.n + 1
    else
      monkeylines[#monkeylines + 1] = line
    end
  end
  return monkeys
end

local function turn(monkeys, i)
  local monkey = monkeys[i]
  for _ = 1, #monkey.items do
    local item = monkey:inspect()
    local tomonkey = monkey.throwto(item)
    table.insert(monkeys[tomonkey].items, item)
  end
end

local function round(monkeys)
  for i = 0, monkeys.n - 1 do
    turn(monkeys, i)
  end
end

local function solve1()
  local monkeys = parsemonkeys(rawinput)
  for _ = 1, 20 do
    round(monkeys)
  end
  local inspected = {}
  for i = 0, monkeys.n - 1 do
    inspected[#inspected + 1] = monkeys[i].inspected
  end
  table.sort(inspected, function(i, j) return i > j end)
  return inspected[1] * inspected[2]
end

print("1", solve1())

local function solve2()
  local monkeys = parsemonkeys(rawinput)
  local mod = 1
  for i = 0, monkeys.n - 1 do
    mod = mod * monkeys[i].divisible
  end
  for i = 0, monkeys.n - 1 do
    monkeys[i].inspect = function(self)
      self.inspected = (self.inspected or 0) + 1
      local item = table.remove(self.items, 1)
      item = self.updateworry(item)
      item = item % mod
      return item
    end
  end
  for _ = 1, 10000 do
    round(monkeys)
  end
  local inspected = {}
  for i = 0, monkeys.n - 1 do
    inspected[#inspected + 1] = monkeys[i].inspected
  end
  table.sort(inspected, function(i, j) return i > j end)
  return inspected[1] * inspected[2]
end

print("2", solve2())

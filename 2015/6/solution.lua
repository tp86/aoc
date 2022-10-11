local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local function parseinput(input)
  local patterns = {
    '^turn (on) (%d+),(%d+) through (%d+),(%d+)',
    '^(toggle) (%d+),(%d+) through (%d+),(%d+)',
    '^turn (off) (%d+),(%d+) through (%d+),(%d+)',
  }
  local function parseline(line)
    for _, rule in ipairs(patterns) do
      local match, fromrow, fromcol, torow, tocol = string.match(line, rule)
      if match then
        return match, fromrow, fromcol, torow, tocol
      end
    end
  end

  local parsed = {}
  for _, line in ipairs(input) do
    parsed[#parsed + 1] = table.pack(parseline(line))
  end
  return parsed
end

local input = parseinput(rawinput)

local rules = {
  {
    ['on'] = function() return 1 end,
    ['off'] = function() return 0 end,
    ['toggle'] = function(v) if v == 0 then return 1 elseif v == 1 then return 0 else return v end end,
  },
  {
    ['on'] = function(v) return v + 1 end,
    ['off'] = function(v) return math.max(v - 1, 0) end,
    ['toggle'] = function(v) return v + 2 end,
  }
}

local minidx, maxidx = 0, 999

local function newgrid()
  local grid = {}
  for row = minidx, maxidx do
    grid[row] = {}
    for col = minidx, maxidx do
      grid[row][col] = 0
    end
  end
  return grid
end

local function run(input, grid, part)
  for _, instruction in ipairs(input) do
    local rule, fromrow, fromcol, torow, tocol = table.unpack(instruction)
    for row = fromrow, torow do
      for col = fromcol, tocol do
        grid[row][col] = rules[part][rule](grid[row][col])
      end
    end
  end
end

local function solve(input, part)
  local grid = newgrid()
  run(input, grid, part)
  local total = 0
  for row = minidx, maxidx do
    for col = minidx, maxidx do
      total = total + grid[row][col]
    end
  end
  return total
end

print('1', solve(input, 1))
print('2', solve(input, 2))

local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local function up(x, y)
  return x, y + 1
end
local function down(x, y)
  return x, y - 1
end
local function left(x, y)
  return x - 1, y
end
local function right(x, y)
  return x + 1, y
end

local function parse(input)
  local parsed = {}
  for c in string.gmatch(input, '.') do
    if c == '<' then
      parsed[#parsed+1] = left
    elseif c == '>' then
      parsed[#parsed+1] = right
    elseif c == '^' then
      parsed[#parsed+1] = up
    elseif c == 'v' then
      parsed[#parsed+1] = down
    end
  end
  return parsed
end

local input = parse(rawinput[1])

local startx, starty = 0, 0

local function traverse1(grid, dirs)
  local x, y = startx, starty
  for _, dir in ipairs(dirs) do
    x, y = dir(x, y)
    if not grid[x] then grid[x] = {} end
    grid[x][y] = (grid[x][y] or 0) + 1
  end
  return grid
end

local function traverse2(grid, dirs)
  local x, y = startx, starty
  local ox, oy = startx, starty
  for _, dir in ipairs(dirs) do
    x, y = dir(x, y)
    if not grid[x] then grid[x] = {} end
    grid[x][y] = (grid[x][y] or 0) + 1
    x, y, ox, oy = ox, oy, x, y
  end
  return grid
end

local function solve(grid, fn)
  local grid = fn(grid, input)
  local visited = 0
  for _, cols in pairs(grid) do
    for _ in pairs(cols) do
      visited = visited + 1
    end
  end
  return visited
end

print(1, solve({[startx] = {[starty] = 1}}, traverse1))
print(2, solve({[startx] = {[starty] = 1}}, traverse2))

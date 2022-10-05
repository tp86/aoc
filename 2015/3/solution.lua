local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local function up(pos)
  return { pos[1], pos[2] + 1 }
end
local function down(pos)
  return { pos[1], pos[2] - 1 }
end
local function left(pos)
  return { pos[1] - 1, pos[2] }
end
local function right(pos)
  return { pos[1] + 1, pos[2] }
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

local function traverse(grid, dirs)
  local pos = { startx, starty }
  for _, dir in ipairs(dirs) do
    pos = dir(pos)
    local x, y = pos[1], pos[2]
    if not grid[x] then grid[x] = {} end
    grid[x][y] = (grid[x][y] or 0) + 1
  end
  return grid
end

local grid = traverse({ [startx] = { [starty] = 1 } }, input)

local function solve1(grid)
  local visited = 0
  for _, cols in pairs(grid) do
    for _ in pairs(cols) do
      visited = visited + 1
    end
  end
  return visited
end

print(1, solve1(grid))

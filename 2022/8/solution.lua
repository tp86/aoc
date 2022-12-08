local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parseinput(input)
  local grid = {}
  for i, line in ipairs(input) do
    if line ~= "" then
      grid[i] = {}
      for c, height in string.gmatch(line, "()(%d)") do
        grid[i][c] = tonumber(height)
      end
    end
  end
  return grid
end

local grid = parseinput(rawinput)

local function isvisible(grid, row, col)
  local height = grid[row][col]
  -- visible from top?
  for r = 1, row - 1 do
    local other = grid[r][col]
    if other >= height then
      goto top
    end
  end
  do
    return true
  end
  ::top::
  -- visible from right?
  for c = col + 1, #grid[1] do
    local other = grid[row][c]
    if other >= height then
      goto right
    end
  end
  do
    return true
  end
  ::right::
  -- visible from bottom?
  for r = row + 1, #grid do
    local other = grid[r][col]
    if other >= height then
      goto bottom
    end
  end
  do
    return true
  end
  ::bottom::
  -- visible from left?
  for c = 1, col - 1 do
    local other = grid[row][c]
    if other >= height then
      goto left
    end
  end
  do
    return true
  end
  ::left::
  return false
end

local function solve1(grid)
  local visible = 0
  for r = 1, #grid do
    for c = 1, #grid[1] do
      if isvisible(grid, r, c) then
        visible = visible + 1
      end
    end
  end
  return visible
end

--[[
grid = {
  {3, 0, 3, 7, 3},
  {2, 5,5, 1, 2},
  {6,5,3,3,2},
  {3,3,5,4,9},
  {3,5,3,9,0},
}
--]]

print("1", solve1(grid))

local function scenicscore(grid, row, col)
  if row == 1 or row == #grid or col == 1 or col == #grid[1] then return 0 end
  local height = grid[row][col]
  local score = 1
  -- score from top
  for r = row - 1, 1, -1 do
    local other = grid[r][col]
    if other >= height then
      score = score * (row - r)
      goto top
    end
  end
  score = score * (row - 1)
  ::top::
  -- score from right
  for c = col + 1, #grid[1] do
    local other = grid[row][c]
    if other >= height then
      score = score * (c - col)
      goto right
    end
  end
  score = score * (#grid[1] - col)
  ::right::
  -- score from bottom
  for r = row + 1, #grid do
    local other = grid[r][col]
    if other >= height then
      score = score * (r - row)
      goto bottom
    end
  end
  score = score * (#grid - row)
  ::bottom::
  -- score from left
  for c = col - 1, 1, -1 do
    local other = grid[row][c]
    if other >= height then
      score = score * (col - c)
      goto left
    end
  end
  score = score * (col - 1)
  ::left::
  return score
end

local function solve2(grid)
  local max = -math.huge
  for r = 1, #grid do
    for c = 1, #grid[1] do
      local score = scenicscore(grid, r, c)
      if score > max then
        max = score
      end
    end
  end
  return max
end

print("2", solve2(grid))

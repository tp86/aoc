local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parsepath(line)
  local path = {}
  for x, y in string.gmatch(line, "(%d+),(%d+)") do
    path[#path + 1] = { tonumber(x), tonumber(y) }
  end
  return path
end

local function makegrid(input)
  local grid = {}
  local minrow, mincol = math.huge, math.huge
  local maxrow, maxcol = -math.huge, -math.huge
  for _, path in ipairs(input) do
    for beginidx = 1, #path - 1 do
      local b, e = path[beginidx], path[beginidx + 1]
      local bx, by = table.unpack(b)
      local ex, ey = table.unpack(e)
      if bx == ex then
        local x = bx
        if not grid[x] then grid[x] = {} end
        local from, to = math.min(by, ey), math.max(by, ey)
        for y = from, to do
          grid[x][y] = "#"
        end
      elseif by == ey then
        local y = by
        local from, to = math.min(bx, ex), math.max(bx, ex)
        for x = from, to do
          if not grid[x] then grid[x] = {} end
          grid[x][y] = "#"
        end
      else
        assert(false, "should not be reached")
      end
      if minrow > math.min(bx, ex) then
        minrow = math.min(bx, ex)
      end
      if maxrow < math.max(bx, ex) then
        maxrow = math.max(bx, ex)
      end
      if mincol > math.min(by, ey) then
        mincol = math.min(by, ey)
      end
      if maxcol < math.max(by, ey) then
        maxcol = math.max(by, ey)
      end
    end
  end
  return grid, minrow, mincol, maxrow, maxcol
end

--[[
rawinput = {
  "498,4 -> 498,6 -> 496,6",
  "503,4 -> 502,4 -> 502,9 -> 494,9",
}
]]
local input = aoc.parseinput(rawinput, parsepath)
local grid, minrow, mincol, maxrow, maxcol = makegrid(input)

--[[
local function printgrid(grid, minrow, mincol, maxrow, maxcol)
  for col = 0, maxcol do
    for row = minrow, maxrow do
      if col == 0 and row == 500 then io.write("+")
      else io.write((grid[row] or {})[col] or ".")
      end
    end
    io.write("\n")
  end
end
printgrid(grid, minrow, mincol, maxrow, maxcol)
]]

local function nextsandpos(grid, x, y)
  local ny = y + 1
  -- check down
  if not (grid[x] or {})[ny] then return x, ny
    -- check down-left
  elseif not (grid[x - 1] or {})[ny] then return x - 1, ny
    -- check down-right
  elseif not (grid[x + 1] or {})[ny] then return x + 1, ny
  else return x, y
  end
end

local function dropsand(grid, restfn, fallfn)
  local x, y = 500, 0
  while true do
    local nx, ny = nextsandpos(grid, x, y)
    if fallfn(ny) then
      return true
    end
    if restfn(ny, y) then
      if not grid[x] then grid[x] = {} end
      grid[x][y] = "o"
      return
    end
    x, y = nx, ny
  end
end

local function solve1(input)
  local grid, _, _, _, maxcol = makegrid(input)
  local rounds = 0
  repeat
    local stop = dropsand(grid, function(ny, y) return ny == y end,
      function(y) return y > maxcol end)
    rounds = rounds + 1
  until stop
  return rounds - 1
end

print("1", solve1(input))

local function solve2(input)
  local grid, _, _, _, maxcol = makegrid(input)
  local rounds = 0
  repeat
    local stop = dropsand(grid, function(ny, y) return ny == y or ny == maxcol + 2 end,
      function(y) return y == 0 end)
    rounds = rounds + 1
  until stop
  return rounds
end

print("2", solve2(input))

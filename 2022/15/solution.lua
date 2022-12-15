local sampleinput = {
  "Sensor at x=2, y=18: closest beacon is at x=-2, y=15",
  "Sensor at x=9, y=16: closest beacon is at x=10, y=16",
  "Sensor at x=13, y=2: closest beacon is at x=15, y=3",
  "Sensor at x=12, y=14: closest beacon is at x=10, y=16",
  "Sensor at x=10, y=20: closest beacon is at x=10, y=16",
  "Sensor at x=14, y=17: closest beacon is at x=10, y=16",
  "Sensor at x=8, y=7: closest beacon is at x=2, y=10",
  "Sensor at x=2, y=0: closest beacon is at x=2, y=10",
  "Sensor at x=0, y=11: closest beacon is at x=2, y=10",
  "Sensor at x=20, y=14: closest beacon is at x=25, y=17",
  "Sensor at x=17, y=20: closest beacon is at x=21, y=22",
  "Sensor at x=16, y=7: closest beacon is at x=15, y=3",
  "Sensor at x=14, y=3: closest beacon is at x=15, y=3",
  "Sensor at x=20, y=1: closest beacon is at x=15, y=3",
}

local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parseline(line)
  local intpat = "[-%d]+"
  local sx, sy, bx, by = string.match(line, ".*x=(" .. intpat ..
    "), y=(" .. intpat .. ").*x=(" .. intpat .. "), y=(" .. intpat .. ")")
  sx, sy, bx, by = tonumber(sx), tonumber(sy), tonumber(bx), tonumber(by)
  return { sensor = { sx, sy }, beacon = { bx, by } }
end

local sample = aoc.parseinput(sampleinput, parseline)
local input = aoc.parseinput(rawinput, parseline)

local abs, min, max = math.abs, math.min, math.max

local function manhattandistance(p1, p2)
  local x1, y1 = table.unpack(p1)
  local x2, y2 = table.unpack(p2)
  return abs(x1 - x2) + abs(y1 - y2)
end

local function makegrid()
  local grid = setmetatable({}, {
    __index = function(t, k) if not rawget(t, k) then
        local subt = {}
        t[k] = subt
        return subt
      end
    end
  })
  return grid
end

local function fillsensorfield(grid, reading, row)
  local sx, sy = table.unpack(reading.sensor)
  local dist = manhattandistance(reading.sensor, reading.beacon)
  if row >= sy - dist and row <= sy + dist then
    local yd = abs(row - sy)
    local xmin, xmax = sx - dist + yd, sx + dist - yd
    for x = xmin, xmax do
      if not grid[x][row] then
        grid[x][row] = "#"
      end
    end
    return xmin, xmax
  end
end

local function placereading(grid, reading, row)
  local sx, sy = table.unpack(reading.sensor)
  local bx, by = table.unpack(reading.beacon)
  grid[sx][sy] = "S"
  grid[bx][by] = "B"
  return fillsensorfield(grid, reading, row)
end

local function solve1(input, row)
  local sum = 0
  local grid = makegrid()
  local xmin, xmax = math.huge, -math.huge
  for _, reading in ipairs(input) do
    local sxmin, sxmax = placereading(grid, reading, row)
    if sxmin then
      xmin = min(xmin, sxmin)
      xmax = max(xmax, sxmax)
    end
  end
  for x = xmin, xmax do
    local v = grid[x][row]
    if v == "S" or v == "#" then sum = sum + 1 end
  end
  return sum
end

print("1", solve1(input, 2e6))

local cmin, cmax = 0, 4e6

local function tuningfreq(x, y)
  return x * 4e6 + y
end

local function checky(reading, x, y)
  local sx, sy = table.unpack(reading.sensor)
  local dist = reading.dist
  local xd = abs(x - sx)
  local ymin, ymax = sy - dist + xd, sy + dist - xd
  local ny
  if y < ymin - 1 or y >= ymax then
    ny = y + 1
  else
    ny = ymax + 1
  end
  if y < ymin or y > ymax then
    return ny, true
  else
    return ny, false
  end
end

local function solve2(input)
  local bx, by
  for _, reading in ipairs(input) do
    reading.dist = manhattandistance(reading.sensor, reading.beacon)
  end
  for x = cmin, cmax do
    local y = cmin
    repeat
      local ny = -math.huge
      local found = true
      for _, reading in ipairs(input) do
        local n, f = checky(reading, x, y)
        ny = math.max(n, ny)
        found = found and f
      end
      if found then
        bx, by = x, y
        goto out
      else
        y = ny
      end
    until ny > cmax
  end
  ::out::
  return tuningfreq(bx, by)
end

print("2", solve2(input))

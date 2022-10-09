local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local grid = {}
for r = 0,999 do
  grid[r] = {}
  for c = 0,999 do
    grid[r][c] = false
  end
end
local function update(fromr, fromc, tor, toc, fn)
  for r = fromr,tor do
    for c = fromc,toc do
      grid[r][c] = fn(grid[r][c])
    end
  end
end
local function turnon(fromr, fromc, tor, toc)
  update(fromr, fromc, tor, toc, function() return true end)
end
local function turnoff(fromr, fromc, tor, toc)
  update(fromr, fromc, tor, toc, function() return false end)
end
local function toggle(fromr, fromc, tor, toc)
  update(fromr, fromc, tor, toc, function(v) return not v end)
end

local onpat = '^turn (on) (%d+),(%d+) through (%d+),(%d+)'
local offpat = '^turn (off) (%d+),(%d+) through (%d+),(%d+)'
local togglepat = '^(toggle) (%d+),(%d+) through (%d+),(%d+)'
local function parseentry(line)
  local action,fromr,fromc,tor,toc = string.match(line, onpat)
  if action then return function() turnon(fromr, fromc, tor, toc) end end
  action,fromr,fromc,tor,toc = string.match(line, offpat)
  if action then return function() turnoff(fromr, fromc, tor, toc) end end
  action,fromr,fromc,tor,toc = string.match(line, togglepat)
  if action then return function() toggle(fromr, fromc, tor, toc) end end
end

local input = {}
for _,line in ipairs(rawinput) do
  input[#input+1] = parseentry(line)
end

local function solve(input)
  for _, instruction in ipairs(input) do
    instruction()
  end
  local lit = 0
  for _, row in ipairs(grid) do
    for _, light in ipairs(row) do
      if light then lit = lit + 1 end
    end
  end
  return lit
end

print('1', solve(input))

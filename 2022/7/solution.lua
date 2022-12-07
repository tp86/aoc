local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function cd(dirtree)
  local dir = dirtree
  for _, d in ipairs(dirtree.path) do
    if not dir[d] then dir[d] = {} end
    dir = dir[d]
    dirtree.dir = dir
  end
end

local function parseline(dirtree, line)
  local cddir = string.match(line, "%$ cd ([%w/.]+)")
  if cddir then
    if cddir == "/" then
      dirtree.path = { "/" }
    elseif cddir == ".." then
      table.remove(dirtree.path)
    else
      table.insert(dirtree.path, cddir)
    end
    cd(dirtree)
    return
  end
  if string.match(line, "%$ ls") then return end
  if string.match(line, "dir (%w+)") then return end
  local size, name = string.match(line, "(%d+) ([%w%.]+)")
  if size then
    print(name, size)
    dirtree.dir[name] = size
  end
end

local function parse(input)
  local dirtree = {}
  for _, line in ipairs(input) do
    parseline(dirtree, line)
  end
  return dirtree
end

--[[
local sampleinput = {
"$ cd /",
"$ ls",
"dir a",
"14848514 b.txt",
"8504156 c.dat",
"dir d",
"$ cd a",
"$ ls",
"dir e",
"29116 f",
"2557 g",
"62596 h.lst",
"$ cd e",
"$ ls",
"584 i",
"$ cd ..",
"$ cd ..",
"$ cd d",
"$ ls",
"4060174 j",
"8033020 d.log",
"5626152 d.ext",
"7214296 k",
}
--]]

local dirtree = parse(rawinput)

local function dirtotal(dir, path, totals)
  local total = 0
  for name, size in pairs(dir) do
    if type(size) == "table" then
      path = path .. "/" .. name
      totals[path] = dirtotal(dir[name], path, totals)
      total = total + totals[path]
    else
      total = total + size
    end
  end
  return total
end

local function calculatetotals(dirtree)
  local totals = {}
  totals["/"] = dirtotal(dirtree["/"], "", totals)
  return totals
end

local totals = calculatetotals(dirtree)

local function solve1(totals)
  local sum = 0
  for _, total in pairs(totals) do
    if total <= 100000 then
      sum = sum + total
    end
  end
  return sum
end

print("1", solve1(totals))

local spaceneeded = 30000000

local freespace = 70000000 - totals["/"]

local minsizetoremove = spaceneeded - freespace

local function solve2(totals)
  local size = math.huge
  for _, total in pairs(totals) do
    if total >= minsizetoremove and total < size then
      print(_, total)
      size = total
    end
  end
  return size
end

print("2", solve2(totals))

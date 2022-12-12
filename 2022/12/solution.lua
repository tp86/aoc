local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parseinput(input)
  local grid = {}
  local offset = string.byte("a")
  local s = {}
  local e = {}
  for r, line in ipairs(input) do
    if line ~= "" then
      grid[r] = {}
      for c, elevation in string.gmatch(line, "()(.)") do
        if elevation == "S" then
          s = { r, c }
          grid[r][c] = string.byte("a") - offset
        elseif elevation == "E" then
          e = { r, c }
          grid[r][c] = string.byte("z") - offset
        else
          grid[r][c] = string.byte(elevation) - offset
        end
      end
    end
  end
  return grid, s, e
end

local grid, S, E = parseinput(rawinput)

local function possiblemoves(grid, pos)
  local nextposcandidates = {}
  local posr, posc = table.unpack(pos)
  local currentelevation = grid[posr][posc]
  -- up?
  if posr > 1 then
    nextposcandidates[#nextposcandidates + 1] = { posr - 1, posc }
  end
  -- down?
  if posr < #grid then
    nextposcandidates[#nextposcandidates + 1] = { posr + 1, posc }
  end
  -- left?
  if posc > 1 then
    nextposcandidates[#nextposcandidates + 1] = { posr, posc - 1 }
  end
  -- right?
  if posc < #grid[1] then
    nextposcandidates[#nextposcandidates + 1] = { posr, posc + 1 }
  end

  local nextpos = {}

  for _, candidate in ipairs(nextposcandidates) do
    local cr, cc = table.unpack(candidate)
    if grid[cr][cc] <= currentelevation + 1 then
      nextpos[#nextpos + 1] = candidate
    end
  end

  return nextpos
end

local function solve1(grid, S, E)
  local paths = {}
  local queue = { { S } }
  local visited = { [S[1] .. "," .. S[2]] = true }

  while #queue > 0 do
    local currentpath = table.remove(queue, 1)
    local currentpos = currentpath[#currentpath]
    local nextpos = possiblemoves(grid, currentpos)
    for _, pos in ipairs(nextpos) do
      if visited[pos[1] .. "," .. pos[2]] then goto continue end
      -- check if we reached the end
      local path = {}
      for i, p in ipairs(currentpath) do
        path[i] = p
      end
      path[#path + 1] = pos
      if pos[1] == E[1] and pos[2] == E[2] then
        paths[#paths + 1] = path
      end
      visited[pos[1] .. "," .. pos[2]] = true
      queue[#queue + 1] = path
      ::continue::
    end
  end

  local minlen = math.huge
  for _, path in ipairs(paths) do
    if #path < minlen then
      minlen = #path
    end
  end
  return minlen - 1
end

print("1", solve1(grid, S, E))

local function solve2(grid, E)
  local starts = {}
  for r, row in ipairs(grid) do
    for c, elevation in ipairs(row) do
      if elevation == 0 then
        starts[#starts + 1] = { r, c }
      end
    end
  end
  local paths = {}
  for _, start in ipairs(starts) do
    paths[#paths + 1] = solve1(grid, start, E)
  end
  local minlen = math.huge
  for _, p in ipairs(paths) do
    if p < minlen then
      minlen = p
    end
  end
  return minlen
end

print("2", solve2(grid, E))

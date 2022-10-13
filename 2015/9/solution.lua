local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local function parseline(line)
  return table.pack(string.match(line, '^(%w+) to (%w+) = (%d+)'))
end

local input = aoc.parseinput(rawinput, parseline)

local function permutations(t)
  local function permgen(t, n)
    n = n or 1
    if n >= #t then
      coroutine.yield(t)
    else
      for i = n, #t do
        t[n], t[i] = t[i], t[n]
        permgen(t, n + 1)
        t[n], t[i] = t[i], t[n]
      end
    end
  end

  return coroutine.wrap(function() permgen(t) end)
end

local function finddist(input, settings)
  local locations = {}
  for _, entry in ipairs(input) do
    locations[entry[1]] = true
    locations[entry[2]] = true
  end
  local locationlist = {}
  for loc in pairs(locations) do
    locationlist[#locationlist+1] = loc
  end
  local dist = settings.initial
  for route in permutations(locationlist) do
    local routedist = 0
    for i = 2, #route do
      local loc1, loc2 = route[i - 1], route[i]
      local d
      for _, entry in ipairs(input) do
        if (entry[1] == loc1 and entry[2] == loc2)
        or (entry[2] == loc1 and entry[1] == loc2) then
          d = entry[3]
        end
      end
      routedist = routedist + d
    end
    if settings.cmp(routedist, dist) then dist = routedist end
  end
  return dist
end

print('1', finddist(input, { initial = math.huge, cmp = function(x, y) return x < y end } ))
print('2', finddist(input, { initial = -math.huge, cmp = function(x, y) return x > y end } ))

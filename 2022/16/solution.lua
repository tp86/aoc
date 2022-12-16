local sampleinput = {
  "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB",
  "Valve BB has flow rate=13; tunnels lead to valves CC, AA",
  "Valve CC has flow rate=2; tunnels lead to valves DD, BB",
  "Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE",
  "Valve EE has flow rate=3; tunnels lead to valves FF, DD",
  "Valve FF has flow rate=0; tunnels lead to valves EE, GG",
  "Valve GG has flow rate=0; tunnels lead to valves FF, HH",
  "Valve HH has flow rate=22; tunnel leads to valve GG",
  "Valve II has flow rate=0; tunnels lead to valves AA, JJ",
  "Valve JJ has flow rate=21; tunnel leads to valve II",
}

local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function parsevalve(line)
  local label, rate, connected = string.match(line, "Valve (%u+) has flow rate=(%d+); tunnels? leads? to valves? (.*)")
  rate = tonumber(rate)
  local connectedvalves = {}
  for v in string.gmatch(connected, "(%u+)") do
    connectedvalves[#connectedvalves + 1] = { label = v, weight = 1 }
  end
  return {
    label = label,
    rate = rate,
    connected = connectedvalves,
  }
end

local function parseinput(input)
  local valves = {}
  for _, line in ipairs(input) do
    if line ~= "" then
      local valve = parsevalve(line)
      valves[valve.label] = {
        label = valve.label,
        rate = valve.rate,
        connected = valve.connected,
      }
    end
  end
  for _, valve in pairs(valves) do
    for i, conn in ipairs(valve.connected) do
      valve.connected[valves[conn.label]] = conn.weight
      valve.connected[i] = nil
    end
  end
  return valves
end

local sample = parseinput(sampleinput)
local input = parseinput(rawinput)

local lencache = {}

local function pathlen(from, to)
  local function findpathlen(from, to, path, len)
    if from == to then
      return len
    end
    local paths = {}
    for valve, weight in pairs(from.connected) do
      for _, p in ipairs(path) do
        if p == valve then goto continue end
      end
      local len = len + weight
      if valve == to then
        return len
      end
      paths[#paths + 1] = findpathlen(valve, to, { valve, table.unpack(path) }, len)
      ::continue::
    end
    table.sort(paths)
    local minpath = paths[1]
    return minpath
  end

  local len = (lencache[from] or {})[to]

  if not len then
    print("calculating path for " .. from.label .. " " .. to.label)
    len = findpathlen(from, to, {from}, 0)
    if not lencache[from] then lencache[from] = {} end
    lencache[from][to] = len
    if not lencache[to] then lencache[to] = {} end
    lencache[to][from] = len
  end

  return len
end

local function permutations(t, l, cb)
  local perms = {}
  local function permute(t, n)
    if n == 0 then
      cb(t)
    else
      for i = 1, n do
        t[i], t[n] = t[n], t[i]
        permute(t, n - 1)
        t[i], t[n] = t[n], t[i]
      end
    end
  end

  permute(t, l)
  return perms
end

local prefixcache = {}

local function calculatepressurefororder(from, valves)
  local label = ""
  for _, valve in ipairs(valves) do
    label = label .. " " .. valve.label
  end
  for prefix, released in pairs(prefixcache) do
    if string.find(label, prefix) == 1 then
      --print("found", label, prefix, released)
      return released
    end
  end
  local minutesleft = 30
  local released = 0
  for i, valve in ipairs(valves) do
    minutesleft = minutesleft - (pathlen(from, valve) + 1)
    if minutesleft <= 0 then
      local prefix = ""
      for j = 1, i - 1 do
        prefix = prefix .. " " .. valves[j].label
      end
      --print("recording", prefix, released)
      prefixcache[prefix] = released
      break
    end
    released = released + minutesleft * valve.rate
    from = valve
  end
  for _, valve in ipairs(valves) do
    io.write(valve.label .. " ")
  end
  io.write(released .. "\n")
  io.flush()
  return released
end

local function solve1(valves)
  local nonzeroratevalves = {}
  for _, valve in pairs(valves) do
    if valve.rate > 0 then
      nonzeroratevalves[#nonzeroratevalves + 1] = valve
    end
  end
  local len = #nonzeroratevalves

  local maxpressurereleased = -math.huge
  local function getpressure(order)
    local released = calculatepressurefororder(valves["AA"], order)
    if maxpressurereleased < released then
      maxpressurereleased = released
    end
  end
  permutations(nonzeroratevalves, len, getpressure)

  return maxpressurereleased
end

print("1", solve1(input))

--[[
for label, valve in pairs(sample) do
  print(label)
  for k, v in pairs(valve) do
    if k == "connected" then
      print(k)
      for cv, w in pairs(v) do
        print("  ", cv.label, w)
      end
    else
      print(k, v)
    end
  end
  print()
end
]]

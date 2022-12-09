local aoc = require "aoc"

local rawinput = aoc.readlines("input.txt")

local function moveby(pos, diff)
  return { x = pos.x + diff.x, y = pos.y + diff.y }
end

local function moveright(pos)
  return moveby(pos, { x = 1, y = 0 })
end

local function moveleft(pos)
  return moveby(pos, { x = -1, y = 0 })
end

local function moveup(pos)
  return moveby(pos, { x = 0, y = 1 })
end

local function movedown(pos)
  return moveby(pos, { x = 0, y = -1 })
end

local function parsemove(line)
  local dir, count = string.match(line, "(%u) (%d+)")
  local movefn
  if dir == "R" then
    movefn = moveright
  elseif dir == "L" then
    movefn = moveleft
  elseif dir == "U" then
    movefn = moveup
  elseif dir == "D" then
    movefn = movedown
  else
    assert(nil, "wrong direction: " .. dir)
  end
  return { move = movefn, n = tonumber(count) }
end

local moves = aoc.parseinput(rawinput, parsemove)

--[[
moves = aoc.parseinput({
  "R 4",
  "U 4",
  "L 3",
  "D 1",
  "R 4",
  "D 1",
  "L 5",
  "R 2",
}, parsemove)
--]]

local function calculateadjustment(pos1, pos2)
  local xdiff = pos1.x - pos2.x
  local ydiff = pos1.y - pos2.y
  local xlen = math.abs(xdiff)
  local ylen = math.abs(ydiff)
  local adjustment = { x = 0, y = 0 }
  if xlen > 1 or ylen > 1 then
    adjustment.x = xdiff // (xlen == 0 and 1 or xlen)
    adjustment.y = ydiff // (ylen == 0 and 1 or ylen)
  end
  return adjustment
end

local function recordtailpos(tail, tailpositions)
  local tailpos = tail.x .. "," .. tail.y
  local tailnvisited = tailpositions[tailpos] or 0
  tailpositions[tailpos] = tailnvisited + 1
end

local function updatetail(head, tail, tailpositions)
  local adjustment = calculateadjustment(head, tail)
  local newtail = moveby(tail, adjustment)
  tail.x, tail.y = newtail.x, newtail.y
  recordtailpos(tail, tailpositions)
end

local function solve1(moves)
  local tailpositions = {}
  local head = { x = 0, y = 0 }
  local tail = { x = 0, y = 0 }

  for _, move in ipairs(moves) do
    local move, n = move.move, move.n
    for _ = 1, n do
      head = move(head)
      updatetail(head, tail, tailpositions)
    end
  end

  local n = 0
  for _ in pairs(tailpositions) do
    n = n + 1
  end
  return n
end

print("1", solve1(moves))

local function updaterope(rope, move, tailpositions)
  rope[1] = move(rope[1])
  for i = 2, #rope do
    local knot = rope[i]
    local previousknot = rope[i - 1]
    local adjustment = calculateadjustment(previousknot, knot)
    local newknotpos = moveby(knot, adjustment)
    knot.x, knot.y = newknotpos.x, newknotpos.y
  end
  recordtailpos(rope[#rope], tailpositions)
end

local function solve2(moves)
  local tailpositions = {}
  local rope = {}
  for i = 1, 10 do
    rope[i] = { x = 0, y = 0 }
  end

  for _, move in ipairs(moves) do
    local move, n = move.move, move.n
    for _ = 1, n do
      updaterope(rope, move, tailpositions)
    end
  end

  local n = 0
  for _ in pairs(tailpositions) do
    n = n + 1
  end
  return n
end

print("2", solve2(moves))

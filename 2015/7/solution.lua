local aoc = require('aoc')

local rawinput = aoc.readlines('input.txt')

local patterns = {
  '^(%w+)()() %-> (%l+)',
  '^(%w+) (AND) (%w+) %-> (%l+)',
  '^(%w+) (OR) (%w+) %-> (%l+)',
  '^(%w+) (LSHIFT) (%w+) %-> (%l+)',
  '^(%w+) (RSHIFT) (%w+) %-> (%l+)',
  '^()(NOT) (%w+) %-> (%l+)',
}
local function parseline(line)
  for _, pattern in ipairs(patterns) do
    local src1, op, src2, dest = string.match(line, pattern)
    if src1 then
      if type(op) == 'number' then op = nil end
      if type(src1) == 'number' then src1 = nil end
      if type(src2) == 'number' then src2 = nil end
      return { op, src1, src2, dest }
    end
  end
end

local input = aoc.parseinput(rawinput, parseline)

local mod = 65536

local function run(instructions, wires)
  local changed = false
  repeat
    changed = false
    for _, instruction in ipairs(instructions) do
      local op, src1, src2, dest = table.unpack(instruction)
      if not wires[dest] then
        local s1, s2 = tonumber(src1) or wires[src1], tonumber(src2) or wires[src2]
        if not op and s1 then
          wires[dest] = s1
          changed = true
        elseif op == 'NOT' and s2 then
          wires[dest] = ~s2 % mod
          changed = true
        elseif op == 'AND' and s1 and s2 then
          wires[dest] = (s1 & s2) % mod
          changed = true
        elseif op == 'OR' and s1 and s2 then
          wires[dest] = (s1 | s2) % mod
          changed = true
        elseif op == 'LSHIFT' and s1 and s2 then
          wires[dest] = (s1 << s2) % mod
          changed = true
        elseif op == 'RSHIFT' and s1 and s2 then
          wires[dest] = (s1 >> s2) % mod
          changed = true
        end
      end
    end
  until not changed
end

local function solve(instructions, wires)
  wires = wires or {}
  run(instructions, wires)
  return wires['a']
end

local a = solve(input)
print('1', a)
print('2', solve(input, { b = a }))

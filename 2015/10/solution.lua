local input = '3113322113'

local function lookandsay(s)
  local ns = {}
  local from, to = 1, 1
  local d = s:sub(from, to)
  while true do
    from, to = s:find(d .. '*', to)
    if not from then break end
    to = to + 1
    ns[#ns + 1] = to - from
    ns[#ns + 1] = d
    d = s:sub(to, to)
  end
  return table.concat(ns)
end

local function apply(input, n)
  local las = input
  for _ = 1, n do
    las = lookandsay(las)
  end
  return las
end

local input40 = apply(input, 40)
print('1', #input40)
local input50 = apply(input40, 10)
print('2', #input50)

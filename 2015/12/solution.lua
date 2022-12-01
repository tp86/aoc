local aoc = require('aoc')
local lpeg = require("lpeg")
local P, R, C, V, Ct = lpeg.P, lpeg.R, lpeg.C, lpeg.V, lpeg.Ct
lpeg.locale(lpeg)
local alpha = lpeg.alpha

local grammar1 = {
  V'array' + V'object',
  number = C(P"-"^-1 * R"09"^1) / tonumber,
  string = P'"' * C(alpha^1) * P'"',
  element = V'number' + V'string' + V'array' + V'object',
  array = Ct(P"[" * (V'element' * (P"," * V'element')^0)^-1 * P"]"),
  key = V'string',
  pair = V'key' / 0 * ":" * V'element',
  object = P"{" * Ct((V'pair' * (P"," * V'pair')^0)^-1) * P"}"
}

local function flatten(elem, result)
  result = result or {}
  if type(elem) == "table" then
    for _, v in ipairs(elem) do
      flatten(v, result)
    end
  else
    result[#result+1] = elem
  end
  return result
end
local function filter(t, f)
  local filtered = {}
  for _, v in ipairs(t) do
    if f(v) then
      filtered[#filtered+1] = v
    end
  end
  return filtered
end
local function sum(t)
  local total = 0
  for _, v in ipairs(t) do
    total = total + v
  end
  return total
end
local function pipe(v, ...)
  local result = v
  for _, f in ipairs{...} do
    result = f(result)
  end
  return result
end
local input = aoc.readlines("input.txt")[1]
local match = lpeg.match(grammar1, input)
print('1', pipe(match,
                flatten,
                function(v) return filter(v, function(v) return type(v) == "number" end) end,
                sum))
local grammar2 = grammar1
grammar2.object = grammar1.object / function(t) if #filter(t, function(v) return v == "red" end) > 0 then return 0 else return t end end
match = lpeg.match(grammar2, input)
print('2', pipe(match,
                flatten,
                function(v) return filter(v, function(v) return type(v) == "number" end) end,
                sum))

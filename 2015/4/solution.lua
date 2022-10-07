local md5 = require('luazen').md5

local input = 'yzbqklnj'

local function solve(input, n)
  local bytesneeded = math.ceil(n / 2)
  local formatstring = string.rep('%02x', bytesneeded)
  local pattern = '^' .. string.rep('0', n)
  for i = 1,math.maxinteger do
    local hash  = md5(input .. i)
    hash = string.format(formatstring, string.byte(hash, 1, bytesneeded))
    if string.match(hash, pattern) then
      return i
    end
  end
end

print('1', solve(input, 5))
print('2', solve(input, 6))

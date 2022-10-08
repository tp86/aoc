local md5 = require('luazen').md5

local input = 'yzbqklnj'

local function solve(input, pattern)
  for i = 1,math.maxinteger do
    local hash  = md5(input .. i)
    if string.match(hash, pattern) then
      return i
    end
  end
end

print('1', solve(input, '^\x00\x00[\x00-\x0f]'))
print('2', solve(input, '^\x00\x00\x00'))

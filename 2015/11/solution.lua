local input = 'hxbxwxba'

local letters = {
  a = 'b',
  b = 'c',
  c = 'd',
  d = 'e',
  e = 'f',
  f = 'g',
  g = 'h',
  h = 'i',
  i = 'j',
  j = 'k',
  k = 'l',
  l = 'm',
  m = 'n',
  n = 'o',
  o = 'p',
  p = 'q',
  q = 'r',
  r = 's',
  s = 't',
  t = 'u',
  u = 'v',
  v = 'w',
  w = 'x',
  x = 'y',
  y = 'z',
  z = 'a',
}
local function nextletter(l)
  local carry
  if l == 'z' then carry = true end
  return letters[l], carry
end

local function nextpassword(password)
  for i = 8, 1, -1 do
    local letter, carry = nextletter(password[i])
    password[i] = letter
    if not carry then break end
  end
  return password
end

local function isvalid(password)
  local doubles = {}
  local increasing = false
  for i = 1, 6 do
    local l1, l2, l3 = password[i], password[i + 1], password[i + 2]
    if l1 == 'i' or l2 == 'i' or l3 == 'i'
        or l1 == 'o' or l2 == 'o' or l3 == 'o'
        or l1 == 'l' or l2 == 'l' or l3 == 'l'
    then
      return false
    end
    if l1 ~= l3 then
      if l1 == l2 then
        doubles[i] = l1
        doubles[i + 1] = l2
      end
      if l2 == l3 then
        doubles[i + 1] = l2
        doubles[i + 2] = l3
      end
    end
    if l3 == nextletter(l2) and l2 == nextletter(l1)
    and l2 ~= 'a' and l3 ~= 'a'
    then
      increasing = true
    end
  end
  local doublescount = 0
  for _ in pairs(doubles) do
    doublescount = doublescount + 1
  end
  return increasing and doublescount >= 4
end

local function topassword(passwordstring)
  local p = {}
  for c in string.gmatch(passwordstring, '.') do
    p[#p+1] = c
  end
  return p
end

local function nextvalidpassword(password)
  password = topassword(password)
  repeat
    password = nextpassword(password)
  until isvalid(password)
  return table.concat(password)
end

local nextpassword = nextvalidpassword(input)
print('1', nextpassword)
print('2', nextvalidpassword(nextpassword))

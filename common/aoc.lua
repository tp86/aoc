local function readlines(filename)
  --local filename = dir .. '/' .. filename
  local f, err = io.open(filename)
  if not f then
    error(err, 2)
  end
  local lines = {}
  for line in f:lines("l") do
    lines[#lines+1] = line
  end
  f:close()
  return lines
end

local function parseinput(input, parseline)
  local parsed = {}
  for _, line in ipairs(input) do
    parsed[#parsed+1] = parseline(line)
  end
  return parsed
end

return {
  readlines = readlines,
  parseinput = parseinput,
}

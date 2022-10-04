local function readlines(filename)
  local filename = dir .. '/' .. filename
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

return {
  readlines = readlines,
}

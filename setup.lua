local source = debug.getinfo(1, "S").source
local reldir = string.match(source, '^@(.+)/.+$')
local version = string.match(_VERSION, '^Lua (.+)$')
local paths = {
  reldir .. '/common/?.lua',
  '.luarocks/share/lua/' .. version .. '/?.lua',
  '.luarocks/share/lua/' .. version .. '/?/init.lua',
}
package.path = table.concat(paths, ';') .. ';' .. package.path
local cpaths = {
  '.luarocks/lib/lua/' .. version .. '/?.so',
}
package.cpath = table.concat(cpaths, ';') .. ';' .. package.cpath

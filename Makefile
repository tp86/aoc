.phony: run deps

luaversion := 5.4

srcfile := solution.lua

dir := $(subst $(shell pwd)/,,$(dir))
depsfile := $(dir)/deps.txt
luarockstree := $(dir)/.luarocks
luarocksflags := --lua-version $(luaversion) --tree $(luarockstree)
luarockslibs := $(luarockstree)/share/lua/$(luaversion)/?.lua;$(luarockstree)/share/lua/$(luaversion)/?/init.lua
locallibs := ./common/?.lua;./common/?/init.lua
luarocksclibs := $(luarockstree)/lib/lua/$(luaversion)/?.so
luasetup := -e 'package.path = package.path .. [[;$(locallibs);$(luarockslibs)]] \
								package.cpath = package.cpath .. [[;$(luarocksclibs)]] \
								dir = [[$(dir)]]'

run:
	@lua $(luasetup) $(dir)/$(srcfile)

deps:
	@luarocks $(luarocksflags) install $(shell cat $(depsfile))

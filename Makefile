.phony: run

srcfile := solution.lua

dir := $(subst $(shell pwd)/,,$(dir))
luasetup := -e 'package.path = package.path .. [[;./common/?.lua]]; dir = [[$(dir)]]'

run:
	@lua $(luasetup) $(dir)/$(srcfile)

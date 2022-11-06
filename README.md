# aoc
[Advent of Code](https://adventofcode.com/) solutions in Scheme

## Running

Lua solutions with `make`:

```bash
cd 2015/1
dir=$(pwd) make -C ../..
```

In Neovim:

```
:cd 2015/1
:luafile ../../nvim.lua
:make -C ../..
```

With pure lua:

```bash
cd 2015/1
lua -e 'dofile"../../setup.lua"' solution.lua
```

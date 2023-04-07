## lua-pam
A module for lua  to use PAM. Fork from https://github.com/RMTT/lua-pam. 
_Fixed version to compile with different versions of Lua._

Also contain ebuild for Gentoo.

## Complile
```shell
cmake . -B build -DLUA=lua5.3
cd build
make
```
Availible values for LUA variable: `lua5.2`, `lua5.3`(default), `lua5.4`, `luajit`. To compile with `luajit`, you need to compile `luajit` in `lua53compat`

## Installation 

```shell
make install
```

The file `liblua_pam.so` is installed into `/usr/lib64/lua/{LUA_VERSION}`.

## Usage
```lua
-- add the lib to cpath by yourself

local pam = require("liblua_pam")
local auth = pam.auth_current_user(password)

if auth
then
    print("Success!")
end
```

## Troubleshooting
#### cannot find `lua.hpp` or `liblua.so`
Make sure the file exists on your machine,it's need install some package on some distros,such as Debian/Ubuntu,you should install `liblua-dev`

#### cannot find `pam_appl.hpp` on Ubuntu/Debian
Install `libpam0g-dev`

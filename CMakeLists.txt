cmake_minimum_required(VERSION 3.15)
project(lua_pam)

include(FindPkgConfig)

set(CMAKE_CXX_STANDARD 14)

set(SOURCE_DIR src)

set(LUA lua5.3 CACHE STRING "Lua definition")

string(REGEX MATCH "([a-z]+)([0-9.]*)" LUA_DEFINITON "${LUA}")

if ((CMAKE_MATCH_COUNT EQUAL 2) AND (CMAKE_MATCH_1 STREQUAL "lua"))
    set(LUA_VERSION CMAKE_MATCH_2)
    pkg_check_modules(LUA ${LUA})
    pkg_get_variable(INSTALL_CMOD ${LUA} INSTALL_CMOD)
elseif ((CMAKE_MATCH_COUNT EQUAL 1) AND (CMAKE_MATCH_1 STREQUAL "luajit")) 
    pkg_check_modules(LUA ${LUA})
    pkg_get_variable(INSTALL_CMOD ${LUA} INSTALL_CMOD)
else()
    message(FATAL_ERROR "Availiable LUA definition: 'lua5.2', 'lua5.3', 'lua5.4', 'luajit'.")
endif()

include_directories(${LUA_INCLUDE_DIRS})
add_library(lua_pam SHARED ${SOURCE_DIR}/main.cpp)
target_link_libraries(lua_pam ${LUA_LIBRARIES} pam)

INSTALL (TARGETS lua_pam DESTINATION ${INSTALL_CMOD})

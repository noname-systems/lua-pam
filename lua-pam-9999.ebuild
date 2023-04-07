# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{2..4} luajit )

inherit cmake lua

DESCRIPTION="A module for lua to use PAM"
HOMEPAGE="https://github.com/RMTT/lua-pam"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/noname-systems/lua-pam.git"
#	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/noname-systems/lua-pam/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	sys-libs/zlib
	${LUA_DEPS}

"
DEPEND="${RDEPEND}"

lua_src_configure() {
	local mycmakeargs=(
		-DLUA="${ELUA}"
	)

	cmake_src_configure
}

src_configure() {
	lua_foreach_impl lua_src_configure
}

src_compile() {
	lua_foreach_impl cmake_src_compile
}

src_install() {
	lua_foreach_impl cmake_src_install
}

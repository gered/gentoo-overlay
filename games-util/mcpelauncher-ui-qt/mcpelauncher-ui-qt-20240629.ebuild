# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake flag-o-matic

DESCRIPTION="mcpelauncher-linux UI"
HOMEPAGE="https://github.com/minecraft-linux/mcpelauncher-ui-manifest"
EGIT_BRANCH="ng"
EGIT_COMMIT="8eed58c4b2f4a83e7f826f0b8c85f87efe6cbc58"
EGIT_REPO_URI="https://github.com/minecraft-linux/mcpelauncher-ui-manifest.git"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-qt/qtwebengine:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-libs/libzip
	dev-libs/protobuf"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES="
	${FILESDIR}/0001-cmake-Fix-compatibility-with-newer-protobuf-versions.patch
"

src_configure() {
	# Doesn't like LTO
	filter-flags -flto*

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DLAUNCHER_ENABLE_GLFW=OFF   # 2023-08-28: just temporarily to deal with broken glfw source download during build
	)

	cmake_src_configure
}

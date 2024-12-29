# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake flag-o-matic

DESCRIPTION="mcpelauncher-linux UI"
HOMEPAGE="https://github.com/minecraft-linux/mcpelauncher-ui-manifest"
EGIT_COMMIT="v${PV}-qt6"
EGIT_REPO_URI="https://github.com/minecraft-linux/mcpelauncher-ui-manifest.git"
RESTRICT="network-sandbox"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-qt/qtbase:6
	dev-qt/qtwebengine:6
	dev-qt/qtdeclarative:6
	dev-qt/qtsvg:6
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

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
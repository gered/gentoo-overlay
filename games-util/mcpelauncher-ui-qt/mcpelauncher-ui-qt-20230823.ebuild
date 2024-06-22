# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake flag-o-matic

DESCRIPTION="mcpelauncher-linux UI"
HOMEPAGE="https://github.com/minecraft-linux/mcpelauncher-ui-manifest"
EGIT_BRANCH="ng"
EGIT_COMMIT="55645fedc0980b548c5b35ff62373e9b45ded557"
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
	<=dev-libs/protobuf-21.12" # 2024-06-22: temporary measure due to missing symbol issues during linking when building with newer versions
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	# Doesn't like LTO
	filter-flags -flto*

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DLAUNCHER_ENABLE_GLFW=OFF   # 2023-08-28: just temporarily to deal with broken glfw source download during build
	)

	cmake_src_configure
}

# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake toolchain-funcs flag-o-matic

DESCRIPTION="Minecraft Bedrock Launcher for Linux (unofficial)"
HOMEPAGE="https://github.com/minecraft-linux/mcpelauncher-manifest"
SRC_URI="https://github.com/nlohmann/json/releases/download/v3.7.3/include.zip -> nlohmann_json-3.7.3.zip"
EGIT_COMMIT="v${PV}-qt6"
EGIT_REPO_URI="https://github.com/minecraft-linux/mcpelauncher-manifest.git"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng
	dev-libs/libevdev
	x11-libs/libXi
	dev-qt/qtwebengine:6
	dev-qt/qtdeclarative:6
	dev-qt/qtbase:6
	dev-libs/libuv
	llvm-core/clang:*
	llvm-core/llvm:*"
RDEPEND="${DEPEND}
	games-util/mcpelauncher-ui-qt
"
BDEPEND="app-arch/unzip"

# Prevent downloading nlohmann_json sources
PATCHES="
	${FILESDIR}/system-nlohmann_json.patch
"

src_unpack() {
	unpack "${DISTDIR}/nlohmann_json-3.7.3.zip"
	git-r3_src_unpack
}

src_configure() {
	# Force clang (pulled from www-client/firefox)
	# Some of the code comes from Android which doesn't like GCC
	elog "Forcing clang"
	AR=llvm-ar
	CC=${CHOST}-clang
	CXX=${CHOST}-clang++
	NM=llvm-nm
	RANLIB=llvm-ranlib

	strip-unsupported-flags
	append-flags "-D_FORTIFY_SOURCE=0"

	# Ensure we use correct toolchain
	export HOST_CC="$(tc-getBUILD_CC)"
	export HOST_CXX="$(tc-getBUILD_CXX)"
	tc-export CC CXX LD AR NM OBJDUMP RANLIB PKG_CONFIG

	local mycmakeargs=(
		-DUSE_OWN_CURL=OFF                    # own curl builds broken due to wrong url currently. skip it!
		-DBUILD_SHARED_LIBS=OFF
		-DUSE_EXTERNAL_JSON=YES               # Workaround for nlohmann_json
		-DJSON_SOURCES="${WORKDIR}"           # Workaround for nlohmann_json
		-DJNI_USE_JNIVM=ON
		-Wno-dev
	)

	cmake_src_configure
}

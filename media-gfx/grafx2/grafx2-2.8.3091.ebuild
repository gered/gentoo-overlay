# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://www.pulkomandy.tk/projects/GrafX2"
SRC_URI="http://www.pulkomandy.tk/projects/GrafX2/downloads/${P}-HEAD-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ttf lua"

# Test phase fails: make: *** [Makefile:1146: ../bin/tests-sdl] Error 1
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-desktop-file.patch"
)

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image[tiff]
	media-libs/freetype
	media-libs/libpng
	ttf? ( media-libs/sdl2-ttf )
	lua? ( >=dev-lang/lua-5.1.0 )
"

S="${WORKDIR}/${PN}/src/"

src_prepare() {
	pushd ../
	eapply ${PATCHES}
	eapply_user
	popd
	sed -i s/lua5\.1/lua/g Makefile || die
}

src_compile() {
	use ttf || MYCNF="NOTTF=1"
	use lua || MYCNF="${MYCNF} NOLUA=1"
	MYCNF="${MYCNF} API=sdl2"

	emake ${MYCNF} || die "emake failed"
}

src_install() {
	emake ${MYCNF} DESTDIR="${D}" PREFIX="/usr" install || die "Install failed"
}

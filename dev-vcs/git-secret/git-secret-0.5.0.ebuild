# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A bash-tool to store your private data inside a git repository"
HOMEPAGE="https://git-secret.io https://github.com/sobolevn/git-secret"
SRC_URI="https://github.com/sobolevn/git-secret/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-crypt/gnupg
	app-shells/bash
	dev-vcs/git
	sys-apps/gawk
	sys-apps/coreutils
"
DEPEND="${RDEPEND}"

src_install() {
	emake install PREFIX="${ED}"/usr
}

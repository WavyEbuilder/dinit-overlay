# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit dinit meson

DESCRIPTION="Dinit services for Gentoo Linux"
HOMEPAGE="https://github.com/WavyEbuilder/dinit-gentoo"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WavyEbuilder/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/WavyEbuilder/${PN}/releases/download/v${PV}/${P}.tar.xz"
fi

LICENSE="BSD-2"
SLOT="0"

RDEPEND="virtual/tmpfiles"

src_install() {
	meson_src_install

	exeinto /usr/libexec
	doexe "${FILESDIR}/dinit-devd"

	for i in {1..8}; do
		dinit_enablesystemsrv tty${i}
	done

	keepdir /etc/dinit.d/boot.d
	keepdir /usr/lib/dinit.d/boot.d
	keepdir /usr/lib/dinit.d/user/boot.d
}

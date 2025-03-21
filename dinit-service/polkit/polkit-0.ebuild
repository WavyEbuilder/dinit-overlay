# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit dinit

DESCRIPTION="Dinit service file for polkit"

S="${WORKDIR}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dinit_dosrv "${FILESDIR}/polkitd"
}

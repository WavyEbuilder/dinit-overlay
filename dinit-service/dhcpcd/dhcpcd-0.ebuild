# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit dinit

DESCRIPTION="Dinit service file for dhcpcd"

S="${WORKDIR}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dinit_dosrv "${FILESDIR}/dhcpcd"
}

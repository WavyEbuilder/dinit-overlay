# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="The dinit service supervision + init suite"
HOMEPAGE="https://github.com/davmac314/dinit"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/davmac314/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/davmac314/${PN}/releases/download/v${PV}/${P}.tar.xz"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="+caps +cgroups +sysv-utils test"
RESTRICT="!test? ( test )"

src_configure() {
	local emesonargs=(
		$(meson_feature caps support-capabilities)
		$(meson_feature cgroups support-cgroups)
		$(meson_feature sysv-utils build-shutdown)
		$(meson_use test unit-tests)
		$(meson_use test igr-tests)
	)
	meson_src_configure
}

src_install() {
	if use init; then
		dosbin "${FILESDIR}"/init
	fi
}

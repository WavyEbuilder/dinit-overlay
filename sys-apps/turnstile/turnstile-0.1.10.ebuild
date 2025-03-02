# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Independent session/login tracker"
HOMEPAGE="https://github.com/chimera-linux/turnstile"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chimera-linux/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/chimera-linux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="dinit runit rundir man"

BDEPEND="man? ( app-text/scdoc )"
RDEPEND="sys-libs/pam"

src_configure() {
	local emesonargs=(
		$(meson_feature dinit)
		$(meson_use rundir manage_rundir)
		$(meson_use man)
	)
	meson_src_configure
}

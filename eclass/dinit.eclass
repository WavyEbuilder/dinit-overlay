# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: dinit.eclass
# @MAINTAINER:
# rahul@sandhuservices.dev
# @SUPPORTED_EAPIS: 7 8
# @BLURB: helper functions to install dinit services
# @DESCRIPTION:
# This eclass provides a set of functions to install service files for
# sys-apps/dinit within ebuilds.
# @EXAMPLE:
#
# @CODE
# inherit dinit
#
# src_configure() {
#	local myconf=(
#		--enable-foo
#		--with-dinitsystemsrvdir="$(dinit_get_systemsrvdir)"
#	)
#
#	econf "${myconf[@]}"
# }
# @CODE

if [[ -z ${_DINIT_ECLASS} ]]; then
_DINIT_ECLASS=1

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

inherit toolchain-funcs

# @FUNCTION: dinit_get_systemsrvdir
# @DESCRIPTION:
# Output the path for the dinit system service directory (not including
# ${D}).  This function always succeeds, even if dinit is not
# installed.
dinit_get_systemsrvdir() {
	debug-print-function ${FUNCNAME} "$@"

	/lib/dinit.d
}

# @FUNCTION: dinit_get_usersrvdir
# @DESCRIPTION:
# Output the path for the dinit user service directory (not including
# ${D}). This function always succeeds, even if dinit is not
# installed.
dinit_get_usersrvdir() {
	debug-print-function ${FUNCNAME} "$@"

	/lib/dinit.d/user
}

# @FUNCTION: dinit_get_utildir
# @DESCRIPTION:
# Output the path for the dinit utility directory (not including
# ${D}). This function always succeeds, even if dinit is not
# installed.
dinit_get_utildir() {
	debug-print-function ${FUNCNAME} "$@"

	/lib/dinit
}

# @FUNCTION: dinit_dosrv
# @USAGE: <unit>...
# @DESCRIPTION:
# Install dinit service(s). Uses doins, thus it is fatal.
dinit_dosrv() {
	debug-print-function ${FUNCNAME} "$@"

	(
		insopts -m 0644
		insinto "$(dinit_get_systemsrvdir)"
		doins "${@}"
	)
}

# @FUNCTION: dinit_newsrv
# @USAGE: <old-name> <new-name>
# @DESCRIPTION:
# Install dinit service with a new name. Uses newins, thus it is fatal.
dinit_newsrv() {
	debug-print-function ${FUNCNAME} "$@"

	(
		insopts -m 0644
		insinto "$(dinit_get_systemsrvdir)"
		newins "${@}"
	)
}

# @FUNCTION: dinit_dousersrv
# @USAGE: <unit>...
# @DESCRIPTION:
# Install dinit user service(s). Uses doins, thus it is fatal.
dinit_dousersrv() {
	debug-print-function ${FUNCNAME} "$@"

	(
		insopts -m 0644
		insinto "$(dinit_get_usersrvdir)"
		doins "${@}"
	)
}

# @FUNCTION: dinit_newusersrv
# @USAGE: <old-name> <new-name>
# @DESCRIPTION:
# Install dinit user service with a new name. Uses newins, thus it
# is fatal.
dinit_newusersrv() {
	debug-print-function ${FUNCNAME} "$@"

	(
		insopts -m 0644
		insinto "$(dinit_get_usersrvdir)"
		newins "${@}"
	)
}

# @FUNCTION: dinit_enablesystemsrv
# @USAGE: <service>
# @DESCRIPTION:
# Enable service in desired target, e.g. install a symlink for it.
# Uses dosym, thus it is fatal.
dinit_enablesystemsrv() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -eq 1 ]] || die "Synopsis: dinit_enablesystemsrv service"

	local service=${1}
	local ud=$(dinit_get_systemsrvdir)
	local destname=${service##*/}

	dosym ../"${service}" "${ud}"/boot.d/"${destname}"
}

# @FUNCTION: dinit_enableusersrv
# @USAGE: <service>
# @DESCRIPTION:
# Enable service in desired target, e.g. install a symlink for it.
# Uses dosym, thus it is fatal.
dinit_enableusersrv() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -eq 1 ]] || die "Synopsis: dinit_enableusersrv service"

	local service=${1}
	local ud=$(dinit_get_usersrvdir)
	local destname=${service##*/}

	dosym ../"${service}" "${ud}"/boot.d/"${destname}"
}

fi

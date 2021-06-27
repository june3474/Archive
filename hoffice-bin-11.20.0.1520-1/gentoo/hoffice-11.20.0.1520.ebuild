# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit xdg

DESCRIPTION="Hancom office"
HOMEPAGE="http://www.hancom.com"
SRC_URI="https://github.com/DisLogicator/hoffice/releases/download/${PV}-rc2/${P}.tar.gz"
LICENSE="hancomoffice"
SLOT="0"
# only on amd64
KEYWORDS="-* amd64"
IUSE=""
RESTRICT="mirror"
BDEPEND="app-arch/libarchive"
RDEPEND="
	media-libs/harfbuzz[icu]
	net-misc/curl[gnutls]
	media-libs/glu
"
S=${WORKDIR}
# customize INSTALL_LOCATION
INSTALL_LOCATION="/opt"

src_prepare() {
	# modify desktop files according to $INSTALL_LOCATION
	for file in ${S}/*.desktop
	do
		sed -i "s:\(Exec=\)\(.*\)\(/hoffice11\):\1${INSTALL_LOCATION}\3:; \
				s:\(Icon=\)\(.*\)\(hoffice11.*\)\(\.png\):\1\3:" "$file"
	done
	default
}

src_install() {
	# install base
	mkdir -p "${D}/${INSTALL_LOCATION}"
	bsdtar -xf "${S}/hoffice11.zip" -C "${D}/${INSTALL_LOCATION}"
	# install desktop files
	modify_desktop_files
	insinto "/usr/share/applications"
	doins *.desktop
	# install icons
	insinto "/usr/share/icons/hicolor/256x256/apps"
	doins *.png
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	[[ -e /usr/lib64/libcurl-gnutls.so.4 ]] \
		|| ln -s libcurl.so.4 /usr/lib64/libcurl-gnutls.so.4
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}

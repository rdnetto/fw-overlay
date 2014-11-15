# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils versionator

DESCRIPTION="Sublime Text is a sophisticated text editor for code, html and prose"
HOMEPAGE="http://www.sublimetext.com"

SRC_URI="amd64? ( http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20${PV}%20x64.tar.bz2 )
	x86?  ( http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20${PV}.tar.bz2 )"
LICENSE="Unlicense"
SLOT="$(get_major_version)"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="x11-libs/gtk+:2"

INSTALL_DIR="/opt/${PN}-$(get_major_version)"

S=${WORKDIR}/"Sublime Text 2"

src_install() {
	insinto ${INSTALL_DIR}
	
	doins -r "lib"
	doins -r "Icon"
	doins -r "Pristine Packages"
	doins "sublime_plugin.py"
	doins "PackageSetup.py"
	doins "sublime_text"
        
    fperms 755 ${INSTALL_DIR}/sublime_text

    make_wrapper "${PN}-${PV}" "${INSTALL_DIR}/sublime_text"
    newicon "Icon/128x128/sublime_text.png" "${PN}-${PV}.png"
	
	local desktop_file
	desktop_file=$(make_desktop_entry "${PN}-${PV}" "Sublime Text Editor" "${PN}-${PV}" "GTK;Utility;Office;TextEditor;") 
	echo "StartupNotify=true" >> "${desktop_file}" 
	echo "MimeType=text/plain;" >> "${desktop_file}" 
}

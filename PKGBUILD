# Contributor: Taiki Sugawara <buzz.taiki@gmail.com>
# Contributor: Thayer Williams <thayer@archlinux.org>
# Contributor: Hugo Doria <hugo@archlinux.org>
# Contributor: TuxSpirit<tuxspirit@archlinux.fr>  2007/11/17 21:22:36 UTC
# Contributor: Daniel J Griffiths <ghost1227@archlinux.us>
# Maintainer: Gaetan Bisson <bisson@archlinux.org>

pkgname=p7zip-natspec
_pkgname=p7zip
pkgver=9.20.1
pkgrel=1
_base_pkgrel=9
pkgdesc='Command-line version of the 7zip compressed file archiver, using libnatspec patch from ubuntu zip-i18n PPA (https://launchpad.net/~frol/+archive/zip-i18n).'
url='http://p7zip.sourceforge.net/'
license=('GPL' 'custom')
arch=('i686' 'x86_64')
depends=('gcc-libs' 'bash' 'libnatspec')
optdepends=('wxgtk2.8: GUI'
            'desktop-file-utils: desktop entries')
makedepends=('yasm' 'nasm' 'wxgtk2.8')
conflicts=('p7zip')
provides=('p7zip')
source=("http://downloads.sourceforge.net/project/${_pkgname}/${_pkgname}/${pkgver}/${_pkgname}_${pkgver}_src_all.tar.bz2"
        '7zFM.desktop'
        'natspec.patch')
sha1sums=('1cd567e043ee054bf08244ce15f32cb3258306b7'
          'f2c370d6f1b286b7ce9a2804e22541b755616a40'
          'e780553323a72a1222aa696c5c6edc1b23a5657b')

options=('!makeflags')
install=install

prepare() {
	cd "${srcdir}/${_pkgname}_${pkgver}"
	rm GUI/kde4/p7zip_compress.desktop
    patch -p1 < ../natspec.patch

	[[ $CARCH = x86_64 ]] \
	    && cp makefile.linux_amd64_asm makefile.machine \
	    || cp makefile.linux_x86_asm_gcc_4.X makefile.machine

	sed -i 's/wx-config/wx-config-2.8/g' CPP/7zip/TEST/TestUI/makefile \
		CPP/7zip/UI/{FileManager,GUI,P7ZIP}/makefile
}

build() {
	cd "${srcdir}/${_pkgname}_${pkgver}"
	make all4 OPTFLAGS="${CXXFLAGS}"
}

package() {
	cd "${srcdir}/${_pkgname}_${pkgver}"
	make install \
		DEST_DIR="${pkgdir}" \
		DEST_HOME="/usr" \
		DEST_MAN="/usr/share/man"

	# Licenses
	install -d "${pkgdir}"/usr/share/licenses/p7zip
	ln -s -t "${pkgdir}"/usr/share/licenses/p7zip \
		/usr/share/doc/p7zip/DOCS/License.txt \
		/usr/share/doc/p7zip/DOCS/unRarLicense.txt

	# Integration with stuff...
	install -Dm644 GUI/p7zip_32.png "${pkgdir}"/usr/share/icons/hicolor/32x32/apps/p7zip.png
	install -d "${pkgdir}"/usr/share/{applications,kde4/services/ServiceMenus}
	cp GUI/kde4/* "${pkgdir}"/usr/share/kde4/services/ServiceMenus/
	cp ../7zFM.desktop "${pkgdir}"/usr/share/applications/
	ln -s 7zCon.sfx "${pkgdir}"/usr/lib/p7zip/7z.sfx

	find GUI/help -type d -exec chmod 755 {} \;
	cp -r GUI/help "${pkgdir}"/usr/lib/p7zip/

	chmod -R u+w "${pkgdir}/usr"
}

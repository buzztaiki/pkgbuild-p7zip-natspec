# Maintainer: Taiki Sugawara <buzz.taiki@gmail.com>
# Contributor: Evangelos Foutras <evangelos@foutrelis.com>
# Contributor: Gaetan Bisson <bisson@archlinux.org>
# Contributor: Thayer Williams <thayer@archlinux.org>
# Contributor: Hugo Doria <hugo@archlinux.org>
# Contributor: TuxSpirit<tuxspirit@archlinux.fr>
# Contributor: Daniel J Griffiths <ghost1227@archlinux.us>

pkgname=p7zip-natspec
_pkgname=p7zip
pkgver=17.04
pkgrel=1
_upstream_pkgrel=1
pkgdesc="Command-line file archiver with high compression ratio, based on libnatspec patch from ubuntu zip-i18n PPA (https://launchpad.net/~frol/+archive/zip-i18n)."
arch=('x86_64')
url="https://github.com/jinfeihan57/p7zip"
license=('LGPL' 'custom:unRAR')
depends=('gcc-libs' 'sh' 'libnatspec')
conflicts=('p7zip')
provides=('p7zip')
source=(https://github.com/jinfeihan57/p7zip/archive/v$pkgver/$_pkgname-v$pkgver.tar.gz
        oemcp-iconv.patch::https://github.com/jinfeihan57/p7zip/commit/c104127e6a93.patch
        oemcp-cygwin.patch::https://github.com/jinfeihan57/p7zip/commit/0e0a1a8316b6.patch
        oemcp-apple.patch::https://github.com/jinfeihan57/p7zip/commit/334a01e3f8bc.patch
        natspec.patch)
sha256sums=('ea029a2e21d2d6ad0a156f6679bd66836204aa78148a4c5e498fe682e77127ef'
            'e32636aa03b9c75a2b9d9138e03a738ceed6ca5da4c3c67e7f5981e135fb9e24'
            'fa658d42cc1da2b567a210a819502bd8e3bb1e02d5d23e087e2278c4aaffe15e'
            'a1b21ceb5582633d85d41ec9e4995f758cba1731dd80fb6f45a7bc6b18bfe394'
            'e98506a3880da2d8b54ccbafbb3acac1bbc6b8f2552de37b658a4bfac7f498ad')

prepare() {
  cd $_pkgname-$pkgver

  patch -p1 < ../natspec.patch

  # https://github.com/jinfeihan57/p7zip/issues/112
  patch -Rp1 -i ../oemcp-apple.patch
  patch -Rp1 -i ../oemcp-cygwin.patch
  patch -Rp1 -i ../oemcp-iconv.patch
}

build() {
  cd $_pkgname-$pkgver
  make OPTFLAGS="$CPPFLAGS $CFLAGS" 7z 7zr 7za
}

package() {
  cd $_pkgname-$pkgver

  make install \
    DEST_DIR="$pkgdir" \
    DEST_HOME=/usr \
    DEST_MAN=/usr/share/man

  # Remove documentation for the GUI file manager
  rm -r "$pkgdir/usr/share/doc/p7zip/DOC/MANUAL/fm"

  install -d "${pkgdir}"/usr/share/licenses/p7zip
  ln -s -t "$pkgdir/usr/share/licenses/p7zip/" \
    /usr/share/doc/p7zip/DOC/License.txt \
    /usr/share/doc/p7zip/DOC/unRarLicense.txt
}

# vim:set ts=2 sw=2 et:

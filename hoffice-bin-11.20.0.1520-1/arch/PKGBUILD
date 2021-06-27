# Maintainer: h
# Contributor: h
pkgname=hoffice-bin
pkgver=11.20.0.1520
pkgrel=1
pkgdesc="Hwp document editor for Linux. Hwp 2020 Beta is an editor that allows you to create Hwp documents easily in the Linux environment and edit them by applying various styles and formats."
arch=('i686' 'x86_64')
url="http://www.hancom.com"
license=('custom')
groups=('hoffice')
depends=(
	'cairo'
	'fontconfig'
	'freetype2'
	'glu'
	'harfbuzz'
	'harfbuzz-icu'
	'libcurl-gnutls'
	'qt5-base'
    'md4c'
	'zlib'
	'libhangul'
)
makedepends=(
	'binutils'
    'libarchive'
    'sed'
)
options=(
	'!emptydirs'
)
install=install
source=("hoffice-$pkgver.tar.gz"
        'install')
sha256sums=('4a683809eff85b460efbf2989219adbf2d7e246d414be52f55823a2e3605605d'
            'SKIP')

prepare() {
    # change install location: /opt/hnc/hoffice11 => /opt/hoffice11
	# modify desktop files
	for file in *.desktop
	do
		sed -i "s:\(Exec=\)\(/opt\)\(.*\)\(/hoffice11\):\1\2\4:; \
		        s:\(Icon=\)\(.*\)\(hoffice11.*\)\(\.png\):\1\3:" "$file"
	done
}

package() {
    # install hoffice binary files
    mkdir $pkgdir/opt && bsdtar xzf hoffice11.zip -C $pkgdir/opt

    # install desktop files
    mkdir -p $pkgdir/usr/share/applications && \
    install -m 644 -t $pkgdir/usr/share/applications *.desktop
    # install icon files
    mkdir -p $pkgdir/usr/share/icons/hicolor/256x256/apps && \
    install -m 644 -t $pkgdir/usr/share/icons/hicolor/256x256/apps *.png

    echo "    최종 패키지 압축 단계에서 한글로 된 글꼴 파일명을 utf-8으로 전환할 수"
    echo "    없다는 에러 비슷한 메시지가 나올 수 있습니다."
    echo "    전혀 문제가 없으니 걱정할 필요 없습니다."
    echo "    You may get error-like messages in the last phase of package-compression"
    echo "    about translating pathname encoded in Korean to UTF-8."
    echo "    Nothing to worry, No problemo!"
}

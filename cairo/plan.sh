pkg_name=cairo
pkg_origin=core
pkg_version="1.14.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
    'LGPL-2.1'
    'MPL-1.1'
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="d1f2d98ae9a4111564f6de4e013d639cf77155baf2556582295a0f00a9bc5e20"
pkg_build_deps=(
    core/diffutils
    core/fontconfig
    core/freetype
    core/gcc
    core/glib
    core/libpng
    core/make
    core/pixman
    core/pkg-config
    core/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/cairo)
pkg_lib_dirs=(
    lib
    lib/cairo
    lib/pkgconfig
)

do_build() {
    export CFLAGS="-Os ${CFLAGS}"
    ./configure --prefix="${pkg_prefix}" \
                --enable-tee \
                --enable-xml
    make
}

do_check() {
    make test
}

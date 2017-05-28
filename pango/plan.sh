pkg_name=pango
pkg_origin=core
pkg_version="1.40.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="http://ftp.gnome.org/pub/GNOME/sources/pango/1.40/$pkg_name-$pkg_version.tar.xz"
pkg_shasum="ca152b7383a1e9f7fd74ae96023dc6770dc5043414793bfe768ff06b6759e573"
pkg_deps=(
    core/cairo
    core/coreutils
    core/fontconfig
    core/freetype
    core/glib
    core/harfbuzz
)
pkg_build_deps=(
    core/busybox
    core/diffutils
    core/file
    core/gcc
    core/make
    core/perl
    core/pkg-config
    core/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
    if [ ! -e /usr/bin/file ]
    then
        ln -sv "$(pkg_path_for core/file)/bin/file" /usr/bin/file
    fi
}

do_build() {
    export CAIRO_LIBS="-L$(pkg_path_for core/cairo)/lib"
    export CAIRO_CFLAGS="-I$(pkg_path_for core/cairo)/include/cairo"
    export FONTCONFIG_LIBS="-L$(pkg_path_for core/fontconfig)/lib -lfontconfig"
    export FONTCONFIG_CFLAGS="-I$(pkg_path_for core/fontconfig)/include"
    export FREETYPE_LIBS="-L$(pkg_path_for core/freetype)/lib -lfreetype"
    export FREETYPE_CFLAGS="-I$(pkg_path_for core/freetype)/include/freetype2"
    export GLIB_LIBS="-L$(pkg_path_for core/glib)/lib -lglib-2.0"
    export GLIB_CFLAGS="-I$(pkg_path_for core/glib)/include/glib-2.0 -I$(pkg_path_for core/glib)/include/glib-2.0/gobject -I$(pkg_path_for core/glib)/include/glib-2.0/glib -I$(pkg_path_for core/glib)/include/glib-2.0/gio -I$(pkg_path_for core/glib)/lib/glib-2.0/include"
    export HARFBUZZ_LIBS="-L$(pkg_path_for core/harfbuzz)/lib"
    export HARFBUZZ_CFLAGS="-I$(pkg_path_for core/harfbuzz)/include/harfbuzz"

    fix_interpreter "$(pkg_path_for core/glib)/bin/glib-mkenums" core/coreutils bin/env

    ./configure --prefix="$pkg_prefix" > configure.out
    make
}

do_install() {
    make install
}

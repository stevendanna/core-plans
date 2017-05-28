pkg_name=harfbuzz
pkg_origin=core
pkg_version=1.3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('mit')
pkg_source=http://www.freedesktop.org/software/harfbuzz/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a242206dd119d5e6cc1b2253c116abbae03f9d930cb60b515fb0d248decf89a1
pkg_deps=(
  core/cairo
  core/expat
  core/freetype
  core/fontconfig
  core/glib
  core/glibc
  core/icu
)
pkg_build_deps=(
  core/gcc
  core/pkg-config
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/harfbuzz)
pkg_lib_dirs=(lib)

do_build() {
  export FREETYPE_LIBS="-L$(pkg_path_for core/freetype)/lib -lfreetype"
  export FREETYPE_CFLAGS="-I$(pkg_path_for core/freetype)/include/freetype2"
  export CAIRO_LIBS="-L$(pkg_path_for core/cairo)/lib"
  export CAIRO_CFLAGS="-I$(pkg_path_for core/cairo)/include/cairo"
  export CAIRO_FT_LIBS="-L$(pkg_path_for core/cairo)/lib -lcairo"
  export CAIRO_FT_CFLAGS="-I$(pkg_path_for core/cairo)/include/cairo"
  export GLIB_LIBS="-L$(pkg_path_for core/glib)/lib -lglib-2.0"
  export GLIB_CFLAGS="-I$(pkg_path_for core/glib)/include/glib-2.0 -I$(pkg_path_for core/glib)/lib/glib-2.0/include"
  export GOBJECT_LIBS="-L$(pkg_path_for core/glib)/lib -lgobject-2.0"
  export GOBJECT_CFLAGS="-I$(pkg_path_for core/glib)/include/glib-2.0 -I$(pkg_path_for core/glib)/include/glib-2.0/gobject -I$(pkg_path_for core/glib)/lib/glib-2.0/include"
  export FONTCONFIG_LIBS="-L$(pkg_path_for core/fontconfig)/lib -lfontconfig"
  export FONTCONFIG_CFLAGS="-I$(pkg_path_for core/fontconfig)/include"

  ./configure --prefix=$pkg_prefix \
	      --with-gobject=yes
  make
}

do_install() {
  make install
}

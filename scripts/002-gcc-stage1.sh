#!/bin/bash
# gcc-3.2.3-stage1.sh by AKuHAK
# Based on gcc-3.2.2-stage1.sh by Naomi Peori (naomi@peori.ca)

GCC_VERSION=3.2.3
## Download the source code.
SOURCE=http://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2
wget --continue $SOURCE || { exit 1; }

## Unpack the source code.
echo Decompressing GCC $GCC_VERSION. Please wait.
rm -Rf gcc-$GCC_VERSION && tar xfj gcc-$GCC_VERSION.tar.bz2 || { exit 1; }

## Enter the source directory and patch the source code.
cd gcc-$GCC_VERSION || { exit 1; }
if [ -e ../../patches/gcc-$GCC_VERSION-PS2.patch ]; then
	cat ../../patches/gcc-$GCC_VERSION-PS2.patch | patch -p1 || { exit 1; }
fi

TARGET="iop"
TARG_XTRA_OPTS=""
OSVER=$(uname)

## Apple needs to pretend to be linux
if [ ${OSVER:0:6} == Darwin ]; then
	TARG_XTRA_OPTS="--build=i386-linux-gnu --host=i386-linux-gnu"
elif [ ${OSVER:0:10} == MINGW64_NT ]; then
	export lt_cv_sys_max_cmd_len=8000
	export CC=x86_64-w64-mingw32-gcc
	CFLAGS="$CFLAGS -DHAVE_DECL_ASPRINTF -DHAVE_DECL_VASPRINTF"
	TARG_XTRA_OPTS="--host=x86_64-w64-mingw32"
elif [ ${OSVER:0:10} == MINGW32_NT ]; then
	export lt_cv_sys_max_cmd_len=8000
	export CC=i686-w64-mingw32-gcc
	CFLAGS="$CFLAGS -DHAVE_DECL_ASPRINTF -DHAVE_DECL_VASPRINTF"
	TARG_XTRA_OPTS="--host=i686-w64-mingw32"
fi

## Determine the maximum number of processes that Make can work with.
PROC_NR=$(getconf _NPROCESSORS_ONLN)

echo "Building with $PROC_NR jobs"

## Create and enter the build directory.
rm -rf build-$TARGET-stage1 && mkdir build-$TARGET-stage1 && cd build-$TARGET-stage1 || { exit 1; }

## Configure the build.
../configure \
  --quiet \
  --prefix="$PS2DEV/$TARGET" \
  --target="$TARGET" \
  --enable-languages="c" \
  --with-newlib \
  --without-headers \
 $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=0 -O2 -Wno-implicit-function-declaration" LDFLAGS="$LDFLAGS -s" || { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }

## Exit the build directory.
cd .. || { exit 1; }

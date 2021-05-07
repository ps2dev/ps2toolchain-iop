#!/bin/bash
# binutils-2.14.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
REPO_URL="https://github.com/ps2dev/binutils-gdb.git"
REPO_FOLDER="binutils-gdb"
BRANCH_NAME="iop-v2.14"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} && git checkout ${BRANCH_NAME} || exit 1
fi

TARGET="iop"
TARG_XTRA_OPTS=""
OSVER=$(uname)

if [ ${OSVER:0:10} == MINGW64_NT ]; then
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
rm -rf build-$TARGET && mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

## Configure the build.
../configure \
  --quiet \
  --prefix="$PS2DEV/$TARGET" \
  --target="$TARGET" \
  --disable-nls \
  --disable-build-warnings \
  $TARG_XTRA_OPTS || { exit 1; }

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=0 -O2 -Wno-implicit-function-declaration" LDFLAGS="$LDFLAGS -s" || { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }

## Exit the build directory.
cd .. || { exit 1; }


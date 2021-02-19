#!/bin/bash
# binutils-2.14.sh by Francisco Javier Trujillo Mata (fjtrujy@gmail.com)

## Download the source code.
REPO_URL="https://github.com/ps2dev/binutils-gdb.git"
REPO_FOLDER="binutils-gdb"
BRANCH_NAME="iop-v2.14"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || exit 1
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || exit 1
fi

OSVER=$(uname)
if [ ${OSVER:0:10} == MINGW64_NT ]; then
	TARG_XTRA_OPTS="--build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32"
else
	TARG_XTRA_OPTS=""
fi

## Determine the maximum number of processes that Make can work with.
if [ ${OSVER:0:5} == MINGW ]; then
	PROC_NR=$NUMBER_OF_PROCESSORS
elif [ ${OSVER:0:6} == Darwin ]; then
	PROC_NR=$(sysctl -n hw.ncpu)
else
	PROC_NR=$(nproc)
fi

echo "Building with $PROC_NR jobs"

## For each target...
for TARGET in "iop"; do
	## Create and enter the build directory.
	rm -rf build-$TARGET && mkdir build-$TARGET && cd build-$TARGET || { exit 1; }

	## Configure the build.
	../configure --quiet --disable-build-warnings --prefix="$PS2DEV/$TARGET" --target="$TARGET" $TARG_XTRA_OPTS || { exit 1; }
	
	## Compile and install.
	make --quiet clean -j $PROC_NR || { exit 1; }
	make -j $PROC_NR CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=0 -O2 -Wno-implicit-function-declaration" LDFLAGS="$LDFLAGS -s" || { exit 1; }
	make --quiet install -j $PROC_NR || { exit 1; }
	make --quiet clean -j $PROC_NR || { exit 1; }

	## Exit the build directory.
	cd .. || { exit 1; }

	## End target.
done

#!/bin/bash

PS2TOOLCHAIN_IOP_BINUTILS_REPO_URL="https://github.com/bminor/binutils-gdb.git"
PS2TOOLCHAIN_IOP_BINUTILS_DEFAULT_REPO_REF="binutils-2_45"
PS2TOOLCHAIN_IOP_GCC_REPO_URL="https://github.com/gcc-mirror/gcc.git"
PS2TOOLCHAIN_IOP_GCC_DEFAULT_REPO_REF="releases/gcc-15.2.0"

if test -f "$PS2DEV_CONFIG_OVERRIDE"; then
  source "$PS2DEV_CONFIG_OVERRIDE"
fi

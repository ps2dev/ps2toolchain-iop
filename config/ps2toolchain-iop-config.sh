#!/bin/bash

# Using gnu.googlesource.com instead of sourceware.org because the clone is producing a 
# RPC failed; HTTP 502 curl 22 The requested URL returned error: 502
PS2TOOLCHAIN_IOP_BINUTILS_REPO_URL="https://gnu.googlesource.com/binutils-gdb"
PS2TOOLCHAIN_IOP_BINUTILS_DEFAULT_REPO_REF="binutils-2_45_1"
PS2TOOLCHAIN_IOP_GCC_REPO_URL="https://gnu.googlesource.com/gcc"
PS2TOOLCHAIN_IOP_GCC_DEFAULT_REPO_REF="releases/gcc-15.2.0"

if test -f "$PS2DEV_CONFIG_OVERRIDE"; then
  source "$PS2DEV_CONFIG_OVERRIDE"
fi

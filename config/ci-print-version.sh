#!/bin/bash

export PS2DEV=$PWD/ps2dev
export PATH=$PATH:$PS2DEV/iop/bin
mipsel-none-elf-as --version
mipsel-none-elf-ld --version
mipsel-none-elf-gcc --version

![CI](https://github.com/ps2dev/ps2toolchain-iop/workflows/CI/badge.svg)
![CI-Docker](https://github.com/ps2dev/ps2toolchain-iop/workflows/CI-Docker/badge.svg)

# ps2toolchain-iop

## **ATTENTION**

If you are confused on how to start developing for PS2, see the
[getting started](https://ps2dev.github.io/#getting-started) section on
the ps2dev main page.  

## Introduction

This program will automatically build and install an IOP compiler, which is used in the creation of homebrew software for the Sony PlayStation® 2 videogame system.

### Supported platforms

- macOS (Intel and Apple Silicon) with Homebrew or MacPorts
- Ubuntu (x86_64 and arm64)
- Windows (MSYS2, MinGW32 environment)

## What these scripts do

These scripts download (with `git clone`) and install [binutils 2.45.1](http://www.gnu.org/software/binutils/ "binutils") (iop), [gcc 15.2.0](https://gcc.gnu.org/ "gcc") (iop).

## Requirements

1.  Install gcc/clang, make, patch, git, and texinfo if you don't have those packages. Below are example commands per platform:

   ### macOS (Homebrew)
   ```bash
   brew update
   brew install texinfo bison flex gnu-sed gsl gmp mpfr libmpc
   ```

   ### macOS (MacPorts)
   Make sure MacPorts is installed first. Then:
   ```bash
   sudo port selfupdate
   sudo port install gmp mpfr libmpc libiconv bison flex texinfo
   ```

   ### Ubuntu
   ```bash
   sudo apt-get update
   sudo apt-get -y install texinfo bison flex gettext libgmp3-dev libmpfr-dev libmpc-dev
   ```

   ### Windows (MSYS2 MinGW32)
   Use the MSYS2 MinGW32 shell and run:
   ```bash
   pacman -S --noconfirm base-devel git make texinfo flex bison patch binutils mpc-devel tar \
     mingw-w64-i686-readline mingw-w64-i686-gcc mingw-w64-i686-cmake mingw-w64-i686-make mingw-w64-i686-libogg
   ```

2.  Ensure that you have enough permissions for managing PS2DEV location (which defaults to `/usr/local/ps2dev`). PS2DEV location MUST NOT have spaces or special characters in its path! For example, on Linux systems, you can set access for the current user by running commands:
```bash
export PS2DEV=/usr/local/ps2dev
sudo mkdir -p $PS2DEV
sudo chown -R $USER: $PS2DEV
```
3.  Add this to your login script (example: `~/.bash_profile`)
```bash
export PS2DEV=/usr/local/ps2dev
export PATH=$PATH:$PS2DEV/iop/bin
```
4.  Run toolchain.sh
    `./toolchain.sh`

## Community

Links for discussion and chat are available
[here](https://ps2dev.github.io/#community).  

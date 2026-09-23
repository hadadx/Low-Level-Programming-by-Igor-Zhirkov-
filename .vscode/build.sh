#!/usr/bin/env bash
# Smart build for this repo: uses the folder's Makefile when there is one,
# otherwise assembles/compiles the currently open file directly.
set -e

dir="$1"
base="$2"
ext="${3#.}"

cd "$dir"

if [ -f Makefile ]; then
    make
elif [ "$ext" = "asm" ]; then
    nasm -felf64 -g -F dwarf "$base.asm" -o "$base.o"
    ld -o "$base" "$base.o"
elif [ "$ext" = "c" ]; then
    gcc -g -O0 -o "$base" "$base.c"
else
    echo "No Makefile in $dir and don't know how to build '.$ext' files."
    exit 1
fi

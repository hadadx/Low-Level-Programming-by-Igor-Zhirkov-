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
    # Link in the other .c files in this folder that have no main(), so
    # multi-file projects (main.c + list_lib.c) build without a Makefile.
    has_main() { grep -Eq '^[[:space:]]*(int|void)[[:space:]]+main[[:space:]]*\(' "$1"; }
    sources=()
    mains=()
    for f in *.c; do
        if has_main "$f"; then mains+=("$f"); else sources+=("$f"); fi
    done
    if has_main "$base.c"; then
        main_file="$base.c"
    elif [ "${#mains[@]}" -eq 1 ]; then
        main_file="${mains[0]}"
    else
        echo "Can't tell which file has main() in $dir - open that file and debug again."
        exit 1
    fi
    echo "gcc -g -O0 -Wall -o $base $main_file ${sources[*]}"
    gcc -g -O0 -Wall -o "$base" "$main_file" "${sources[@]}"
else
    echo "No Makefile in $dir and don't know how to build '.$ext' files."
    exit 1
fi

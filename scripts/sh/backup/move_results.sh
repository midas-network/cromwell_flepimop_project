#!/bin/bash

# cp -r "${1}" /midas/

source_pathname=$1
target_topdir=/midas

mkdir -p "$target_topdir/${source_pathname%/*}" && cp "$source_pathname" "$target_topdir/$source_pathname"

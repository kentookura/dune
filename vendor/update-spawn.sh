#!/bin/bash

version=d5991f7eb4073c85b440789587936d14b4e0417f

set -e -o pipefail

TMP="$(mktemp -d)"
trap "rm -rf $TMP" EXIT

rm -rf spawn
mkdir -p spawn/src

(
    cd $TMP
    git clone https://github.com/ocaml-dune/spawn.git
    cd spawn
    git checkout $version
)

SRC=$TMP/spawn

cp -v $SRC/src/spawn{.ml,.mli,_stubs.c} spawn/src
cp -v $SRC/LICENSE.md spawn/

git checkout spawn/src/dune
git add -A .

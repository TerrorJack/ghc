#!/bin/bash

set -euo pipefail

apt update
apt full-upgrade -y
apt install -y \
  autoconf \
  build-essential \
  curl \
  gawk \
  git \
  libdw-dev \
  libgmp-dev \
  libncurses-dev \
  python3-sphinx
mkdir -p ~/.local/bin
curl -L https://github.com/commercialhaskell/stack/releases/download/v2.3.3/stack-2.3.3-linux-x86_64-bin -o ~/.local/bin/stack
chmod u+x ~/.local/bin/stack
~/.local/bin/stack --resolver lts-16.14 install \
  alex \
  happy \
  hscolour

pushd /tmp
git clone --recurse-submodules --branch $BRANCH https://github.com/TerrorJack/ghc.git
popd

export PATH=~/.local/bin:$(~/.local/bin/stack path --compiler-bin):$PATH
mv .github/workflows/build-linux-dwarf.mk /tmp/ghc/mk/build.mk
pushd /tmp/ghc
./boot
./configure --enable-dwarf-unwind
make
make binary-dist
mkdir ghc-bindist
mv *.tar.* ghc-bindist/
(ls -l ghc-bindist && sha256sum -b ghc-bindist/*) > ghc-bindist/sha256.txt
popd

mv /tmp/ghc/ghc-bindist .

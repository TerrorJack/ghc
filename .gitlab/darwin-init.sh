#!/bin/bash

set -e

toolchain=`pwd`/toolchain
PATH="$toolchain/bin:$PATH"

if [ -d "`pwd`/cabal-cache" ]; then
    cp -Rf cabal-cache $HOME/.cabal
fi

if [ ! -e $toolchain/bin/ghc ]; then
    mkdir -p tmp
    cd tmp
    ghc_tarball="https://downloads.haskell.org/~ghc/$GHC_VERSION/ghc-$GHC_VERSION-x86_64-apple-darwin.tar.xz"
    echo "Fetching GHC from $ghc_tarball"
    curl $ghc_tarball | tar -xJ
    cd ghc-$GHC_VERSION
    ./configure --prefix=$toolchain
    make install
    cd ../..
    rm -Rf tmp
fi

if [ ! -e $toolchain/bin/cabal ]; then
    cabal_tarball="https://downloads.haskell.org/~cabal/cabal-install-$CABAL_INSTALL_VERSION/cabal-install-$CABAL_INSTALL_VERSION-x86_64-apple-darwin-sierra.tar.xz"
    echo "Fetching cabal-install from $cabal_tarball"
    curl $cabal_tarball | tar -xz
    mv cabal $toolchain/bin
fi

if [ ! -e $toolchain/bin/happy ]; then
    cabal update
    cabal new-install happy --symlink-bindir=$toolchain/bin
fi

if [ ! -e $toolchain/bin/alex ]; then
    cabal update
    cabal new-install alex --symlink-bindir=$toolchain/bin
fi


#!/bin/bash -e

. ../../include/depinfo.sh
. ../../include/path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$ndk_suffix
	exit 0
else
	exit 255
fi

[ -f configure ] || CFLAGS=-fPIC CXXFLAGS=-fPIC ./autogen.sh \
    --host=$ndk_triple \
    --disable-shared \
    --enable-static \
    --with-minimum \
    --with-threads \
    --with-tree \
    --without-lzma
    
mkdir -p _build$ndk_suffix
cd _build$ndk_suffix

 ../configure
make -j$cores
make DESTDIR="$prefix_dir" install

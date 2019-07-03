#!/bin/sh

set -o xtrace

VER=${VER:-1.5.8}
SRC=src-norm-$VER.tgz
SRCDIR=norm-$VER
URI=https://downloads.pf.itd.nrl.navy.mil/norm/src-norm-$VER.tgz
MAINT="NRL Networks and Communication Systems Branch <norm_info@nrl.navy.mil>"
BUILDDATE=$(date -R)

if [ -d PKG ]; then
    echo "Directory 'PKG' exists.  Aborting."
    exit 255
fi

BUILDROOT=$(pwd)

mkdir -p PKG/inst

cd PKG
wget $URI
tar xvf $SRC

(cd $SRCDIR

./waf configure --prefix=/usr
./waf build
./waf install --destdir=$BUILDROOT/PKG/inst)

(cd inst

mkdir -p DEBIAN

cat > DEBIAN/control << EOF
Package: norm
Version: $VER-1
Section: net
Priority: optional
Architecture: $(dpkg --print-architecture)
Maintainer: $MAINT
Description: NACK-Oriented Reliable Multicast (NORM)
 The NORM protocol is designed to provide end-to-end reliable transport of bulk
 data objects or streams over generic IP multicast routing and forwarding
 services.
EOF

cat > DEBIAN/triggers << EOF
activate-noawait ldconfig
EOF

cat > DEBIAN/shlibs << EOF
libnorm 1 norm (>= 1.0.0)
EOF

DOCDIR=usr/share/doc/norm
mkdir -p $DOCDIR

cat > $DOCDIR/copyright << EOF
norm

Copyright: This work is in the public domain (US Government)
EOF
cat ../$SRCDIR/LICENSE.TXT >> $DOCDIR/copyright

cp ../$SRCDIR/VERSION.TXT $DOCDIR/changelog
gzip $DOCDIR/changelog

cat > $DOCDIR/changelog.Debian << EOF
norm (1:$VER-1) release; urgency=low
 * Debian maintainer and upstream author are identical.
   Therefore see also normal changelog file for Debian changes.

 -- $MAINT  $BUILDDATE
EOF
gzip $DOCDIR/changelog.Debian
)

dpkg-deb --build inst
mv inst.deb $SRCDIR.deb

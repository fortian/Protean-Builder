#!/bin/sh

set -o xtrace

# This assumes we're in /root
cd /root

NAME=norm
VER=${VER:-1.5.8}
SRC=src-$NAME-$VER.tgz
SRCDIR=$NAME-$VER
URI=https://downloads.pf.itd.nrl.navy.mil/$NAME/$SRC
MAINT="NRL Networks and Communication Systems Branch <norm_info@nrl.navy.mil>"
BUILDDATE=$(date "+%a %b %d %Y")

if [ -d PKG ]; then
    echo "Directory 'PKG' exists.  Aborting."
    exit 255
fi

mkdir -p PKG/$NAME/SPECS
mkdir -p PKG/$NAME/SOURCES
ln -s PKG/$NAME /root/rpmbuild

(cd PKG/$NAME/SOURCES
wget $URI)

(cd PKG/$NAME/SPECS

cat > $NAME.spec << EOF
%define name $NAME
%define release 1%{?dist}
%define version $VER

Summary: NACK-Oriented Reliable Multicast (NORM) Library
License: Public Domain
URL: https://www.nrl.navy.mil/itd/ncs/products/norm
Name: %{name}
Version: %{version}
BuildRequires: gcc-c++
BuildRequires: make
Release: %{release}
Source0: src-%{name}-%{version}.tgz
Prefix: /usr

%description

The NORM protocol is designed to provide end-to-end reliable transport of bulk
 data objects or streams over generic IP multicast routing and forwarding
 services.

%prep
%setup -n %{name}-%{version}

%build
#echo "Using:"
#echo " _prefix: %{_prefix}"
#echo " _libdir: %{_libdir}"
#echo " buildroot: %{buildroot}"
./waf configure --prefix=%{_prefix} --libdir=%{_libdir}
./waf build

%install
#echo "Installing in %{buildroot}"
./waf install --destdir=%{buildroot}

%files
%defattr(-,root,root)
/usr/include/normApi.h
%{_libdir}/libnorm.so
%{_libdir}/libnorm.so.1
%{_libdir}/libnorm.so.1.5.8

%changelog
* $BUILDDATE $MAINT - $VER
- Initial release
EOF

 rpmbuild -bs $NAME.spec
 rpmbuild -bb $NAME.spec
)

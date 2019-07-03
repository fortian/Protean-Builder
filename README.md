# Protean-Builder

Requirements
------------

* Docker
* User with access to Docker containers

Usage
-----

For example, to build norm on all CentOS and Ubuntu:

```
$ cd software-builds
$ [CENTOS=<0|1>|UBUNTU=<0|1>] ./build-all-norm.sh
$ find ./packages
./packages
./packages/RPMS
./packages/RPMS/x86_64
./packages/RPMS/x86_64/norm-debuginfo-1.5.8-1.el7.x86_64.rpm
./packages/RPMS/x86_64/norm-1.5.8-1.el7.x86_64.rpm
./packages/RPMS/x86_64/norm-debuginfo-1.5.8-1.el6.x86_64.rpm
./packages/RPMS/x86_64/norm-1.5.8-1.el6.x86_64.rpm
./packages/RPMS/i686
./packages/RPMS/i686/norm-1.5.8-1.el6.i686.rpm
./packages/RPMS/i686/norm-debuginfo-1.5.8-1.el7.i686.rpm
./packages/RPMS/i686/norm-debuginfo-1.5.8-1.el6.i686.rpm
./packages/RPMS/i686/norm-1.5.8-1.el7.i686.rpm
./packages/SRPMS
./packages/SRPMS/norm-1.5.8-1.el7.src.rpm
./packages/SRPMS/norm-1.5.8-1.el6.src.rpm
./packages/DEB
./packages/DEB/norm-1.5.8-bionic-i386.deb
./packages/DEB/norm-1.5.8-cosmic-amd64.deb
./packages/DEB/norm-1.5.8-cosmic-i386.deb
./packages/DEB/norm-1.5.8-trusty-amd64.deb
./packages/DEB/norm-1.5.8-xenial-i386.deb
./packages/DEB/norm-1.5.8-xenial-amd64.deb
./packages/DEB/norm-1.5.8-disco-amd64.deb
./packages/DEB/norm-1.5.8-trusty-i386.deb
./packages/DEB/norm-1.5.8-disco-i386.deb
./packages/DEB/norm-1.5.8-bionic-amd64.deb

```

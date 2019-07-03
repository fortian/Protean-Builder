#!/bin/bash

# Default to building both CentOS and Ubuntu
CENTOS=${CENTOS:-1}
UBUNTU=${UBUNTU:-1}

SDIR=$(pwd)
mkdir -p packages

# First start with CentOS:

if [ "$CENTOS" = 1 ]; then
    (cd ../docker-builds/centos
    
    for i in *; do
        if [ -d $i ]; then
            (cd $i
             CTR=$i-build
             make start
             docker cp $SDIR/rpm/norm_build_rpm.sh $CTR:/root/
             docker exec -i -t $CTR /root/norm_build_rpm.sh
             docker cp -a $CTR:/root/rpmbuild/RPMS $SDIR/packages
             docker cp -a $CTR:/root/rpmbuild/SRPMS $SDIR/packages
             make rmcont
            )
        fi
    done
    )
else
    echo "Not building CentOS packages by user request"
fi

# Next Ubuntu
if [ "$UBUNTU" = 1 ]; then
    (cd ../docker-builds/ubuntu
    for i in *; do
        if [ -d $i ]; then
            (cd $i
             CTR=$i-build
             make start
             docker cp $SDIR/deb/norm_build_deb.sh $CTR:/root/
             docker exec -i -t $CTR /root/norm_build_deb.sh
             docker cp -a $CTR:/root/PKG/DEB $SDIR/packages
             make rmcont
            )
        fi
    done
    )
else
    echo "Not building Ubuntu packages by user request"
fi

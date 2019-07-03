#!/bin/bash

# First start with CentOS:
SDIR=$(pwd)
mkdir -p packages

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

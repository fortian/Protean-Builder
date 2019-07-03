FROM i386/centos:centos6

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/\$arch/i686/g' /etc/yum.repos.d/*
RUN sed -i 's/\$basearch/i386/g' /etc/yum.repos.d/*
RUN yum -y install gcc make rpm-build tar libnetfilter queue-devel libpcap-devel gcc-c++ doxygen rpmdevtools wget vim 

CMD ["/bin/bash"]

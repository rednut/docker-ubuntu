# customise a stock ubuntu for use as base image
#
FROM ubuntu:latest
MAINTAINER Dotcomstu <stuart@rednut.net>

# set non interactive
ENV DEBIAN_FRONTEND noninteractive 

# add stock local ubuntu apt repos list
ADD 	apt/ubuntu-sources.list /etc/apt/sources.list

# add local apt-cacher-ng repo
ADD	apt/apt-cacher-ng.conf /etc/apt/apt.conf.d/01proxy


# fix runing in docker
RUN 	dpkg-divert --local --rename --add /sbin/initctl
RUN 	ln -sf /bin/true /sbin/initctl

# set local
RUN 	locale-gen en_GB en_GB.UTF-8

# set correct time zone
RUN 	echo "Europe/London" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

# standard directories
RUN	mkdir -p /data /etc/apt/apt.conf.d/ 


# stop running services on install
#ENV RUNLEVEL 1

RUN	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 16126D3A3E5C1192
RUN     apt-mark hold initscripts udev plymouth mountall
RUN	apt-get update -q -y && \
	apt-get -qy --force-yes dist-upgrade && \
	apt-get install -q -y \
		curl wget supervisor apt-utils lsb-release curl wget rsync bzip2 \
		unrar rar unzip vim-nox util-linux tar ca-certificates curl lsb-release \
		binutils binfmt-support zip git vim-nox 





# generic data sharing persistenace volume
VOLUME /data




# customise a stock ubuntu for use as base image
#
FROM ubuntu:latest
MAINTAINER Dotcomstu <stuart@rednut.net>

# set non interactive
ENV DEBIAN_FRONTEND noninteractive 

# fix runing in docker
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# set local
RUN locale-gen en_GB en_GB.UTF-8

# set correct time zone
RUN echo "Europe/London" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# update apt repos
RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install git vim-nox rsync curl lsb-release

# generic data sharing persistenace volume
RUN mkdir -p /data
VOLUME /data




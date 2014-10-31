#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER stuart nixon <dotcomstu@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#-qy
# Keep upstart from complaining
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -sf /bin/true /sbin/initctl

# set locale
#RUN locale-gen en_GB en_GB.UTF-8

# set correct time zone
#RUN     echo "Europe/London" > /etc/timezone && \
#        dpkg-reconfigure -f noninteractive tzdata


# Install.
RUN \
  locale-gen en_GB en_GB.UTF-8 && \
  echo "Europe/London" > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -qy build-essential && \
  apt-get install -qy software-properties-common && \
  apt-get install -qy byobu curl git htop man unzip vim wget rsync && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

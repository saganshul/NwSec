# Description:
#   This runtime environment example Dockerfile creates a container with a telnet server and a ssh server
# Usage:
#   From this directory, run $ docker build -t tnfssvr_plus_termsvr .
#   By default, runs as root
# https://www.gnu.org/software/inetutils/
# https://ubuntu.com/server/docs/service-openssh

FROM ubuntu:20.04

#https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#avoid question/dialog during apt-get installs
ARG DEBIAN_FRONTEND noninteractive

# Setup container's ENV for systemd
ENV container docker

#update
RUN apt-get update

#install utilities
RUN apt-get install apt-utils dpkg-dev debconf debconf-utils -y
RUN apt-get install net-tools iputils-ping iptables iproute2 wget nmap bind9-dnsutils dnsutils inetutils-traceroute openssh-server isc-dhcp-common -y
RUN apt-get install vim acl sudo telnet ssh netcat nfs-common -y

#install dependencies for systemd and syslog
RUN apt-get install systemd systemd-sysv syslog-ng syslog-ng-core syslog-ng-mod-sql syslog-ng-mod-mongodb -y

VOLUME [ "/tmp", "/run", "/run/lock" ]
# Remove unnecessary units
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp*
CMD [ "/lib/systemd/systemd", "log-level=info", "unit=sysinit.target" ]

#install all the things (inetutils-inetd, openssh-server)
RUN apt-get install inetutils-inetd inetutils-telnetd -y
RUN apt-get install openssh-server -y

#install all the things (nfs server)
RUN apt-get install nfs-kernel-server -y

#update configuration files for termsvr
COPY etc_ssh_sshd_config /etc/ssh/sshd_config
COPY etc_inetd.conf /etc/inetd.conf

#update configuration files for nfssvr
COPY etc_exports /etc/exports
COPY etc_fstab /etc/fstab

#create a user student with password nwsec
RUN useradd -m student
RUN echo 'student:nwsec' | chpasswd
RUN useradd -m john
RUN echo 'john:password' | chpasswd
RUN useradd -m jane
RUN echo 'jane:password' | chpasswd

# Finished!
RUN echo $'\n\
* Container is ready, run it using $ docker run -d --name nfssvr_plus_termsvr --hostname nfssvr-plus-termsvr --add-host nfssvr-plus-termsvr.netsec-docker.isi.jhu.edu:127.0.1.1 --dns 192.168.25.10 --dns-search netsec-docker.isi.jhu.edu --privileged -v /export/nfsshare:/export/nfsshare:rw -v /nfsshare:/nfsshare:rw -v /sys/fs/cgroup:/sys/fs/cgroup:ro --network host --cpus=1 tnfssvr_plus_termsvr:latest \n\
* Attach to it using $ docker exec -it nfssvr_plus_termsvr bash \n\
* Enable the telnet service using # systemctl enable inetutils-inetd \n\
* Enable the ssh service using # systemctl enable ssh \n\
* Start the telnet service using # systemctl start inetutils-inetd \n\
* Start the ssh service using # systemctl start ssh \n\
* inetutils-inetd status is available using # systemctl status inetutils-inetd \n\
* openssh-server status is available using # systemctl status ssh \n\
* inetutils-inetd can be stopped and started as well using systemctl \n\
* openssh-server can be stopped and started as well using systemctl \n\
* telnet into the server by running $ telnet CONTAINERIPADDRESS \n\
* ssh into the server by running $ ssh student@CONTAINERIPADDRESS \n\
* nfs-kernel-server status is available using # systemctl status nfs-kernel-server \n\
* nfs-kernel-server can be stopped and started as well using systemctl \n\
* On the VM hosting this nfs server, create the /nfsshared directory for the volume shared with the container \n\
* On the client, create /mnt/nfs and mount using $ sudo mount -vvvv -t nfs -o proto=tcp,port=2049 nfs.nwsecdocker.jhu.edu:/nfsshare /mnt/nfs'

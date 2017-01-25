FROM debian:jessie
MAINTAINER Kolja Dummann <kolja.dummann@logv.ws>
ADD ./backports.list /etc/apt/sources.list.d/backports.list
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk \
	ant \
	build-essential \
	bison \
	ca-certificates \
	curl \
	flex \
	g++ \
	gcc \
	gdb \
	git \
	libz-dev \
	libwww-perl \
	libxerces-c-dev \
	make \
	g++-multilib \
	libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 \
	patch \
	subversion \
	unzip \
	wget \
	xvfb \
	zip

RUN apt-get autoremove
RUN cd /tmp && \
	wget https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 && \
	tar -xjvf linux-amd64-github-release.tar.bz2 && \
	mv bin/linux/amd64/github-release /usr/bin/ && \
	rm -rf bin/
RUN mkdir -p /root/.ssh
ADD ./sshconfig /root/.ssh/config
RUN chmod +x /start
VOLUME ["/build"]
WORKDIR /build
ENTRYPOINT ["/bin/bash"]
COPY ./bin/* /usr/bin/
RUN chmod +x /usr/bin/*

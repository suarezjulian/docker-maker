FROM ubuntu:20.04

WORKDIR /usr/src

#install basic packages
RUN apt update && \
    apt install -y git rsync build-essential


#install SNAP
RUN git clone --recursive https://github.com/KorfLab/SNAP.git && \
	cd SNAP && \
	git reset --hard daf76badb477d22c08f2628117c00e057bf95ccf && \
	make && \
	cd ..
ENV ZOE="/usr/src/SNAP/Zoe"

#install Augustus
RUN apt install -y augustus augustus-data augustus-doc
ENV AUGUSTUS_CONFIG_PATH /usr/share/augustus/config

#DBI perl module is necessary for autoAug
ENV PERL_MM_USE_DEFAULT=1
RUN cpan DBI
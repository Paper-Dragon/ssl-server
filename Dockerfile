FROM docker.io/library/rockylinux:9.0 as lowerpack
LABEL maintainer="Build From PaperDragon <2678885646@qq.com>"
ARG CFSSL_VERSION 1.6.3
ARG OS rockylinux:9.0-minimal
ARG PROJECT git@github.com:cloudflare/cfssl.git
COPY file/cfssl_bin/* /usr/bin/
COPY file/colorls.sh /etc/profile.d/
COPY file/colorls.csh /etc/profile.d/

RUN yum makecache && \
	yum install sqlite -y 
RUN mkdir -p /workdir/{db,sql,cfssl}
COPY file/sql/ /workdir/sql
COPY cfssl /workdir/cfssl
RUN ls -l && cd /workdir/db && cat /workdir/sql/* | sqlite3 certdb.db && cd /workdir
WORKDIR /workdir

EXPOSE 8888
#ENTRYPOINT 
#CMD 

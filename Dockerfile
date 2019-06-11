FROM centos
MAINTAINER  dileep<dileep.thati@gmail.com>

RUN yum install wget gnutls-c++.x86_64 gnutls-utils.x86_64 gcc.x86_64 -y

WORKDIR /
RUN wget http://download.redis.io/releases/redis-3.0.7.tar.gz && \
    tar xzvf redis-3.0.7.tar.gz && \
    cd redis-3.0.7 && \
    cd deps && \
    make hiredis jemalloc linenoise lua && \
    cd .. && \ 
    make && \
    make install
RUN yes '' | sh /redis-3.0.7/utils/install_server.sh
ENTRYPOINT ["/usr/local/bin/redis-server"]
RUN echo -e "\n" && \ 
    /usr/local/bin/redis-cli

EXPOSE 9090

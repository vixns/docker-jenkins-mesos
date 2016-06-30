FROM java:jdk
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
 build-essential python-dev libcurl4-openssl-dev libsasl2-dev \
 libsasl2-modules maven libapr1-dev libsvn-dev libssl-dev libevent-dev \
 libz-dev libnl-3-dev libnl-route-3-dev libnl-idiag-3-dev \
 libblkid-dev libelf-dev autoconf automake libtool git

RUN git clone https://git-wip-us.apache.org/repos/asf/mesos.git mesos
RUN cd mesos && mkdir build && ./bootstrap && cd build && \
  ../configure --enable-ssl --enable-libevent --prefix=/usr --enable-optimize --enable-silent-rules && \
  make -j $(nproc) V=0 install

RUN dpkg --purge build-essential python-dev libcurl4-openssl-dev libsasl2-dev libz-dev \
  libnl-3-dev libnl-route-3-dev libnl-idiag-3-dev libblkid-dev \
  libelf-dev autoconf automake libtool && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /mesos

ADD http://mirrors.jenkins-ci.org/war/2.11/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /var/lib/jenkins

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
CMD [""]
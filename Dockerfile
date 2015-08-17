# OpenAM Enterprise Subscription Docker image
# Version 1

# If you loaded redhat-rhel-server-7.0-x86_64 to your local registry, uncomment
# this FROM line instead:
# FROM registry.access.redhat.com/rhel 
# Pull the rhel image from the local repository
FROM rhel

MAINTAINER Kim Daniel Engebretsen 

# Update image
RUN yum update -y
RUN yum install -y unzip openssl java-1.7.0-openjdk #-devel # java-1.7.0-oracle-devel
RUN yum clean all

ENV ADMIN_PW Secret1
ENV KEYSTORE_PW Secret1

RUN mkdir -p /opt/openidm
WORKDIR /opt/openidm
ADD openidm-3.1.0.zip /opt/openidm/
RUN unzip openidm-3.1.0.zip -d /opt/
ADD . /opt/openidm/
RUN rm -rf samples; rm openidm-3.1.0.zip;

CMD ["/opt/openidm/run.sh"]

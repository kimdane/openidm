# OpenAM Enterprise Subscription Docker image
# Version 1

# If you loaded redhat-rhel-server-7.0-x86_64 to your local registry, uncomment
# this FROM line instead:
# FROM registry.access.redhat.com/rhel 
# Pull the rhel image from the local repository
FROM conductdocker/rhel7

MAINTAINER Kim Daniel Engebretsen 

# Update image (done in base image)
#RUN yum update -y
#RUN yum install -y unzip openssl java-1.7.0-openjdk #-devel # java-1.7.0-oracle-devel
#RUN yum clean all

ENV ADMIN_PW Secret1
ENV KEYSTORE_PW Secret1

RUN mkdir -p /opt/openidm
WORKDIR /opt/openidm
ADD openidm.zip /opt/openidm/
RUN unzip openidm.zip -d /opt/
RUN mv -f samples/fullStack/conf/* conf/;mv -f samples/fullStack/conf/boot/* conf/boot/; mv -f samples/fullStack/script/* script/; rm -rf samples; rm openidm.zip;
ADD run.sh /opt/openidm/run.sh
ADD conf/prov* conf/
ADD conf/sync.json conf/
ADD conf/authentication.json conf/

EXPOSE 8443 8080
CMD ["/opt/openidm/run.sh"]

FROM java:8

MAINTAINER kimdane
WORKDIR /opt

ENV openidm=/opt/openidm
ENV openidmconf=/opt/repo/openidm
ENV openidmbin=/opt/repo/bin/openidm
ENV openidmzip=/opt/repo/bin/zip/openidm.zip

EXPOSE 8080

ADD run-openidm.sh /opt/run-openidm.sh
VOLUME ["/opt/repo"]

CMD  ["/opt/run-openidm.sh"]

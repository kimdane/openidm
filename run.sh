#!/bin/sh
#cat /etc/hosts
#openssl s_client -connect dj:636
#while :; do
#curl -v ldap://dj
#sleep 5;
#done;
nohup /opt/openidm/startup.sh &
touch /opt/openidm/logs/openidm0.log.0
tail -f /opt/openidm/logs/openidm0.log.0

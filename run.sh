#!/bin/sh
nohup /opt/openidm/startup.sh &
touch /opt/openidm/logs/server.out
tail -f /opt/openidm/logs/server.out

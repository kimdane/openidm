#!/bin/bash

cd /opt
mkdir staging
file=/opt/repo/bin/staging/openidm.zip
if [ -s "$file" ]; then
	cp "$file" staging/openidm.zip
else
	curl -o /tmp/getnightly.sh https://raw.githubusercontent.com/ForgeRock/frstack/master/bin/getnightly.sh
   	chmod +x /tmp/getnightly.sh
   	/tmp/getnightly.sh openidm
fi

unzip staging/openidm.zip
rm -f staging/openidm.zip
rm -r /opt/openidm/samples

# Copy directories from repo if available
dir=/opt/repo/openidm/security/
if [ -e "$dir" ]; then
	cp -rv /opt/repo/openidm/security/* /opt/openidm/security/
fi
dir=/opt/repo/openidm/ui/
if [ -e "$dir" ]; then
	cp -rv /opt/repo/openidm/ui/* /opt/openidm/ui/
fi
dir=/opt/repo/openidm/conf/
if [ -e "$dir" ]; then
	cp -rv /opt/repo/openidm/conf/* /opt/openidm/conf/
fi
dir=/opt/repo/openidm/script/
if [ -e "$dir" ]; then
	cp -rv /opt/repo/openidm/script/* /opt/openidm/script/
fi

# Remove the Orient DB and use postgres as DB if it is configured
file=/opt/openidm/conf/repo.jdbc.json
if [ -s "$file" ]; then
	rm /opt/openidm/conf/repo.orientdb.json
fi

#dir=/opt/repo/openidm/security/
#if [ -e "$dir" ]; then
#	/opt/openidm/startup.sh -P /opt/repo/openidm
#else
#	/opt/openidm/startup.sh
#fi
/opt/openidm/startup.sh

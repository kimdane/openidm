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

unzip staging/openidm.zip -x *samples*
rm -f staging/openidm.zip

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

# Remove the Orient DB in older releases and use postgres as DB if it is configured
file=/opt/openidm/conf/repo.jdbc.json
if [ -s "$file" ]; then
	rm /opt/openidm/conf/repo.orientdb.json
fi

file=/opt/openidm/resolver/boot.properties
if [ -s "$file" ]; then
	sed -i 's/openidm.host=localhost/openidm.host=iam.example.com/' /opt/openidm/resolver/boot.properties
fi

file=/opt/repo/ssl/combined.pem
if [ -s "$file" ]; then
	export FQDN=$(openssl x509 -noout -subject -in /opt/repo/ssl/combined.pem | sed "s/^.*CN=\*\./iam./" | sed "s/^.*CN=//" | sed "s/\/.*$//")
	export DOMAIN=$(echo $FQDN | sed "s/[^\.]*\.//")
	cat /opt/openidm/conf/authentication.json | sed 's/iam.example.com/'$DOMAINNAME'/' | sed 's/example.com/'$DOMAIN'/' > /opt/openidm/conf/authentication.json
fi

#dir=/opt/repo/openidm/security/
#if [ -e "$dir" ]; then
#	/opt/openidm/startup.sh -P /opt/repo/openidm
#else
#	/opt/openidm/startup.sh
#fi
/opt/openidm/startup.sh

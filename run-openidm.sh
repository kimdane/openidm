#!/bin/bash

# openidm=/opt/openidm
# openidmconf=/opt/repo/openidm
# openidmbin=/opt/repo/bin/openidm
# openidmzip=/opt/repo/bin/zip/openidm.zip

if [ -e "$openidmbin" ]; then
	cp -r $openidmbin $openidm
else
	if [ -s "$openidmzip" ]; then
		unzip $openidmzip -d /opt/
	else
		echo "Did not find any openidm folder at $openidmbin, and don't have any open access to zipfile $openidmzip"	
		exit 1
	fi
fi

# Copy config from repo over the newly copied openidm folder
if [ -e "$openidmconf" ]; then
	cp -r $openidmconf/* $openidm/
fi

# Get fully qualified domain name from SSL certificate
cert=/opt/repo/ssl/combined.pem
file=$openidm/resolver/boot.properties
if [ -s "$cert" ] && [ -s "$file" ]; then
	export FQDN=$(openssl x509 -noout -subject -in /opt/repo/ssl/combined.pem | sed "s/^.*CN=\*\./iam./" | sed "s/^.*CN=//" | sed "s/\/.*$//")
	sed -i 's/openidm.host=localhost/openidm.host=$FQDN/' $file
fi

cd $openidm
./startup.sh

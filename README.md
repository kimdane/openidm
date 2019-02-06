# Dockerfile for creating a ForgeRock OpenIDM nightly build

Mount your custom config on /opt/openidm/conf.


Ready for fullStack example of ForgeRocks Identity Stack Dockerized
https://github.com/kimdane/identity-stack-dockerized.git

docker run -d --name postgres -e POSTGRES_PASSWORD=openidm -e POSTGRES_USER=openidm -v /var/lib/id-stack/repo/postgres:/docker-entrypoint-initdb.d postgres
docker run --link opendj --link postgres --name openidm -v /var/lib/id-stack/repo:/opt/repo kimdane/openidm-nightly

or stand-alone (without latest schema updates for DB)

docker run -d --name postgres -e POSTGRES_PASSWORD=openidm -e POSTGRES_USER=openidm postgres
docker run --link postgres --name openidm kimdane/openidm-nightly


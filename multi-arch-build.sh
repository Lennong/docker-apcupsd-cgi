docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -f Dockerfile -t lennong05/apcupsd-cgi . --push --no-cache

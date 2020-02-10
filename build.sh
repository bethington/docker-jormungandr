#!/bin/bash
docker build -t bethington/jormungandr:v0.8.9 --build-arg BUILD=true --build-arg VER=v0.8.9 ./git/docker/.
docker run -v ~/docker/jormungandr/cfg:/app/cfg -v ~/docker/jormungandr/secret:/app/secret -v ~/docker/jormungandr/data:/app/bin/data -it bethington/jormungandr:v0.8.9 /bin/sh ./bootstrap -p 8448 -x -c /app/cfg -k /app/secret

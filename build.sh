#!/bin/bash
docker build -t bethington/jormungandr:v0.8.9 --build-arg BUILD=true --build-arg VER=v0.8.9 ./git/docker/.

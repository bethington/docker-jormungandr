#!/bin/bash
HOST_IP="$(getent hosts jormungandr | awk '{ print $1 }')"
cd $HOME/data
bootstrap > bootstrap.txt
cat bootstrap.txt
mv config.yaml config.yaml.example
sed "s/127.0.0.1/${HOST_IP}/g" config.yaml.example > config.yaml
jormungandr --genesis-block ./block-0.bin --config ./config.yaml --secret ./pool-secret1.yaml

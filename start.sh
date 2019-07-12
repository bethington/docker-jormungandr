#!/bin/bash
cd $HOME/data
bootstrap > bootstrap.txt
cat bootstrap.txt
sed "s/127.0.0.1/jormungandr/g" config.yaml
jormungandr --genesis-block ./block-0.bin --config ./config.yaml --secret ./pool-secret1.yaml

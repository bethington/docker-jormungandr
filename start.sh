#!/bin/bash
cd $HOME/data
bootstrap > bootstrap.txt
cat bootstrap.txt
jormungandr --genesis-block ./block-0.bin --config ./config.yaml --secret ./pool-secret1.yaml

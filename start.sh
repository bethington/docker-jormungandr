#!/bin/bash
bootstrap > bootstrap.txt
cat bootstrap.txt
jormungandr --genesis-block ./data/block-0.bin --config ./config.yaml --secret ./pool-secret1.yaml

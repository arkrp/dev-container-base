#!/usr/bin/bash
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
echo $SCRIPT_DIR
sudo docker build --no-cache -t dev-container-base $SCRIPT_DIR

#!/usr/bin/bash
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
echo $SCRIPT_DIR
podman build --jobs 0 -t dev-container-base $SCRIPT_DIR

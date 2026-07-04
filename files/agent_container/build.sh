#!/usr/bin/bash
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
podman build \
   --cgroup-manager=cgroupfs \
   --jobs 0 \
   -t pi_agent_container \
   $SCRIPT_DIR
podman save pi_agent_container > ./pi_agent_container.image

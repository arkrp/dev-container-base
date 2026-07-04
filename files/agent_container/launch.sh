#!/usr/bin/bash
podman load -i pi_agent_container.image
podman run \
   -it \
   pi_agent_container

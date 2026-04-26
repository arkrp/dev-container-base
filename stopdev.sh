#!/usr/bin/bash
podman stop dev -t 5
podman container stop dev
podman container prune --force

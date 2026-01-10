#!/bin/bash
echo "development container online!"
chmod 0755 /var/run/sshd
echo "to use this container, connect via ssh"
/usr/sbin/sshd -D
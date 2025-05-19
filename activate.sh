#!/bin/bash
echo "dockertest online!"
mkdir /var/run/sshd
chmod 0755 /var/run/sshd
echo "to use this container, connect via ssh"
/usr/sbin/sshd -D
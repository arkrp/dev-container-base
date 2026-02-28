#!/bin/bash
echo "development container online!"
chmod 0755 /var/run/sshd
echo "to use this container, connect via ssh"
primary_username=$(cat /app/primary_username.txt)
cp -R /app/config/ssh /home/$primary_username/.ssh
chown -R $primary_username:$primary_username /home/$primary_username/.ssh
/usr/sbin/sshd -D

#!/usr/bin/bash
project_directory=$(realpath $(dirname $BASH_SOURCE))
sudo docker run -d -p 9000:22 -p 3939:3939\
    -v workspace:/home/hannahnelson/workspace\
    -v $project_directory/config:/app/config\
    --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined\
    --hostname dev --name dev dev-container-base
sleep 0.3
ssh -X -p 9000 hannahnelson@127.0.0.1

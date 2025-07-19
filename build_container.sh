#!/usr/bin/env bash

docker run -d \
    --name ubuntu-dev \
    --gpus all \
    --device /dev/dri \
    -e HOST_UID=$(id -u) \
    -e HOST_GID=$(id -g) \
    -e DISPLAY=$DISPLAY \
    -e XDG_RUNTIME_DIR=/tmp/runtime-$(id -u) \
    -v ~/workspace:/home/aditya/workspace \
    -v ~/.ssh:/home/aditya/.ssh:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /dev/dri:/dev/dri \
    --security-opt seccomp=unconfined \
    --cap-add SYS_ADMIN \
    ubuntu-dev tail -f /dev/null

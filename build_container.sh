#!/usr/bin/env bash

# Default container name
CONTAINER_NAME="ubuntu-dev"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --name)
            CONTAINER_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--name <container-name>]"
            exit 1
            ;;
    esac
done

docker run -d \
    --name "$CONTAINER_NAME" \
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

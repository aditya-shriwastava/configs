#!/usr/bin/env bash

# Function to display help
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Create and run a Docker container for development with GPU support.

OPTIONS:
    -h, --help              Show this help message and exit
    --name <name>           Container name (default: ubuntu-dev)

DESCRIPTION:
    This script creates a Docker container with:
    - GPU support (all GPUs)
    - X11 forwarding for GUI applications
    - Mounted workspace directory (~/workspace)
    - Read-only SSH keys mount
    - OpenGL/Mesa support
    - User ID/GID mapping for file permissions

EXAMPLE:
    $(basename "$0")                    # Create container with default name
    $(basename "$0") --name mydev       # Create container with custom name

EOF
}

# Default container name
CONTAINER_NAME="ubuntu-dev"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --name)
            CONTAINER_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--name <container-name>]"
            echo "Try '$0 --help' for more information."
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

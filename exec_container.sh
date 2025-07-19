#!/usr/bin/env bash

# Function to display help
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Execute an interactive bash shell in a running Docker container.

OPTIONS:
    -h, --help              Show this help message and exit
    --name <name>           Container name (default: ubuntu-dev)

DESCRIPTION:
    This script connects to a running Docker container and starts
    an interactive bash shell as the 'aditya' user.

EXAMPLE:
    $(basename "$0")                    # Connect to default container
    $(basename "$0") --name mydev       # Connect to custom named container

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

docker exec -u aditya -it "$CONTAINER_NAME" /bin/bash

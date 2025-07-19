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

docker exec -u aditya -it "$CONTAINER_NAME" /bin/bash

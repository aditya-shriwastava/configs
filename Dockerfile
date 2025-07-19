FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages and development tools
RUN apt-get update && apt-get install -y \
    wget curl git vim sudo build-essential openssh-client \
    ca-certificates locales bash tmux neovim ranger \
    software-properties-common dbus-x11 libgtk-3-0 libcanberra-gtk-module \
    iputils-ping net-tools dnsutils \
    mesa-utils libgl1-mesa-dri libglu1-mesa libglx-mesa0 \
    && add-apt-repository ppa:xtradeb/apps -y \
    && apt-get update \
    && apt-get install -y chromium \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create aditya user directly
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=aditya

# Remove any existing users with conflicting UID/GID
RUN # Remove existing user with UID 1000 if it exists \
    EXISTING_USER=$(getent passwd $USER_ID | cut -d: -f1 2>/dev/null || echo "") && \
    EXISTING_GROUP=$(getent group $GROUP_ID | cut -d: -f1 2>/dev/null || echo "") && \
    \
    # Remove existing user if present \
    if [ -n "$EXISTING_USER" ]; then \
        userdel -r $EXISTING_USER 2>/dev/null || true; \
    fi && \
    \
    # Remove existing group if present and not needed \
    if [ -n "$EXISTING_GROUP" ] && [ "$EXISTING_GROUP" != "$USERNAME" ]; then \
        groupdel $EXISTING_GROUP 2>/dev/null || true; \
    fi && \
    \
    # Create aditya group and user \
    groupadd -g $GROUP_ID $USERNAME && \
    useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy configs to aditya's home and install as aditya
COPY --chown=$USER_ID:$GROUP_ID . /home/$USERNAME/configs/
USER $USER_ID:$GROUP_ID
WORKDIR /home/$USERNAME

# Install development environment as root with proper HOME
USER root
RUN cd /home/$USERNAME/configs && \
    chmod +x install.sh && \
    HOME=/home/$USERNAME ./install.sh --non-interactive --skip-docker && \
    chown -R $USER_ID:$GROUP_ID /home/$USERNAME

# Create entrypoint script (back to root for user management)
USER root
COPY <<'EOF' /entrypoint.sh
#!/bin/bash
set -e

# Get user information from environment
USER_ID=${HOST_UID:-1000}
GROUP_ID=${HOST_GID:-1000}

# Check if aditya user exists, if not create it
if ! id aditya >/dev/null 2>&1; then
    # Remove existing users/groups with conflicting IDs
    EXISTING_USER=$(getent passwd $USER_ID | cut -d: -f1 2>/dev/null || echo "")
    EXISTING_GROUP=$(getent group $GROUP_ID | cut -d: -f1 2>/dev/null || echo "")
    
    if [ -n "$EXISTING_USER" ]; then
        userdel -r $EXISTING_USER 2>/dev/null || true
    fi
    
    if [ -n "$EXISTING_GROUP" ] && [ "$EXISTING_GROUP" != "aditya" ]; then
        groupdel $EXISTING_GROUP 2>/dev/null || true
    fi
    
    groupadd -g $GROUP_ID aditya 2>/dev/null || true
    useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash aditya 2>/dev/null || true
    echo "aditya ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
else
    # Update aditya's UID/GID if different from runtime values
    CURRENT_UID=$(id -u aditya)
    CURRENT_GID=$(id -g aditya)
    
    if [ "$CURRENT_UID" != "$USER_ID" ] || [ "$CURRENT_GID" != "$GROUP_ID" ]; then
        groupmod -g $GROUP_ID aditya 2>/dev/null || true
        usermod -u $USER_ID -g $GROUP_ID aditya 2>/dev/null || true
        
        # Fix ownership of home directory
        chown -R $USER_ID:$GROUP_ID /home/aditya
    fi
fi

# Create XDG runtime directory if it doesn't exist
if [ -n "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR"
    chown $USER_ID:$GROUP_ID "$XDG_RUNTIME_DIR"
    chmod 700 "$XDG_RUNTIME_DIR"
fi

# Switch to aditya user and execute command
exec su -l aditya -c "$*"
EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

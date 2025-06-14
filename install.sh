#!/usr/bin/env bash

set -e

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILES=(.tmux.conf .bashrc .gitconfig)

# -----------------------------
# Function: Install config file
# -----------------------------
install_config_file() {
    local file="$1"
    case "$file" in
        .bashrc)
            local SOURCE_LINE="source $CONFIG_DIR/.bashrc"
            if ! grep -Fxq "$SOURCE_LINE" "$HOME/.bashrc"; then
                echo "$SOURCE_LINE" >> "$HOME/.bashrc"
                echo "Added source line for .bashrc from configs to $HOME/.bashrc"
            else
                echo "Source line for .bashrc from configs already present in $HOME/.bashrc"
            fi
            ;;
        .tmux.conf)
            cp "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
            echo "Installed .tmux.conf to $HOME/.tmux.conf"
            ;;
        .gitconfig)
            cp "$CONFIG_DIR/.gitconfig" "$HOME/.gitconfig"
            echo "Installed .gitconfig to $HOME/.gitconfig"
            ;;
        *)
            cp "$CONFIG_DIR/$file" "$HOME/$file"
            echo "Installed $file to $HOME/$file"
            ;;
    esac
}

# -------------------------------------
# Function: Install Neovim init.vim
# -------------------------------------
install_neovim_init() {
    if [ -f "$CONFIG_DIR/init.vim" ]; then
        mkdir -p "$HOME/.config/nvim"
        cp "$CONFIG_DIR/init.vim" "$HOME/.config/nvim/init.vim"
        echo "Installed init.vim to $HOME/.config/nvim/init.vim"
    fi
}

# -----------
# Main Logic
# -----------
echo "Installing configs from $CONFIG_DIR"

for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$CONFIG_DIR/$file" ]; then
        install_config_file "$file"
    fi
 done

install_neovim_init

# ---------------------------------------
# Function: Ensure Vim/Neovim directories
# ---------------------------------------
ensure_vim_dirs() {
    mkdir -p "$HOME/.vim/backup" "$HOME/.vim/undo" "$HOME/.vim/swap"
    echo "Ensured Vim backup, undo, and swap directories exist"
    mkdir -p "$HOME/.local/share/nvim/backup" "$HOME/.local/share/nvim/undo" "$HOME/.local/share/nvim/swap"
    echo "Ensured Neovim backup, undo, and swap directories exist"
}

ensure_vim_dirs

# Optionally prompt to install dependencies
deps=(tmux neovim ranger)
missing=()
for dep in "${deps[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -gt 0 ]; then
    echo "The following tools are missing: ${missing[*]}"
    read -p "Do you want to install them now? [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        if command -v apt >/dev/null 2>&1; then
            sudo apt update
            sudo apt install -y "${missing[@]}"
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm "${missing[@]}"
        else
            echo "Please install the missing dependencies manually: ${missing[*]}"
        fi
    else
        echo "Skipping dependency installation."
    fi
else
    echo "All dependencies are installed."
fi

# Optionally install full package suite
full_package_list="build-essential cmake clang \
    tmux ranger neofetch git fzf net-tools htop wget curl zip unzip \
    python3 python3-dev python-is-python3 python3-pip python3-venv lsb-release"

echo
read -p "Do you want to install the full recommended package suite (dev tools, utilities, Python, etc.)? [y/N]: " install_all
if [[ "$install_all" =~ ^[Yy]$ ]]; then
    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y $full_package_list
    else
        echo "Automatic full package install only supported with apt. Please install manually if needed."
    fi
else
    echo "Skipping full package suite installation."
fi

# Install custom fzf key bindings if present
if [ -f "$CONFIG_DIR/fzf.bash" ]; then
    echo "Copying fzf.bash to /usr/share/doc/fzf/examples/key-bindings.bash (requires sudo)"
    sudo cp "$CONFIG_DIR/fzf.bash" /usr/share/doc/fzf/examples/key-bindings.bash
    echo "fzf.bash installed as key-bindings.bash"
fi

echo "Installation complete!"

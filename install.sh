#!/bin/bash


# Homebrew
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Skipping Homebrew, already installed"
fi

brew update && brew upgrade

# Node
if ! command -v dotnet >/dev/null 2>&1; then
    brew install dotnet
else
    echo "Skipping dotnet, already installed"
fi

# Dotnet
if ! command -v dotnet >/dev/null 2>&1; then
    brew install dotnet
else
    echo "Skipping dotnet, already installed"
fi

if ! command -v dotnet >/dev/null 2>&1; then
    echo ".NET Runtime not found. Installing via Homebrew..."
    brew install dotnet-runtime
else
    echo ".NET Runtime is already installed."
fi

if ! command -v dotnet >/dev/null 2>&1; then
    echo ".NET SDK not found. Installing via Homebrew..."
    brew install --cask dotnet-sdk
else
    echo ".NET SDK is already installed."
fi

# Rust
if ! command -v rustc >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
    echo "Skipping Rust, already installed"
fi

if ! command -v just >/dev/null 2>&1; then
    echo "just not found. Installing via Homebrew..."
    brew install just
else
    echo "just is already installed."
fi

if ! command -v sqlx >/dev/null 2>&1; then
    echo "sqlx-cli not found. Installing via Homebrew..."
    brew install sqlx-cli
else
    echo "sqlx-cli is already installed."
fi

# Dev tools
if ! command -v git >/dev/null 2>&1; then
    brew install git
else
    echo "Skipping git, already installed"
fi

if ! command -v zsh >/dev/null 2>&1; then
    echo "zsh not found. Installing..."
    brew install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "zsh is already installed."
fi

if ! command -v az >/dev/null 2>&1; then
    brew install azure-cli
else
    echo "Skipping azure-cli, already installed"
fi

if ! command -v ngrok >/dev/null 2>&1; then
    echo "ngrok not found. Installing via Homebrew..."
    brew install ngrok
else
    echo "ngrok is already installed."
fi

if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install
else
    echo "Skipping Xcode CLI tools, already installed"
fi

# Containers and stuff
if ! command -v orb >/dev/null 2>&1; then
    brew install --cask orbstack
else
    echo "Skipping OrbStack, already installed"
fi

if ! command -v kubectl >/dev/null 2>&1; then
    brew install kubernetes-cli
else
    echo "Skipping kubectl, already installed"
fi

if ! command -v kubelogin >/dev/null 2>&1; then
    echo "kubelogin not found. Installing via Homebrew..."
    brew install Azure/kubelogin/kubelogin
else
    echo "kubelogin is already installed."
fi

if ! command -v k9s >/dev/null 2>&1; then
    brew install k9s
else
    echo "Skipping k9s, already installed"
fi

# Vim 
if ! command -v nvim >/dev/null 2>&1; then
    brew install neovim
else
    echo "Skipping neovim, already installed"
fi

# Apps
if ! brew list --cask visual-studio-code-insiders >/dev/null 2>&1; then
    echo "Visual Studio Code Insiders not found. Installing via Homebrew..."
    brew install --cask visual-studio-code@insiders
else
    echo "Visual Studio Code Insiders is already installed."
fi

declare -a gui_apps=("visual-studio-code" "slack" "microsoft-teams" "brave-browser" "spotify" "obsidian" "iterm2" "signal" "postman" "parsec" "tiles")

for app in "${gui_apps[@]}"; do
    if ! brew list --cask "$app" >/dev/null 2>&1; then
        brew install --cask "$app"
    else
        echo "Skipping $app, already installed"
    fi
done

# Manual installs
echo ""
echo ""
echo "Manually installations"
echo "    - outlook from App Store"
echo "    - xcode from App Store"
echo "    - keynote from App Store"
echo ""
echo "Logins"
echo "    - vs code and sync extensions"
echo "    - rider"
echo "    - slack"
echo "    - teams"
echo "    - outlook"
echo "    - spotify"
echo ""
echo "Configuration"
echo "    - set iterm2 window transparrecy to 30"
echo "    - set desktop shortcuts: keyboard-shortcuts-mission control"
echo "    - set default desktops to certain apps"
echo "    - sync brave bookmarks"
echo "    - turn off auto rearrange desktops: desktop & dock, mission control, toggle of spaces after use"
echo "    - attach apps to certain desktops, and make them start on login"
echo "    - remap caps lock to esc"
echo "    - Azure VPN CLIENT for work!"
echo ""
echo "Pretty"
echo "    - change app icons"
echo "    - slack app theme black"
echo "    - add Code named folder under Documents, and add projects"
echo "    - "

#!/bin/bash


# Homebrew
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Skipping Homebrew, already installed"
fi

brew update && brew upgrade

# Node
if ! command -v node >/dev/null 2>&1; then
    brew install node
else
    echo "Skipping node, already installed"
fi

if ! command -v nvm >/dev/null 2>&1 && [ ! -d "$HOME/.nvm" ]; then
    brew install nvm
else
    echo "Skipping nvm, already installed"
fi

if ! command -v pnpm >/dev/null 2>&1; then
    brew install pnpm
else
    echo "Skipping pnpm, already installed"
fi

# Dotnet
if ! command -v dotnet >/dev/null 2>&1; then
    echo ".NET SDK not found. Installing via Homebrew..."
    brew install --cask dotnet-sdk
else
    echo ".NET SDK is already installed."
fi

# Go
if ! command -v go >/dev/null 2>&1; then
    brew install go
else
    echo "Skipping go, already installed"
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
    brew install --cask ngrok
else
    echo "ngrok is already installed."
fi

if ! command -v gh >/dev/null 2>&1; then
    brew install gh
else
    echo "Skipping gh, already installed"
fi

if ! command -v jq >/dev/null 2>&1; then
    brew install jq
else
    echo "Skipping jq, already installed"
fi

if ! command -v rg >/dev/null 2>&1; then
    brew install ripgrep
else
    echo "Skipping ripgrep, already installed"
fi

if ! command -v auth0 >/dev/null 2>&1; then
    echo "auth0-cli not found. Installing via Homebrew..."
    brew install auth0/auth0-cli/auth0
else
    echo "auth0-cli is already installed."
fi

if ! command -v psql >/dev/null 2>&1; then
    echo "postgresql not found. Installing via Homebrew..."
    brew install postgresql@14
else
    echo "postgresql is already installed."
fi

if ! command -v claude >/dev/null 2>&1; then
    echo "Claude Code not found. Installing via npm..."
    npm install -g @anthropic-ai/claude-code
else
    echo "Claude Code is already installed."
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

declare -a gui_apps=("visual-studio-code" "slack" "microsoft-teams" "brave-browser" "firefox" "spotify" "obsidian" "iterm2" "signal" "postman" "parsec" "tiles" "steam")

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
echo "    - Azure VPN Client (work) - from Microsoft, not on brew"
echo "    - GlobalProtect (work VPN) - from company portal"
echo ""
echo "Logins"
echo "    - vs code and sync extensions"
echo "    - rider"
echo "    - slack"
echo "    - teams"
echo "    - outlook"
echo "    - spotify"
echo "    - steam"
echo "    - github: gh auth login"
echo "    - azure: az login"
echo "    - auth0: auth0 login"
echo "    - claude code: run 'claude' and follow the login prompt"
echo ""
echo "Shell setup"
echo "    - nvm needs config in ~/.zshrc:"
echo "        export NVM_DIR=\"\$HOME/.nvm\""
echo "        [ -s \"/opt/homebrew/opt/nvm/nvm.sh\" ] && . \"/opt/homebrew/opt/nvm/nvm.sh\""
echo "    - postgresql@14 is keg-only, add to PATH:"
echo "        export PATH=\"/opt/homebrew/opt/postgresql@14/bin:\$PATH\""
echo "    - start postgres: brew services start postgresql@14"
echo "    - rust: source \$HOME/.cargo/env (or restart shell)"
echo ""
echo "Configuration"
echo "    - set iterm2 window transparrecy to 30"
echo "    - set desktop shortcuts: keyboard-shortcuts-mission control"
echo "    - set default desktops to certain apps"
echo "    - turn off auto rearrange desktops: desktop & dock, mission control, toggle of spaces after use"
echo "    - attach apps to certain desktops, and make them start on login"
echo "    - remap caps lock to esc"
echo "    - Azure VPN CLIENT for work!"
echo ""
echo "Brave bookmarks"
echo "    - sign in to Brave and enable sync to pull bookmarks down"
echo "    - if sync fails, recreate these folders manually:"
echo "        Profile 1 (work):     ThonID/, Thon/, sketching"
echo "        Profile 3 (personal): UI inspo/, Personal/, code stuff/"
echo "    - sync chain code is needed from an already-synced device"
echo ""
echo "Pretty"
echo "    - change app icons"
echo "    - slack app theme black"
echo "    - add Code named folder under Documents, and add projects"
echo "    - "

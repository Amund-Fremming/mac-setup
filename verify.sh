#!/bin/bash
#
# Checks the state of everything install.sh is supposed to set up.
# Installs nothing. Exits 1 if anything is missing.
#
#   ./verify.sh          check what is actually installed on this machine
#   ./verify.sh --names  check that every brew package name still resolves
#

missing=0

check_cmd() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "  ok      $1"
    else
        echo "  MISSING $1"
        missing=$((missing + 1))
    fi
}

check_cask() {
    if brew list --cask "$1" >/dev/null 2>&1; then
        echo "  ok      $1"
    elif [ -d "/Applications/$2" ]; then
        echo "  manual  $1 (installed outside brew)"
    else
        echo "  MISSING $1"
        missing=$((missing + 1))
    fi
}

# Verify names still resolve in Homebrew, without installing.
# Catches packages that get renamed, moved formula <-> cask, or removed.
if [ "$1" = "--names" ]; then
    echo "Updating brew first, so stale formula definitions do not cause false failures..."
    brew update >/dev/null 2>&1

    formulae=(node nvm pnpm go gh jq ripgrep just sqlx-cli git zsh azure-cli \
              kubernetes-cli k9s neovim postgresql@14 \
              auth0/auth0-cli/auth0 Azure/kubelogin/kubelogin)
    casks=(firefox steam ngrok visual-studio-code visual-studio-code@insiders \
           slack microsoft-teams brave-browser spotify obsidian iterm2 signal \
           postman parsec tiles orbstack dotnet-sdk)

    echo ""
    echo "Formulae"
    for f in "${formulae[@]}"; do
        if brew info --formula "$f" >/dev/null 2>&1; then
            echo "  ok      $f"
        else
            echo "  BAD     $f  <- not a formula, check if it moved to --cask"
            missing=$((missing + 1))
        fi
    done

    echo ""
    echo "Casks"
    for c in "${casks[@]}"; do
        if brew info --cask "$c" >/dev/null 2>&1; then
            echo "  ok      $c"
        else
            echo "  BAD     $c  <- not a cask, check if it moved to --formula"
            missing=$((missing + 1))
        fi
    done

    echo ""
    if [ "$missing" -eq 0 ]; then
        echo "All package names resolve."
    else
        echo "$missing name(s) no longer resolve. Fix install.sh before running it."
    fi
    exit $((missing > 0))
fi

echo "Languages and runtimes"
check_cmd brew
check_cmd node
check_cmd pnpm
check_cmd dotnet
check_cmd go
check_cmd rustc
check_cmd cargo
check_cmd python3
check_cmd ruby

echo ""
echo "Dev tools"
check_cmd git
check_cmd gh
check_cmd jq
check_cmd rg
check_cmd nvim
check_cmd just
check_cmd sqlx
check_cmd ngrok
check_cmd claude

echo ""
echo "Cloud and containers"
check_cmd az
check_cmd auth0
check_cmd docker
check_cmd orb
check_cmd kubectl
check_cmd kubelogin
check_cmd k9s

echo ""
echo "Databases"
check_cmd psql

echo ""
echo "Applications"
check_cask firefox "Firefox.app"
check_cask steam "Steam.app"
check_cask brave-browser "Brave Browser.app"
check_cask visual-studio-code "Visual Studio Code.app"
check_cask visual-studio-code@insiders "Visual Studio Code - Insiders.app"
check_cask slack "Slack.app"
check_cask microsoft-teams "Microsoft Teams.app"
check_cask spotify "Spotify.app"
check_cask obsidian "Obsidian.app"
check_cask iterm2 "iTerm.app"
check_cask signal "Signal.app"
check_cask postman "Postman.app"
check_cask parsec "Parsec.app"
check_cask tiles "Tiles.app"
check_cask orbstack "OrbStack.app"

echo ""
echo "Shell config"
if grep -q "NVM_DIR" "$HOME/.zshrc" 2>/dev/null; then
    echo "  ok      nvm configured in .zshrc"
else
    echo "  MISSING nvm not configured in .zshrc"
    missing=$((missing + 1))
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "  ok      oh-my-zsh"
else
    echo "  MISSING oh-my-zsh"
    missing=$((missing + 1))
fi

echo ""
if [ "$missing" -eq 0 ]; then
    echo "Everything is installed."
else
    echo "$missing item(s) missing. Run ./install.sh"
fi
exit $((missing > 0))

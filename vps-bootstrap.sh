#!/usr/bin/env bash
# vps-bootstrap.sh — set up a fresh Debian/Ubuntu VPS with the same dev
# environment as the local macOS box. Idempotent — safe to re-run.
#
# Usage:
#   git clone https://github.com/rshewade/dotfiles.git ~/dotfiles
#   bash ~/dotfiles/vps-bootstrap.sh

set -euo pipefail

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!! \033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m!! \033[0m %s\n' "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }

# -- Pre-flight checks --------------------------------------------------------

[[ "$(uname -s)" == "Linux" ]]  || die "This script is for Linux only."
[[ -f /etc/debian_version ]]    || die "This script targets Debian/Ubuntu (apt)."
[[ "$(id -u)" -ne 0 ]]          || warn "Running as root — Linuxbrew will refuse. Re-run as a regular user with sudo access."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
[[ -d "$DOTFILES_DIR" ]] || die "Expected dotfiles repo at $DOTFILES_DIR (clone first)."

# -- 1. Apt baseline ----------------------------------------------------------

log "Installing apt baseline packages..."
sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends \
  build-essential ca-certificates curl git unzip file procps \
  zsh tmux stow fd-find ripgrep

# Debian ships fd as `fdfind` — symlink to `fd` so sesh's ^f mode works
if have fdfind && ! have fd; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  log "Symlinked fdfind -> ~/.local/bin/fd"
fi

# -- 2. Linuxbrew -------------------------------------------------------------

if ! have brew; then
  log "Installing Linuxbrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# -- 3. Brew packages ---------------------------------------------------------

BREW_PKGS=(fzf zoxide starship sesh lsd direnv neovim lazygit bat eza)
for pkg in "${BREW_PKGS[@]}"; do
  if brew list --formula "$pkg" >/dev/null 2>&1; then
    log "brew: $pkg already installed"
  else
    log "brew install $pkg"
    brew install "$pkg"
  fi
done

# fzf shell integration (keybindings + completions for zsh)
if [[ ! -f "$HOME/.fzf.zsh" ]]; then
  log "Installing fzf shell integration..."
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
fi

# -- 4. Bun (referenced in .zshrc) -------------------------------------------

if ! have bun && [[ ! -x "$HOME/.bun/bin/bun" ]]; then
  log "Installing bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# -- 5. Stow dotfiles into HOME ----------------------------------------------

log "Stowing dotfiles into \$HOME..."
mkdir -p "$HOME/.config"
stow -d "$HOME" -t "$HOME" "$(basename "$DOTFILES_DIR")"

# -- 6. Tmux Plugin Manager ---------------------------------------------------

if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
  log "Installing TPM..."
  mkdir -p "$HOME/.config/tmux/resurrect"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
else
  log "TPM already installed"
fi

# -- 7. Set zsh as default shell ----------------------------------------------

ZSH_BIN="$(command -v zsh)"
if [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
  if ! grep -qx "$ZSH_BIN" /etc/shells; then
    echo "$ZSH_BIN" | sudo tee -a /etc/shells >/dev/null
  fi
  log "Setting zsh as default shell (may prompt for password)..."
  chsh -s "$ZSH_BIN" || warn "chsh failed — set manually: chsh -s $ZSH_BIN"
fi

# -- Done ---------------------------------------------------------------------

cat <<EOF

==> VPS bootstrap complete.

Next steps (manual):
  1. Open a new shell (or 'exec zsh') — zinit auto-installs plugins on first run.
  2. SSH key:        ssh-keygen -t ed25519 -C "$(git config --global user.email 2>/dev/null || echo you@example.com)"
                     cat ~/.ssh/id_ed25519.pub  # add to GitHub
  3. Git identity:   git config --global user.name  "Your Name"
                     git config --global user.email "you@example.com"
  4. Start tmux:     tmux
  5. Install plugs:  prefix + I    (prefix is Ctrl-a)
  6. Try sesh:       prefix + s

EOF

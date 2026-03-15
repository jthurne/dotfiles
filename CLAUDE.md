# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS, forked from [Zach Holman's dotfiles](https://github.com/holman/dotfiles). It manages shell configuration, tool installation, and symlinked config files.

## Key Commands

- `scripts/install-dotfiles` - Symlinks `*.symlink` files to `$HOME` (as dotfiles) and sets up gitconfig
- `scripts/install-packages` - Runs all `install.sh` scripts found in topic directories (sorted by directory name)
- `bin/set-defaults` - Applies macOS system defaults
- `scripts/create-extension <name>` - Initialize a new extension repo and create it on GitHub
- `scripts/add-extension <name> [git-url]` - Clone an existing extension repo (defaults to `jthurne/dotfiles-<name>`)
- `scripts/remove-extension <name>` - Remove a local extension (preserves the remote repo)
- `scripts/status-extensions` - Show git status summary for all extensions
- `scripts/update-extensions` - Pull latest changes for all extensions
- `scripts/push-extensions` - Push all extensions that have unpushed commits

## Architecture

### Topic-based organization with ordered execution

Directories are prefixed with two-digit numbers (e.g., `10-homebrew`, `50-git`, `70-zsh`) that control load/install order. This ordering matters — earlier topics set up dependencies for later ones.

### File conventions (from Holman's system)

- `topic/path.zsh` — Loaded **first**; sets up `$PATH`
- `topic/*.zsh` — Loaded **second**; general shell configuration (aliases, env vars, etc.)
- `topic/completion.zsh` — Loaded **last**, after `compinit`
- `topic/install.sh` — Run by `scripts/install-packages`; uses `.sh` extension to avoid auto-loading. Scripts should be idempotent — re-running updates already-installed tools rather than skipping them. When installing multiple Homebrew packages, use a `Brewfile` in the same directory and run `brew bundle --file="${script_dir}/Brewfile"` rather than multiple `brew install` calls.
- `topic/*.symlink` — Symlinked to `$HOME/.{name}` by `scripts/install-dotfiles` (e.g., `gitconfig.symlink` → `~/.gitconfig`)

The loading logic lives in `70-zsh/zshrc.symlink`, which globs `$DOTFILES/**/*.zsh`.

### Extensions

The `extensions/` directory holds additional dotfile sets (e.g., work-specific or private configs). These follow the same conventions and are included in symlink installation. Each extension is its own git repository — always commit changes in the correct repo. Current extensions: `ai-agents`, `common-private`, `gradle`.

### Key environment variables

- `$DOTFILES` — Points to `~/.dotfiles` (set in `zshrc.symlink`)
- `$PROJECTS` — Points to `~/Code`

### bin/ and functions/

- `bin/` is added to `$PATH` — scripts here are available as commands
- `functions/` contains zsh autoload functions and completions

## Git workflow

Use `gs` (git-spice) for all branch and PR operations — see global `~/.claude/CLAUDE.md` for the full command reference. Do not use raw `git checkout -b` or `gh pr create`.

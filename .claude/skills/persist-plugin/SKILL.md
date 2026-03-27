---
name: persist-plugin
description: >
  Persist a newly installed Claude Code plugin to the dotfiles install script so
  it survives a clean machine setup. Use this skill whenever a plugin has just been
  installed via /plugin, or when the user says "persist plugin", "save plugin to
  install script", "add plugin to dotfiles", or asks to make a plugin installation
  permanent. Also trigger this after any /plugin command completes successfully.
  Do NOT use for uninstalling plugins or managing marketplace registrations.
---

# Persist Plugin

After installing a Claude Code plugin via `/plugin`, the plugin is registered locally
but won't be reinstalled on a fresh machine. This skill adds it to the dotfiles install
script so it gets installed automatically during setup.

## Key files

Plugin installation is split across two extensions:

- **Common install script**: `~/.dotfiles/extensions/common-ai-agents/50-claude-code/install.sh` — official marketplace and plugins shared across projects
- **Work-specific install script**: `~/.dotfiles/extensions/gradle-ai-agents/50-claude-code/install.sh` — Gradle/DV marketplace and plugins
- **Plugin registry**: `~/.dotfiles/extensions/gradle-ai-agents/50-claude-code/claude.symlink/plugins/installed_plugins.json` — Claude Code's record of installed plugins
- **Settings**: `~/.dotfiles/extensions/gradle-ai-agents/50-claude-code/claude.symlink/settings.json` — plugin enable/disable state

## Steps

### 1. Identify the new plugin(s)

Compare the plugins in `installed_plugins.json` against the plugin names already listed in `install.sh`. Any plugin present in the registry but missing from the install script is new and needs to be added.

If the user specifies a plugin name, use that directly instead of diffing.

### 2. Determine the marketplace

Each key in `installed_plugins.json` has the format `plugin-name@marketplace-name`. Map the marketplace to the correct install script:

| Marketplace | Install script | Array |
|---|---|---|
| `claude-plugins-official` | `common-ai-agents/50-claude-code/install.sh` | `OFFICIAL_PLUGINS` |
| `dv-claude-marketplace` | `gradle-ai-agents/50-claude-code/install.sh` | `DV_PLUGINS` |

If the plugin belongs to an unrecognized marketplace, ask the user how to handle it — they may need to add a new marketplace registration and array to the appropriate script.

### 3. Edit install.sh

Add the plugin name (without the `@marketplace` suffix) to the end of the appropriate array in the correct install script (see marketplace table above). Use the Edit tool to make the change.

### 4. Commit the changes

Commit the changed files in the correct extension repo(s):

- If the plugin is from `claude-plugins-official`: commit `50-claude-code/install.sh` in `~/.dotfiles/extensions/common-ai-agents/`
- If the plugin is from `dv-claude-marketplace`: commit `50-claude-code/install.sh` in `~/.dotfiles/extensions/gradle-ai-agents/`
- Always commit the plugin registry and settings in `~/.dotfiles/extensions/gradle-ai-agents/`:
  - `50-claude-code/claude.symlink/plugins/installed_plugins.json`
  - `50-claude-code/claude.symlink/settings.json`

Use a commit message like: `Add <plugin-name> plugin to install script and settings`

If multiple plugins are being persisted, combine them into one commit per repo.

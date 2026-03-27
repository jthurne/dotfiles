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

Plugin installation is split across multiple `*-ai-agents` extensions, each with its own
`50-claude-code/install.sh` containing marketplace registrations and plugin arrays.

- **Install scripts**: `~/.dotfiles/extensions/*-ai-agents/50-claude-code/install.sh`
  - `common-ai-agents` — official marketplace, plugins shared across all projects
  - `gradle-ai-agents` — Gradle/DV marketplace and plugins
  - `personal-ai-agents` — personal project marketplace and plugins (when created)
- **Plugin registry**: `~/.dotfiles/extensions/gradle-ai-agents/50-claude-code/claude.symlink/plugins/installed_plugins.json` — Claude Code's record of installed plugins
- **Settings**: `~/.dotfiles/extensions/gradle-ai-agents/50-claude-code/claude.symlink/settings.json` — plugin enable/disable state

## Steps

### 1. Identify the new plugin(s)

Compare the plugins in `installed_plugins.json` against the plugin names already listed in `install.sh`. Any plugin present in the registry but missing from the install script is new and needs to be added.

If the user specifies a plugin name, use that directly instead of diffing.

### 2. Determine the marketplace

Each key in `installed_plugins.json` has the format `plugin-name@marketplace-name`.
Search all `*-ai-agents` extension install scripts to find which one already registers
that marketplace (`claude plugin marketplace add <name>`). Known mappings:

| Marketplace | Extension | Array |
|---|---|---|
| `claude-plugins-official` | `common-ai-agents` | `OFFICIAL_PLUGINS` |
| `dv-claude-marketplace` | `gradle-ai-agents` | `DV_PLUGINS` |

If the marketplace isn't registered in any existing install script, ask the user which
extension to add it to.

### 3. Edit install.sh

Add the plugin name (without the `@marketplace` suffix) to the end of the appropriate array in the correct install script (see marketplace table above). Use the Edit tool to make the change.

### 4. Commit the changes

Commit the changed files in the correct extension repo(s):

- Commit `50-claude-code/install.sh` in whichever extension contains the marketplace
- Always commit the plugin registry and settings in `~/.dotfiles/extensions/gradle-ai-agents/`:
  - `50-claude-code/claude.symlink/plugins/installed_plugins.json`
  - `50-claude-code/claude.symlink/settings.json`

Use a commit message like: `Add <plugin-name> plugin to install script and settings`

If multiple plugins are being persisted, combine them into one commit per repo.

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

All paths are relative to the ai-agents extension repo (`~/.dotfiles/extensions/ai-agents/50-claude-code/`):

- **Install script**: `install.sh` — contains shell arrays of plugin names, grouped by marketplace
- **Plugin registry**: `claude.symlink/plugins/installed_plugins.json` — Claude Code's record of installed plugins
- **Settings**: `claude.symlink/settings.json` — plugin enable/disable state

## Steps

### 1. Identify the new plugin(s)

Compare the plugins in `installed_plugins.json` against the plugin names already listed in `install.sh`. Any plugin present in the registry but missing from the install script is new and needs to be added.

If the user specifies a plugin name, use that directly instead of diffing.

### 2. Determine the marketplace

Each key in `installed_plugins.json` has the format `plugin-name@marketplace-name`. Map the marketplace to the correct array in `install.sh`:

| Marketplace | Array in install.sh |
|---|---|
| `claude-plugins-official` | `OFFICIAL_PLUGINS` |
| `dv-claude-marketplace` | `DV_PLUGINS` |

If the plugin belongs to an unrecognized marketplace, ask the user how to handle it — they may need to add a new marketplace registration and array to the script.

### 3. Edit install.sh

Add the plugin name (without the `@marketplace` suffix) to the end of the appropriate array in `install.sh`. Use the Edit tool to make the change.

### 4. Commit the changes

Commit exactly these three files in the ai-agents extension repo (`~/.dotfiles/extensions/ai-agents/`):

```
50-claude-code/install.sh
50-claude-code/claude.symlink/plugins/installed_plugins.json
50-claude-code/claude.symlink/settings.json
```

Use a commit message like: `Add <plugin-name> plugin to install script and settings`

If multiple plugins are being persisted, combine them into one commit.

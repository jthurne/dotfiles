---
name: persist-skill
description: >
  Persist a newly installed Claude Code skill to the dotfiles install script so
  it survives a clean machine setup. Use this skill whenever a skill has just been
  installed via `npx skills add`, or when the user says "persist skill", "save skill
  to install script", "add skill to dotfiles", "make skill installation permanent",
  or asks to install a skill from a GitHub repo and add it to the dotfiles. Also use
  when the user asks you to install a skill AND persist it in one step — handle both
  the install script update and running it. Do NOT use for uninstalling skills or
  managing plugins (use persist-plugin for those).
---

# Persist Skill

When a Claude Code skill is installed via `npx skills add`, it's only installed locally.
This skill adds it to the appropriate dotfiles install script so it gets reinstalled
automatically on a fresh machine.

## Key locations

- **Install scripts**: `~/.dotfiles/extensions/ai-agents/` — each `*/install.sh` installs skills from a specific repo
- **Installed skills**: `~/.claude/skills/` — where skills are installed locally

## Steps

### 1. Identify the skill and its source repository

Determine the skill name and the GitHub repository it comes from. Sources:

- The user may tell you directly (e.g., "install gws-docs-write from googleworkspace/cli")
- A `npx skills add` command may have just been run in the conversation
- The user may give a GitHub URL like `https://github.com/googleworkspace/cli/tree/main/skills/gws-docs-write` — extract the repo (`https://github.com/googleworkspace/cli`) and skill name (`gws-docs-write`)

If you can't determine either piece, ask the user.

### 2. Find or create the matching install script

Scan install scripts in `~/.dotfiles/extensions/ai-agents/*/install.sh` for one that
already references the same repository (look for the `REPO=` variable matching the
GitHub org/repo).

**If a matching script exists:** Add the new skill name to its `SKILLS` array, maintaining
alphabetical order within the array (or matching the existing ordering convention if it
differs). Use the Edit tool.

**If no matching script exists:** Create a new directory and install script following the
established pattern. Use the repo name or a short descriptor for the directory name
(e.g., `50-myorg-tools/install.sh`). Follow this template:

```bash
#!/usr/bin/env bash

REPO="<repo-url>"
SKILLS=(
  <skill-name>
)

echo "Installing <description> skills for Claude Code"
for skill in "${SKILLS[@]}"; do
  npx skills add "$REPO" --global --skill "$skill" --yes --agent claude-code
done

exit 0
```

For the REPO URL:
- Use SSH URLs (`git@github.com:org/repo.git`) for private repos
- Use HTTPS URLs (`https://github.com/org/repo`) for public repos
- Match the convention used in any existing script for the same GitHub org

### 3. Run the install script

Run the install script with `bash <path-to-script>` to actually install the skill(s).

### 4. Commit the changes

Commit the modified or new install script in the ai-agents extension repo
(`~/.dotfiles/extensions/ai-agents/`). Use a commit message like:
`Add <skill-name> skill to install script`

## Existing install scripts for reference

These are the current install scripts and the repos they cover — check these before
creating a new one:

| Directory | Repository |
|---|---|
| `50-gws/` | `https://github.com/googleworkspace/cli` (Google Workspace skills) |
| `50-rnett-agents/` | `git@github.com:gradle/rnett.agents.git` (DV authoring/testing skills) |

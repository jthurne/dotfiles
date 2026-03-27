---
name: add-claude-skill
description: Use when adding a new Claude Code skill from a GitHub repository to the dotfiles. Handles install script creation/update, .gitignore exclusion, and running the installer.
user_invocable: true
---

# Adding Claude Code Skills

## Overview

Skills are installed via `npx skills add` in install scripts under `extensions/*-ai-agents/`. Each source repo gets its own install directory (e.g., `50-rnett-agents/`, `50-gws/`). Installed skills are symlinked into `~/.claude/skills/` and must be excluded from git tracking.

AI agent tooling is split across multiple extensions by scope:
- `common-ai-agents` — shared across all projects (both work and personal machines)
- `gradle-ai-agents` — Gradle/DV work-specific (work machine only)
- `personal-ai-agents` — personal projects (personal machine only)

Not all extensions exist on every machine. Check which `*-ai-agents` extensions are present before proceeding.

## Steps to Add a New Skill

### 1. Determine which install script to use

- Scan `extensions/*-ai-agents/*/install.sh` for an existing directory matching the source repo (look for `REPO=` matching the GitHub org/repo)
- If the skill comes from a repo that already has an install script, add to its `SKILLS` array
- If the skill comes from a new repo, create a new directory (e.g., `50-<name>/install.sh`) in the appropriate extension. Ask the user which extension if it's not obvious.

### 2. Update or create the install script

**For a new repo**, create `extensions/<extension>/50-<name>/install.sh`:

```bash
#!/usr/bin/env bash

REPO="git@github.com:<org>/<repo>.git"
SKILLS=(
  <skill_name>
)

echo "Installing <repo> skills for Claude Code"
for skill in "${SKILLS[@]}"; do
  npx skills add "$REPO" --global --skill "$skill" --yes --agent claude-code
done

exit 0
```

**For an existing repo**, append the skill name to the `SKILLS` array.

**Important:**
- Always use SSH URLs (`git@github.com:...`) for private repos. HTTPS URLs fail because 1Password CLI intercepts `gh` auth and blocks non-interactive git credential flows.
- Public repos can use HTTPS URLs (`https://github.com/...`).
- The script must be executable: `chmod +x install.sh`
- Use `#!/usr/bin/env bash` as the shebang.

### 3. Add the skill to .gitignore

Find whichever extension provides `50-claude-code/claude.symlink/` (this varies by machine — `gradle-ai-agents` on work machines, `personal-ai-agents` on personal machines). Edit its `.gitignore`:

```bash
# Find the right .gitignore
ls extensions/*-ai-agents/50-claude-code/claude.symlink/.gitignore
```

Add the skill name under the existing exclusion comment:

```gitignore
# Ignore skills installed by npx (symlinks to ~/.agents/skills/)
skills/gws-*
skills/<new_skill_name>
```

This prevents the installed symlink/copy in `~/.claude/skills/` from being committed.

### 4. Run the install script and verify

```bash
bash extensions/<extension>/50-<name>/install.sh
```

Verify the skill appears in `~/.claude/skills/`.

### 5. Commit changes in the correct extension repo

Each extension is its own git repo. Commit the install script in whichever extension it was added to, and commit .gitignore changes in whichever extension provides `claude.symlink`. These may be different repos — verify with `git -C extensions/<name> remote -v` before committing.

#!/usr/bin/env bash
#
# Tidy — install or update the Claude Code/Codex skill plus the
# repo-owned wiki playbook files.
#
# Normal install is conservative: existing ~/.tidy/ files are never
# overwritten. Update mode refreshes only repo-owned files and backs up
# local edits first.
#
set -euo pipefail
cd "$(dirname "$0")"

MODE="install"

usage() {
    cat <<'EOF'
Usage:
  ./install.sh           Install Tidy, seeding missing wiki files only
  ./install.sh --update  Refresh repo-owned Tidy files, backing up local edits
  ./install.sh --doctor  Check the local Tidy install
  ./install.sh --help    Show this help

Normal install never overwrites existing files in ~/.tidy/.

Update refreshes only repo-owned files:
  ~/.claude/skills/tidy/SKILL.md
  ~/.codex/prompts/tidy.md
  ~/.tidy/AGENTS.md
  ~/.tidy/skills/how-to-ask.md
  ~/.tidy/skills/how-to-log.md
  ~/.tidy/skills/how-to-update-the-wiki.md
  ~/.tidy/skills/when-nothing-fits.md

Update never touches:
  ~/.tidy/index.md
  your learned ~/.tidy/skills/*.md
  ~/.tidy/log/**
EOF
}

if [ "$#" -gt 1 ]; then
    usage >&2
    exit 2
fi

if [ "$#" -eq 1 ]; then
    case "$1" in
        --update)
            MODE="update"
            ;;
        --doctor)
            MODE="doctor"
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "error: unknown argument: $1" >&2
            echo >&2
            usage >&2
            exit 2
            ;;
    esac
fi

timestamp="$(date +%Y-%m-%d-%H-%M)"

echo "Tidy — ${MODE}"
echo

seed() {
    local src="$1"
    local dst="$2"
    if [ -f "$dst" ]; then
        echo "  · $dst (kept your version)"
    else
        mkdir -p "$(dirname "$dst")"
        cp "$src" "$dst"
        echo "  + $dst"
    fi
}

refresh() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"

    if [ ! -f "$dst" ]; then
        cp "$src" "$dst"
        echo "  + $dst"
        return
    fi

    if cmp -s "$src" "$dst"; then
        echo "  · $dst (unchanged)"
        return
    fi

    local backup="${dst}.bak-${timestamp}"
    cp "$dst" "$backup"
    echo "  ! $dst backed up to $backup"
    cp "$src" "$dst"
    echo "  ↻ $dst"
}

install_skill_files() {
    # Claude/Codex prompt files are repo-owned. Install mode may overwrite
    # them because they are not user wiki memory.
    if [ -d "$HOME/.claude" ] || command -v claude >/dev/null 2>&1; then
        mkdir -p "$HOME/.claude/skills/tidy"
        cp skill/claude/SKILL.md "$HOME/.claude/skills/tidy/SKILL.md"
        echo "  + ~/.claude/skills/tidy/SKILL.md"
    else
        echo "  · skipped Claude skill (no ~/.claude or claude on PATH)"
    fi

    if [ -d "$HOME/.codex" ] || command -v codex >/dev/null 2>&1; then
        mkdir -p "$HOME/.codex/prompts"
        cp skill/codex/tidy.md "$HOME/.codex/prompts/tidy.md"
        echo "  + ~/.codex/prompts/tidy.md"
    else
        echo "  · skipped Codex prompt (no ~/.codex or codex on PATH)"
    fi
}

update_skill_files() {
    if [ -d "$HOME/.claude" ] || command -v claude >/dev/null 2>&1; then
        refresh skill/claude/SKILL.md "$HOME/.claude/skills/tidy/SKILL.md"
    else
        echo "  · skipped Claude skill (no ~/.claude or claude on PATH)"
    fi

    if [ -d "$HOME/.codex" ] || command -v codex >/dev/null 2>&1; then
        refresh skill/codex/tidy.md "$HOME/.codex/prompts/tidy.md"
    else
        echo "  · skipped Codex prompt (no ~/.codex or codex on PATH)"
    fi
}

install_mode() {
    mkdir -p "$HOME/.tidy/skills" "$HOME/.tidy/log"

    echo "Wiki"
    seed wiki/AGENTS.md "$HOME/.tidy/AGENTS.md"
    seed wiki/index.md "$HOME/.tidy/index.md"
    for src in wiki/skills/*.md; do
        seed "$src" "$HOME/.tidy/skills/$(basename "$src")"
    done
    seed wiki/log/index.md "$HOME/.tidy/log/index.md"

    echo
    echo "Agent integrations"
    install_skill_files

    echo
    echo "✓ Tidy installed."
    echo
    echo "Try it:"
    echo "  claude    →  /tidy ~/Downloads"
    echo "  codex     →  /tidy then describe what to organize"
    echo
    echo "Memory lives at ~/.tidy/. Open it any time:"
    echo "  open ~/.tidy/index.md"
}

update_mode() {
    mkdir -p "$HOME/.tidy/skills"

    echo "Wiki playbook"
    refresh wiki/AGENTS.md "$HOME/.tidy/AGENTS.md"
    refresh wiki/skills/how-to-ask.md "$HOME/.tidy/skills/how-to-ask.md"
    refresh wiki/skills/how-to-log.md "$HOME/.tidy/skills/how-to-log.md"
    refresh wiki/skills/how-to-update-the-wiki.md "$HOME/.tidy/skills/how-to-update-the-wiki.md"
    refresh wiki/skills/when-nothing-fits.md "$HOME/.tidy/skills/when-nothing-fits.md"

    echo
    echo "Agent integrations"
    update_skill_files

    echo
    echo "✓ Tidy updated."
    echo "User-owned files were not touched: ~/.tidy/index.md, learned skills, and ~/.tidy/log/**."
}

check_path() {
    local path="$1"
    local label="$2"
    if [ -e "$path" ]; then
        echo "  ✓ $label"
        return 0
    fi
    echo "  ✗ $label (missing: $path)"
    return 1
}

check_command() {
    local command="$1"
    local label="$2"
    if command -v "$command" >/dev/null 2>&1; then
        echo "  ✓ $label ($(command -v "$command"))"
        return 0
    fi
    echo "  · $label not found on PATH"
    return 1
}

doctor_mode() {
    local problems=0

    echo "Runtime"
    check_command claude "Claude Code" || true
    check_command codex "Codex" || true

    echo
    echo "Wiki"
    check_path "$HOME/.tidy/AGENTS.md" "~/.tidy/AGENTS.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/index.md" "~/.tidy/index.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/skills/how-to-ask.md" "~/.tidy/skills/how-to-ask.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/skills/how-to-log.md" "~/.tidy/skills/how-to-log.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/skills/how-to-update-the-wiki.md" "~/.tidy/skills/how-to-update-the-wiki.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/skills/when-nothing-fits.md" "~/.tidy/skills/when-nothing-fits.md" || problems=$((problems + 1))
    check_path "$HOME/.tidy/log/index.md" "~/.tidy/log/index.md" || problems=$((problems + 1))

    echo
    echo "Agent integrations"
    check_path "$HOME/.claude/skills/tidy/SKILL.md" "~/.claude/skills/tidy/SKILL.md" || true
    check_path "$HOME/.codex/prompts/tidy.md" "~/.codex/prompts/tidy.md" || true

    echo
    if [ "$problems" -eq 0 ]; then
        echo "✓ Tidy looks installed."
        return 0
    fi

    echo "✗ Tidy is missing $problems required wiki file(s). Run ./install.sh."
    return 1
}

case "$MODE" in
    install) install_mode ;;
    update) update_mode ;;
    doctor) doctor_mode ;;
esac

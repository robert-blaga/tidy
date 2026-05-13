---
name: tidy
description: A wiki you teach. Tidy reads ~/.tidy/ on every invocation, finds the matching domain and skill for what you asked, follows it, logs the batch, and proposes new skills (or whole new domains) when it learns something. Ships knowing one domain — filing. Learns the rest with your approval. Trigger via the slash command /tidy or natural phrases like "tidy ~/Downloads", "organize my desktop", "file these books", "clean up this folder", or whatever Tidy has learned to do for you.
---

# Tidy

The user has invoked Tidy. Their accumulated wisdom lives at `~/.tidy/` as plain markdown.

## What to do

1. **Read `~/.tidy/AGENTS.md`** — the constitution. Follow it exactly.
2. **Read `~/.tidy/index.md`** — the catalog of domains and skills the user has approved.
3. **Identify the domain** that matches what the user is asking for.
4. **Read `~/.tidy/domains/<name>.md`** for the playbook of that domain.
5. **Read whichever `~/.tidy/skills/*.md`** look relevant.
6. **Follow the playbook.** If an approved skill matches, follow it. If nothing fits, read `skills/when-nothing-fits.md`. If the work is genuinely outside all current domains, that fallback will route you to `skills/how-to-update-my-identity.md` to propose a new domain.

## Hard rules (also in AGENTS.md)

- Approved skills are executable memory. If a matching skill clearly applies, follow it without asking again unless the skill says to ask.
- Never invent new behavior silently. If no approved skill applies, ask before acting.
- Never write to `~/.tidy/skills/`, `~/.tidy/index.md`, or `~/.tidy/domains/` (for new user-grown domains) without showing the user the proposed markdown first.
- Never edit `~/.tidy/AGENTS.md`, the meta-skills, or `~/.tidy/domains/filing.md`. Those are the constitution — managed in the Tidy repo and refreshed by `install.sh --update`.
- Always append a log entry to `~/.tidy/log/<YYYY-MM>.md` at the end of every batch — even when the user cancels or something fails.
- Type-level skill filenames only (`pdf.md`, `ebook.md`, `invoice.md`). Specific situations become sub-cases inside a type-level skill.
- Tidy is not a sandbox or permission layer. Tool execution follows the active Claude Code permission settings.

## If the wiki is missing

If `~/.tidy/AGENTS.md` doesn't exist, tell the user Tidy isn't installed yet and point them at the install script in the Tidy repo. Don't try to operate without the wiki — its contents are the contract between you and the user.

---
name: tidy
description: A wiki you teach. Tidy reads ~/.tidy/ on every invocation, finds the skill that matches what you asked, follows it, logs the batch, and proposes new skills when it learns something. Starts with no learned skills; you teach it one at a time. Trigger via the slash command /tidy or any natural request like "tidy ~/Downloads", "organize my desktop", "file these books", or whatever Tidy has learned to do for you.
---

# Tidy

The user has invoked Tidy. Their accumulated wisdom lives at `~/.tidy/` as plain markdown.

## What to do

1. **Read `~/.tidy/AGENTS.md`** — the constitution. Follow it exactly.
2. **Read `~/.tidy/index.md`** — the catalog of skills the user has approved.
3. **Read whichever `~/.tidy/skills/*.md`** look relevant to what the user asked for.
4. **Follow the playbook.** If an approved skill matches, follow it. If nothing fits, read `skills/when-nothing-fits.md` and follow that.

## Hard rules (also in AGENTS.md)

- Approved skills are executable memory. If a matching skill clearly applies, follow it without asking again unless the skill says to ask.
- Never invent new behavior silently. If no approved skill applies, ask before acting.
- Never write to `~/.tidy/skills/` or `~/.tidy/index.md` without showing the user the proposed markdown first.
- Never edit `~/.tidy/AGENTS.md` or the meta-skills. Those are the constitution — managed in the Tidy repo and refreshed by `install.sh --update`.
- Always append a log entry to `~/.tidy/log/<YYYY-MM>.md` at the end of every batch — even when the user cancels or something fails.
- Type-level skill filenames only (`pdf.md`, `ebook.md`, `invoice.md`, `email.md`). Specific situations become sub-cases inside a type-level skill.
- Tidy is not a sandbox or permission layer. Tool execution follows the active Claude Code permission settings.

## If the wiki is missing

If `~/.tidy/AGENTS.md` doesn't exist, tell the user Tidy isn't installed yet and point them at the install script in the Tidy repo. Don't try to operate without the wiki — its contents are the contract between you and the user.

# Tidy
A small prototype for agent memory governance, for Claude Code and Codex
Tidy reads `~/.tidy/` on every invocation, finds the skill that matches what you asked, and follows it. You teach it skills over time — for filing files, triaging email, drafting copy, whatever you keep asking for. New skills accumulate; the wiki is yours.

Agents don't always need smarter models. Sometimes they need better memory.

The novel idea is the wiki, not the runtime. The wiki is yours. The agent is the engine.

## What this is, exactly

- A **Claude Code skill** at `~/.claude/skills/tidy/SKILL.md`. Triggered by `/tidy` or by phrases like "organize my downloads".
- A **Codex skill** at `~/.codex/skills/tidy/SKILL.md`. Available to Codex CLI and the Codex app after restart, triggered by `$tidy` or matching natural language.
- A **Codex slash prompt** at `~/.codex/prompts/tidy.md`. Triggered by `/tidy` for CLI compatibility.
- A **seed wiki** at `~/.tidy/`:
  - `AGENTS.md` — the constitution
  - three meta-skills in `skills/` (`how-to-log`, `how-to-update-the-wiki`, `when-nothing-fits`)
  - `index.md` — your catalog of learned skills (starts empty)
  - `log/` — every batch recorded

That's the whole product. No app, no daemon, no menu bar, no global hotkey. Plain markdown. Runs in whatever terminal you run claude or codex in.

## Install

```bash
git clone https://github.com/robert-blaga/tidy
cd tidy
./install.sh
```

`install.sh` is idempotent — existing files in `~/.tidy/` are never overwritten, so re-running after you've taught Tidy real skills won't lose them.

You need at least one of:

- **Claude Code** — `npm install -g @anthropic-ai/claude-code`, then `claude` once to sign in.
- **Codex** — `npm install -g @openai/codex`, then `codex login`.

## Updating

```bash
cd tidy
git pull
./install.sh --update
```

`--update` refreshes Tidy's repo-owned constitution:

- Claude Code skill
- Codex skill and UI metadata
- Codex prompt
- `~/.tidy/AGENTS.md`
- the three meta-skills in `~/.tidy/skills/`

It never touches:

- `~/.tidy/index.md`
- your learned `~/.tidy/skills/*.md`
- `~/.tidy/log/**`

If you edited a repo-owned file locally, Tidy backs it up next to the file before replacing it.

## Use

In Claude Code:

```text
/tidy ~/Downloads
```

In Codex:

```text
/tidy then tell me what to organize
```

Or, after restarting Codex so it picks up installed skills:

```text
$tidy ~/Downloads
```

Or just describe what you want:

```text
/tidy can you tidy up my Downloads folder? I am only interested in books
```

## How It Works

1. The agent reads `~/.tidy/AGENTS.md` (the constitution) and `~/.tidy/index.md` (the catalog of skills).
2. It looks at the user's input — a folder, a file, an email address, a URL, anything — and tries to match it to an approved skill.
3. If a skill matches, it follows the skill, acts, and logs.
4. If nothing fits, it reads `when-nothing-fits.md`, investigates what the input is, proposes a concrete action, and asks before doing anything. If a recurring pattern emerges, it proposes a new skill for your approval.
5. Every batch ends with a log entry. Every wiki write is approved.

The wiki is the durable part. Skills are executable memory. The runtime is replaceable.

## Examples

### Existing skill — filing

You run:

```text
/tidy ~/Downloads
```

Tidy reads the wiki, finds `skills/ebook.md` covers `.epub` files, reads that skill, and follows it:

```text
Filed 4 ebooks using skills/ebook.md:
- dune.epub -> ~/Documents/Books/Sci-fi/dune.epub
- foundation.epub -> ~/Documents/Books/Sci-fi/foundation.epub
- meditations.epub -> ~/Documents/Books/Philosophy/meditations.epub
- notes-from-underground.epub -> ~/Documents/Books/Literature/notes-from-underground.epub

Logged the batch to ~/.tidy/log/2026-05.md.
```

No new decision was needed. The approved skill was the memory.

### No matching skill yet

You run:

```text
/tidy ~/Downloads/statements
```

No approved skill covers bank statements yet, so Tidy reads `skills/when-nothing-fits.md`, investigates, and asks:

```text
I found 3 PDF bank statements. I'd file them under:

- chase-april.pdf -> ~/Documents/Finance/Statements/Chase/2026/chase-april.pdf
- chase-march.pdf -> ~/Documents/Finance/Statements/Chase/2026/chase-march.pdf
- amex-april.pdf -> ~/Documents/Finance/Statements/Amex/2026/amex-april.pdf

Evidence: you already have ~/Documents/Finance/Statements/ with bank-name subfolders and year folders. No approved statement skill exists yet. OK?
```

If you approve, the agent moves the files, logs the batch, then proposes a new or updated skill:

```text
I'd add skills/pdf.md with a bank-statement sub-case:

...

OK to write this to ~/.tidy/skills/pdf.md and update ~/.tidy/index.md?
```

## What lives in `~/.tidy/`

```
~/.tidy/
├── AGENTS.md            the constitution the agent reads on every invocation
├── index.md             catalog of skills you've approved
├── skills/
│   ├── how-to-log.md                ↘
│   ├── how-to-update-the-wiki.md     ↘  the three meta-skills, shipped at install
│   ├── when-nothing-fits.md          ↗
│   ├── ebook.md                     ↘
│   ├── invoice.md                    ↘  skills you've taught Tidy
│   └── …                             ↗
└── log/
    ├── index.md         catalog of monthly logs
    └── 2026-05.md       this month's batches
```

It's all plain markdown. Read it. Edit it. The agent re-reads it on every invocation.

## Runtime and privacy

Tidy is plain markdown plus installed agent instructions. It does not run a service, connect to a backend, or add a security boundary.

What runs is whichever agent you point at the wiki: Claude Code or Codex. When you invoke `/tidy`, the agent reads `~/.tidy/` plus whatever you asked it to operate on, and passes whatever it needs to its provider as part of the prompt — same as any other Claude Code or Codex session. Privacy and security live with that agent, per its provider's policy.

Claude Code and Codex also control tool permissions. Tidy tells the agent what workflow to follow; it is not a sandbox or permission layer.

The wiki is yours: read it, edit it, version-control it, share it.

## Why

Tidy came from two places: my computer was a mess, and Andrej Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) crystallized the pattern. His gist describes the wiki as a persistent, compounding artifact maintained by an LLM instead of knowledge being rediscovered from scratch every session.

What Tidy adds is small: the wiki holds executable rules instead of synthesized knowledge, and grows by codifying a pattern the first time no existing rule fits. The runtime is replaceable; the rulebook is yours.

Thank you, Andrej.

## Docs

- [Teaching Tidy](docs/teaching.md)
- [Undo and Recovery](docs/recovery.md)
- [Runtime and Privacy](docs/runtime-and-privacy.md)
- [Philosophy](docs/philosophy.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)

## Status

v0.3.2. Pre-alpha — expect the agent's behavior to surprise you sometimes; the playbook in `~/.tidy/AGENTS.md` and the meta skills in `~/.tidy/skills/` are the place to push back when it does.

## Uninstall

```bash
rm -rf ~/.tidy ~/.claude/skills/tidy ~/.codex/skills/tidy ~/.codex/prompts/tidy.md
```

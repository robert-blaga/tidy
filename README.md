# Tidy

A shared memory for Claude Code and Codex. Tidy ships knowing how to file files; you teach it the rest.

Agents don't always need smarter models. Sometimes they need better memory.

Tidy is a Claude Code skill, a Codex slash prompt, and a local markdown wiki at `~/.tidy/`. Teach it once, and both agents can do the work the way you'd do it. Out of the box, Tidy knows one **domain** — filing files. New skills accumulate within a domain. New domains expand what Tidy *is*, with your approval each step.

## Demo

This is an abbreviated version of a real first run in Claude Code:

```text
User:
/tidy can you tidy up my Downloads folder? I am only interested in books

Tidy:
Found 7 loose epubs in ~/Downloads/. You already have ~/Downloads/Books/
with sci-fi/, fantasy/, nonfiction/, history/ subfolders.

Plan:
- 4 sci-fi -> ~/Downloads/Books/sci-fi/
- 3 nonfiction -> ~/Downloads/Books/nonfiction/

No existing book skill — if you say yes, I'll propose an ebook.md skill afterwards.
OK to move?

User:
ok, do it

Tidy:
Done. 7 ebooks moved and logged.

I'd like to capture this as ~/.tidy/skills/ebook.md so next time I can file
ebooks by genre from the approved rule. OK to write it?
```

After approval, Tidy wrote `skills/ebook.md` and updated `index.md`. The next ebook batch can be handled by reading that skill instead of rediscovering the pattern.

## Beyond filing — teaching Tidy a new domain

When you ask Tidy to do something that isn't filing, it doesn't pretend. It recognizes the work is outside what it knows and proposes a new **domain**:

```text
User:
/tidy triage my inbox

Tidy:
You're asking me to triage your inbox. That's outside what I do today
(I currently do: filing). If you want, I can learn this kind of work too.

I'd add a new domain at ~/.tidy/domains/inbox-triage.md and a first skill at
~/.tidy/skills/triage.md (markdown bodies shown below). OK to write them?
```

Approve, and from then on `/tidy triage my inbox` just works. The wiki grows; the agent never has to rediscover.

## Install

```bash
git clone https://github.com/robert-blaga/tidy
cd tidy
./install.sh
```

`install.sh` is idempotent — existing files in `~/.tidy/` are never overwritten, so re-running after you've taught Tidy real skills (or new domains) won't lose them.

You need at least one of:

- **Claude Code** — `npm install -g @anthropic-ai/claude-code`, then `claude` once to sign in.
- **Codex** — `npm install -g @openai/codex`, then `codex login`.

## Use

In Claude Code:

```text
/tidy ~/Downloads
```

In Codex:

```text
/tidy then tell me what to organize
```

Or just describe the scope:

```text
/tidy can you tidy up my Downloads folder? I am only interested in books
```

## How It Works

1. The agent reads `~/.tidy/AGENTS.md` (the constitution) and `~/.tidy/index.md` (the catalog).
2. It identifies the **domain** that matches what you asked for (e.g. filing).
3. It reads `~/.tidy/domains/<name>.md` for that domain's playbook and any relevant `~/.tidy/skills/*.md`.
4. If an approved skill matches, it follows the skill, acts, and logs.
5. If nothing fits, it reads `when-nothing-fits.md` — which either investigates within the current domain, or (when the work is genuinely outside everything Tidy knows) routes to `how-to-update-my-identity.md` to propose a new domain.
6. Either way, every batch ends with a log entry. Every wiki write is approved.

The wiki is the durable part. Skills are case law; domains are constitutional amendments; the runtime is replaceable.

## What Gets Installed

- Claude Code skill: `~/.claude/skills/tidy/SKILL.md`
- Codex slash prompt: `~/.codex/prompts/tidy.md`
- Shared wiki: `~/.tidy/`

```text
~/.tidy/
├── AGENTS.md            the constitution the agent reads on every invocation
├── index.md             catalog of domains and skills you've approved
├── domains/
│   ├── filing.md        the seed domain — organize files on disk
│   └── …                more domains as you teach them
├── skills/
│   ├── how-to-ask.md                ↘
│   ├── how-to-log.md                 ↘
│   ├── how-to-update-the-wiki.md     ↘  the five meta-skills, shipped at install
│   ├── how-to-update-my-identity.md  ↗
│   ├── when-nothing-fits.md          ↗
│   ├── ebook.md                     ↘
│   ├── invoice.md                    ↘  domain skills, written as you approve them
│   └── …                             ↗
└── log/
    ├── index.md         catalog of monthly logs
    └── 2026-05.md       this month's batches
```

## Update And Check

Refresh repo-owned Tidy files without touching your learned skills, user-grown domains, index, or logs:

```bash
git pull
./install.sh --update
```

`--update` refreshes only the constitution: `AGENTS.md`, `domains/filing.md`, the five meta-skills, the Claude Code skill, and the Codex prompt. Local edits get backed up next to the file before replacement.

Check your install:

```bash
./install.sh --doctor
```

## Why

Tidy came from two places: my computer was a mess, and Andrej Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) crystallized the pattern. His gist describes the wiki as a persistent, compounding artifact maintained by an LLM instead of knowledge being rediscovered from scratch every session.

What Tidy adds is small: the wiki holds executable rules instead of synthesized knowledge, organized by domain, and grows by codifying a pattern the first time no existing rule fits — both at the skill level (within a domain) and at the identity level (a whole new domain). The runtime is replaceable; the rulebook is yours.

Thank you, Andrej.

## Docs

- [Teaching Tidy](docs/teaching.md)
- [Undo and Recovery](docs/recovery.md)
- [Runtime and Privacy](docs/runtime-and-privacy.md)
- [Philosophy](docs/philosophy.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)

## Status

v0.2.1. Multi-domain. Pre-alpha — expect the agent's behavior to surprise you sometimes; the playbook in `~/.tidy/AGENTS.md` and the meta skills in `~/.tidy/skills/` are the honest place to push back when it does.

## Uninstall

```bash
rm -rf ~/.tidy ~/.claude/skills/tidy ~/.codex/prompts/tidy.md
```

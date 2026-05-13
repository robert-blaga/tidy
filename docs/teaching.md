# Teaching Tidy

Tidy learns when a batch falls outside the existing wiki and you approve a new skill or skill update.

You can also edit the wiki directly:

```bash
open ~/.tidy
```

## Skill Shape

A skill is just markdown:

```md
# Ebook

## When
Files with extension `.epub`, `.mobi`, or `.azw*`.

## Do
1. Read title and author from the filename.
2. File under `~/Downloads/Books/<genre>/`.

## Sub-cases
- Sci-fi -> `~/Downloads/Books/sci-fi/`
- Nonfiction -> `~/Downloads/Books/nonfiction/`
- Unknown genre -> ask before moving
```

## The Loop

Approved skills are executable memory.

- If a matching skill clearly applies, the agent follows it.
- If nothing fits within the current domain, the agent asks and learns.
- Before changing `~/.tidy/skills/`, `~/.tidy/index.md`, or adding a new user-grown domain in `~/.tidy/domains/`, the agent shows the exact markdown and asks for approval.

The wiki is deliberately boring: readable files, plain markdown, no hidden database.

## Teaching A New Domain

A **domain** is a kind of work — filing is one domain, but you can teach Tidy others (inbox triage, customer research, copy drafting). Domains are bigger than skills: a domain has its own playbook; skills live within it.

If you ask Tidy to do something genuinely outside its current domains, it will recognize the gap and propose a new domain plus a first skill for it. You approve the markdown the same way you approve a skill update. The new domain becomes a peer of filing.

The bar for new domains is high. Skills get proposed often; domains rarely. See `~/.tidy/skills/how-to-update-my-identity.md` for the protocol.

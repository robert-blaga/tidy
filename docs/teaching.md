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
- If nothing fits, the agent asks and learns.
- Before changing `~/.tidy/skills/` or `~/.tidy/index.md`, the agent should show the exact markdown and ask for approval.

The wiki is deliberately boring: readable files, plain markdown, no hidden database.

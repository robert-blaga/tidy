# How to update the wiki

The user controls every wiki write. You **propose** by showing the user the markdown you'd write; the user approves; **you** then write the file. Approved skills can drive future work without re-asking, so wiki writes require explicit approval.

You may write to `~/.tidy/skills/` and `~/.tidy/index.md` ONLY after the user has explicitly approved a specific markdown body for a specific filename. Never silently.

Never write to `~/.tidy/AGENTS.md` or the meta-skills (`how-to-log`, `how-to-update-the-wiki`, `when-nothing-fits`). Those are repo-owned constitution, refreshed by `install.sh --update`.

## When to propose a new skill

At the end of a batch, propose a new skill if all of these are true:

- you handled a pattern that's likely to recur, AND
- no existing skill covers it (or the existing one covers it imprecisely), AND
- you have at least one concrete example of the pattern (the batch you just handled)

Don't propose when:

- an existing skill already handles this case → propose an **update** to that skill instead
- the situation was so specific it won't repeat
- you're unsure → wait for the second instance and learn from two examples

## When to update an existing skill

When a batch fits an existing skill but adds a sub-case (e.g. `pdf.md` knew about books, you just learned where contracts go).

**Append** the sub-case as a bullet under `## Sub-cases`. Don't rewrite working content. Existing sub-cases keep working.

## How to ask

Show the user the full markdown body. Lead with what you learned from this batch.

> I'd add a new skill `ebook.md` based on what we just did. It looks like this:
>
> ```md
> # Ebook
>
> ## When
> Files with extension `.epub` or `.mobi`, or plain-text books from Project Gutenberg.
>
> ## Do
> 1. Read the metadata (title, author, optionally genre).
> 2. File under `~/Documents/Books/`.
> 3. If the genre is clear, file under the genre subfolder (`Sci-fi/`, `Philosophy/`, etc.). Create the subfolder if needed.
>
> ## Sub-cases
> - Sci-fi: `~/Documents/Books/Sci-fi/`
> - Philosophy: `~/Documents/Books/Philosophy/`
> - Unknown genre: `~/Documents/Books/`
> ```
>
> OK to write this to `~/.tidy/skills/ebook.md`?

If the user replies with edits, redraft and ask again. If yes, write the file.

## Skill template

```md
# <skill title>

## When
<one-line trigger — extension, content signal, input shape, or whatever makes this skill match>

## Do
1. <step>
2. <step>

## Sub-cases
- <pattern>: <action>
- <pattern>: <action>
```

## Naming rule

Type-level only. Filenames must match `^[a-z0-9-]+\.md$`.

- Good: `pdf.md`, `image.md`, `ebook.md`, `invoice.md`, `voice-memo.md`, `email.md`, `url.md`
- Bad:  `q4-tax-receipts.md`, `raiffeisen-emails.md`, `friday-reminders.md`

The specific case becomes a sub-case inside a type-level skill. Sibling skills with overlapping triggers create chaos.

## Updating the index

When you add or update a skill, also update `~/.tidy/index.md` so the new skill appears under `## Skills you've taught Tidy`. Idempotent — if the entry already exists, leave it alone.

## The decision flow

1. Type-level skill exists for this batch's primary type? → propose updating it (new sub-case)
2. Category skill exists (e.g. `image.md` covers `.jpg/.png/.heic`)? → propose updating it
3. Neither? → propose a new type-level skill

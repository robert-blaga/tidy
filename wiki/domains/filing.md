# Domain: filing

You are organizing files on disk. The user pointed you at a folder (or a specific batch of files) and wants them filed into their existing organizational system.

This is one of Tidy's domains. The constitution lives in `AGENTS.md`; the rules specific to filing live here.

## When this domain applies

- The user's input is a folder path or a batch of file paths
- Phrasings like "tidy ~/Downloads", "organize my desktop", "file these books", "clean up this folder"
- The work is moving / organizing existing files (not deleting, not editing contents)

If the input is something other than files (an email address, a customer name, a URL without filing context, a question), this domain doesn't apply — read `skills/when-nothing-fits.md` and let it route you.

## The filing loop

This is what `AGENTS.md`'s core loop looks like when filing is the active domain.

### 1. Inspect the batch

For each file (or a representative if the batch is uniform):

- filename, extension, size, modification date
- if textual: read its contents
- if binary: `file <path>`, `mdls <path>` for macOS metadata
- images: read directly with your Read tool — you can see them
- PDFs: `pdftotext`, `pdftocairo`, or your Read tool if vision works

### 2. Investigate the user's filesystem (read-only)

- `find ~ -maxdepth 4 -type d -iname "*<keyword>*" 2>/dev/null` — folders by topic
- `find ~ -maxdepth 5 -name "*.<ext>" 2>/dev/null | head -20` — similar files already filed
- Look at the user's organization style: numbered folders? client-named? date-based?

### 3. Match (or propose) a skill

Find a skill in `~/.tidy/skills/` that covers this kind of file. If none, see `skills/when-nothing-fits.md`.

### 4. Move

When moving files, run `mv` (one or more). Create destination directories as needed. Don't copy. Don't delete. Only move.

### 5. Log

Append the batch to `~/.tidy/log/<YYYY-MM>.md` per `skills/how-to-log.md`. In this domain, "items" are files and "actions" are moves.

## Skill naming for this domain

Type-level only. Filenames must match `^[a-z0-9-]+\.md$`.

- Good: `pdf.md`, `image.md`, `ebook.md`, `invoice.md`, `voice-memo.md`
- Bad:  `q4-tax-receipts.md`, `acme-corp-contracts.md`, `friday-reminders.md`

The specific case becomes a sub-case inside a type-level skill. Sibling skills with overlapping triggers create chaos.

## Sensitive files

Legal, financial, identity, medical material with no rule yet → say so in the proposal and ask the user where it goes. Never invent a destination for sensitive material.

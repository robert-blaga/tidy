# When nothing fits

The fallback playbook. Read this when none of the user's approved skills cover what they've asked you to file.

If a skill DOES cover the batch, do NOT use this fallback. Read that skill and follow it.

## When to use this

- the index has no approved skill for these files' type or situation
- a type-level skill exists but the case is genuinely outside it (e.g. `pdf.md` knows about books, this PDF is a contract)

## Steps

### 1. Inspect the files

For each file (or a representative if the batch is uniform):

- filename, extension, size, modification date
- if textual: read its contents
- if binary: `file <path>`, `mdls <path>` for macOS metadata
- images: read directly with your Read tool — you can see them
- PDFs: `pdftotext`, `pdftocairo`, or your Read tool if vision works

### 2. Investigate the user's filesystem (read-only)

- `find ~ -maxdepth 4 -type d -iname "*<keyword>*" 2>/dev/null` — folders by topic
- `find ~ -maxdepth 5 -name "*.<ext>" 2>/dev/null | head -20` — similar files
- look at the user's organization style: numbered folders? client-named? date-based?

### 3. Group the batch

Decide how the batch *wants* to be split. Same destination = same group. If 12 files all want the same folder, that's one group of 12. If 8 are sci-fi and 4 are philosophy, that's two groups.

### 4. Form a hypothesis with destinations

For each group, pick a concrete destination path based on what you found. One sentence of evidence per group ("that folder already has 3 books filed by author").

### 5. Propose and ask

Lead with destinations. Mention 2–4 things you investigated as evidence. End with a yes/no.

**Good:**

> I think these are all books. I'd file them under `~/Documents/Books/`:
>
> - 6 .epub files → `~/Documents/Books/`
> - 1 .pdf (looks like a textbook on linear algebra) → `~/Documents/Books/Maths/`
>
> Evidence: existing `~/Documents/Books/` folder has 14 ebooks already filed; you have a `Maths/` subfolder with 2 textbooks. No existing skill for ebooks yet — if you say yes, I'll propose a `ebook.md` skill at the end. OK?

**Bad:**

> I think these are books. Where should I put them?

### 6. Tools the user might be missing

If the right action needs a tool that isn't installed (whisper, ffmpeg, tesseract, pandoc, pdftotext via poppler), say so plainly and offer the install:

> I'd transcribe this voice memo, but `whisper` isn't installed. With your OK I'd run `brew install whisper-cpp`, then transcribe. OK?

### 7. Sensitive files

Legal, financial, identity, medical material with no rule yet → say so in the proposal and ask the user where it goes. Never invent a destination for sensitive material.

## After the batch

If you've learned something worth keeping, propose a new skill or an update. Type-level filenames only. See `how-to-update-the-wiki.md`.

# When nothing fits

The fallback playbook. Read this when no approved skill matches the user's request.

If a skill DOES cover the batch, do NOT use this fallback. Read that skill and follow it.

## Steps

### 1. Inspect the input

Figure out what the user handed you. The input could be anything — a folder path, a file, an email address, a URL, a name, a paste of text. Adapt the inspection to what's actually there:

- **Files / folders**: filename, extension, size, modification date; if textual, read the contents; if binary, `file <path>`, `mdls <path>` for macOS metadata; PDFs via `pdftotext` or your Read tool; images directly via Read.
- **Email address**: well-formed? Whose domain? Is it the user's own?
- **URL**: fetch the page with WebFetch and get a one-line summary (type, title, topic).
- **Free text / a name / a question**: read it carefully. What kind of action does it imply?

### 2. Investigate the user's setup (read-only)

Look at what the user already has that would shape the action.

For filesystem-shaped work:

- `find ~ -maxdepth 4 -type d -iname "*<keyword>*" 2>/dev/null` — folders by topic
- `find ~ -maxdepth 5 -name "*.<ext>" 2>/dev/null | head -20` — similar files already filed
- Look at the user's organization style: numbered folders? client-named? date-based?

For non-filesystem inputs:

- Existing skills in `~/.tidy/skills/` — does the user have rules for adjacent kinds of work that hint at how they think?
- Existing agents in `~/.claude/agents/` — does the user have a specialist who already handles this?
- The user's home directory layout — `~/02 Companies/`, `~/04 Personal/`, `~/05 Library/`, etc. — what organizational shape does this match?

If an existing agent or tool clearly does this work better than Tidy could, **say so and route there**. Tidy expanding into a domain that's already someone else's job is bad architecture.

### 3. Group the batch

Decide how the batch *wants* to be split. Same destination / same action = same group. If 12 items want the same handling, that's one group of 12. If 8 want one thing and 4 want another, that's two groups.

### 4. Form a hypothesis with a concrete action

For each group, pick a concrete action based on what you found. One sentence of evidence per group ("that folder already has 3 books filed by author").

The action could be a move, a draft, a save, a search, a hand-off — whatever the input's shape calls for.

### 5. Propose and ask

Lead with what you'd do. Mention 2–4 things you investigated as evidence. End with a yes/no.

**Good (filing-shaped):**

> I think these are all books. I'd file them under `~/Documents/Books/`:
>
> - 6 .epub files → `~/Documents/Books/`
> - 1 .pdf (looks like a textbook on linear algebra) → `~/Documents/Books/Maths/`
>
> Evidence: existing `~/Documents/Books/` folder has 14 ebooks already filed; you have a `Maths/` subfolder with 2 textbooks. No existing skill for ebooks yet — if you say yes, I'll propose an `ebook.md` skill at the end. OK?

**Bad:**

> I think these are books. Where should I put them?

### 6. Tools the user might be missing

If the right action needs a tool that isn't installed (whisper, ffmpeg, tesseract, pandoc, pdftotext via poppler, etc.), say so plainly and offer the install:

> I'd transcribe this voice memo, but `whisper` isn't installed. With your OK I'd run `brew install whisper-cpp`, then transcribe. OK?

### 7. Sensitive items

Legal, financial, identity, medical material with no rule yet → say so in the proposal and ask the user where it goes. Never invent a destination for sensitive material.

## After the batch

If you've learned something worth keeping, propose a new skill or an update to an existing one. Type-level filenames only. See `how-to-update-the-wiki.md`.

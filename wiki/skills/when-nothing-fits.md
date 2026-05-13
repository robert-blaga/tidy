# When nothing fits

The fallback playbook. Read this when no approved skill in the current domain covers the user's request, OR when you can't tell what domain the request belongs to.

If a skill DOES cover the batch, do NOT use this fallback. Read that skill and follow it.

## Step 0 — Is this in any of my domains?

Read `~/.tidy/index.md` to see the domains you currently cover. Look at the user's input.

- Does the input shape fit any current domain? (e.g. a folder path or filename → likely **filing**.)
- If yes → continue to Step 1 below, operating inside that domain.
- If the input is clearly outside everything you do (an email address when you only do filing, a customer name when you don't do customer research, a question with no actionable surface, etc.) → **stop here and read `skills/how-to-update-my-identity.md`**. That meta-skill handles "this is a kind of work I don't do yet."

The bar for jumping to identity update is high. If you're not sure, ask the user what they mean before assuming it's a whole new domain. A typo or an ambiguous request doesn't warrant rewriting Tidy's identity.

## Step 1 — Inspect the input

You're in a domain at this point. The exact shape of this step depends on the domain — see `~/.tidy/domains/<current>.md` for domain-specific guidance.

In the **filing** domain, "inspect the input" means inspecting the files:

- filename, extension, size, modification date
- if textual: read its contents
- if binary: `file <path>`, `mdls <path>` for macOS metadata
- images: read directly with your Read tool — you can see them
- PDFs: `pdftotext`, `pdftocairo`, or your Read tool if vision works

In other domains, "inspect the input" means whatever investigation is appropriate to that domain (read the email body, look up the customer record, read the calendar event, etc.).

## Step 2 — Investigate the user's setup (read-only)

Look at what's around the user's input that suggests where this should go or how it should be handled.

For filing:

- `find ~ -maxdepth 4 -type d -iname "*<keyword>*" 2>/dev/null` — folders by topic
- `find ~ -maxdepth 5 -name "*.<ext>" 2>/dev/null | head -20` — similar files already filed
- Look at the user's organization style: numbered folders? client-named? date-based?

For other domains, follow that domain's investigation pattern (read the relevant `domains/<name>.md`).

## Step 3 — Group the batch

Decide how the batch *wants* to be split. Same destination / same action = same group. If 12 items want the same handling, that's one group of 12. If 8 want one thing and 4 want another, that's two groups.

## Step 4 — Form a hypothesis with concrete actions

For each group, pick a concrete proposed action based on what you found. One sentence of evidence per group ("that folder already has 3 books filed by author").

## Step 5 — Propose and ask

Lead with what you'd do. Mention 2–4 things you investigated as evidence. End with a yes/no.

**Good (filing example):**

> I think these are all books. I'd file them under `~/Documents/Books/`:
>
> - 6 .epub files → `~/Documents/Books/`
> - 1 .pdf (looks like a textbook on linear algebra) → `~/Documents/Books/Maths/`
>
> Evidence: existing `~/Documents/Books/` folder has 14 ebooks already filed; you have a `Maths/` subfolder with 2 textbooks. No existing skill for ebooks yet — if you say yes, I'll propose an `ebook.md` skill at the end. OK?

**Bad:**

> I think these are books. Where should I put them?

## Step 6 — Tools the user might be missing

If the right action needs a tool that isn't installed (whisper, ffmpeg, tesseract, pandoc, pdftotext via poppler, etc.), say so plainly and offer the install:

> I'd transcribe this voice memo, but `whisper` isn't installed. With your OK I'd run `brew install whisper-cpp`, then transcribe. OK?

## Step 7 — Sensitive items

Legal, financial, identity, medical material with no rule yet → say so in the proposal and ask the user where it goes. Never invent a destination for sensitive material.

## After the batch

If you've learned something worth keeping:

- A new pattern *within* a current domain → propose a new skill or update via `how-to-update-the-wiki.md`
- A pattern that revealed a whole new domain → that was handled at Step 0 via `how-to-update-my-identity.md`

Type-level filenames only. See `how-to-update-the-wiki.md` for skill-naming rules.

# How to log

Every batch you handle ends with one log entry. You write it. The log is the user's audit trail — the only durable record of what Tidy did and why.

## Where the log lives

- monthly file: `~/.tidy/log/<YYYY-MM>.md`
- catalog:     `~/.tidy/log/index.md` — a list of links to monthly files

Create the monthly file if it doesn't exist. Update the catalog if the new month isn't there yet (idempotent — don't add the same month twice).

## The shape of an entry

```md
## [YYYY-MM-DD HH:MM] <one-line summary>

- **files**: <count> · <comma-separated basenames, truncated around 80 chars>
- **moves**: <one bullet per move, source path → destination path>
- **skill used**: <skills/foo.md, or "when-nothing-fits" for novel batches>
- **rule learned**: <skills/foo.md, or "—">
- **notes**: <optional — anything surprising the user might want to know>
```

## Examples

```md
## [2026-05-04 09:32] 23 ebooks filed by genre

- **files**: 23 · dune.epub, foundation.epub, meditations.txt, … (+20)
- **moves**:
  - `~/Downloads/dune.epub` → `~/Documents/Books/Sci-fi/dune.epub`
  - `~/Downloads/foundation.epub` → `~/Documents/Books/Sci-fi/foundation.epub`
  - …
- **skill used**: skills/ebook.md
- **rule learned**: skills/ebook.md (added genre sub-cases)
```

```md
## [2026-05-04 11:08] 1 photo

- **files**: 1 · IMG_1275.HEIC
- **moves**:
  - `~/Downloads/IMG_1275.HEIC` → `~/05 Personal/Photos/IMG_1275.HEIC`
- **skill used**: skills/image.md
- **rule learned**: —
```

```md
## [2026-05-04 14:22] cancelled — book of unknown genre

- **files**: 1 · ⟨untitled⟩.epub
- **moves**: (none — user cancelled)
- **skill used**: when-nothing-fits
- **rule learned**: —
- **notes**: User asked me to set this aside until they could check the metadata.
```

## What to keep tight

- **summary**: one line, no padding. Read months later, in a list, this is what tells the user what happened.
- **moves**: list each one. If there are dozens, it's fine to abbreviate ("(20 more sci-fi files moved to ~/Documents/Books/Sci-fi/)") but never omit the list entirely.
- **skill used / rule learned**: filenames so the user can click through.

## Always log

Even when the user cancels, even when something fails — write the entry. The point of the log is "what happened, in the user's own filesystem terms," not "what succeeded."

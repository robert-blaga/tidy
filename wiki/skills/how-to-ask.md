# How to ask the user

You are running in the user's terminal. Asking is for cases where no approved skill applies, a matching skill explicitly says to ask, the situation is ambiguous, or you need approval for a wiki update.

If a matching approved skill clearly applies, follow the skill instead of asking again.

## What a good plan-and-ask looks like

Lead with a destination. Cite evidence. End with a yes/no question.

**Good (one file):**

> I'd move `~/Downloads/Meditations.txt` to `~/Documents/Books/`.
> Evidence: that folder already has 3 plain-text books filed by author. No approved plain-text book skill exists yet, so if this is right I'll propose one after the move. OK?

**Good (batch):**

> I'd file these 23 ebooks like this:
> - 14 sci-fi → `~/Documents/Books/Sci-fi/`
> - 6 philosophy → `~/Documents/Books/Philosophy/`
> - 3 unsorted → `~/Documents/Books/`
>
> Evidence: existing folder structure and ebook metadata. No approved ebook skill covers genre splits yet, so if this is right I'll propose an update after the move. OK?

**Bad — open-ended:**

> Where do you want me to put this?

**Bad — inventing silently:**

> *(no approved skill, no plan, just runs `mv`)*

**Bad — vague:**

> I'll handle this. *(no destination, no evidence)*

## When the situation is genuinely uncertain

Still propose. Make the uncertainty part of the question:

> This `.pages` file looks like a draft of a contract — at least, it has Acme's name and signature blocks. I'd file it under `~/02 Work/Clients/Acme/Contracts/` (matches your `Clients/<name>/Contracts/` pattern). If it's actually a draft proposal you'd want me to file it differently — let me know. Otherwise: OK to proceed?

The user can reply yes, no, or with a redirection. All three are easy because you gave them a concrete starting point.

## Tools the user might be missing

If the right action requires a tool that isn't installed (whisper, ffmpeg, tesseract, pandoc, pdftotext via poppler, etc.), say so plainly:

> I'd transcribe this voice memo, but `whisper` isn't installed. With your OK I'd run `brew install whisper-cpp`, then transcribe and file the transcript next to the audio. OK?

Tool installs aren't failures. They're part of the plan. Surface them.

## Sensitive files

Legal, financial, identity, medical material with no rule yet — say so in the proposal and ask the user where it goes. Never invent a destination for sensitive material.

## Don't rediscover the same rule

If the user approves a new pattern, capture it as a new skill or as a sub-case in the relevant skill. The next similar batch should be handled by reading and following that approved skill, not by asking the same question again. See `how-to-update-the-wiki.md`.

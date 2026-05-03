# Undo And Recovery

Tidy moves files; it does not delete them.

Every batch should be logged under:

```bash
open ~/.tidy/log
```

The log records what moved and why, so if a batch lands in the wrong place you have an audit trail for moving it back.

## Update Backups

`./install.sh --update` refreshes repo-owned files, but it never touches:

- `~/.tidy/index.md`
- your own learned skills
- `~/.tidy/log/**`

If you edited a repo-owned file locally, Tidy backs it up next to the file before replacing it:

```text
~/.tidy/skills/how-to-ask.md.bak-2026-05-03-14-30
```

That makes updates reversible without turning the installer into an interactive merge tool.

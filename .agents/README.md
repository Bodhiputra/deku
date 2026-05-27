# Codex skills alias

This folder exists for **Codex only**.

- **`.agents/skills`** → symlink to **`.claude/skills/`** (canonical skill library)
- Do not add skill files here. Edit skills under `.claude/skills/`.
- If `skills` is a directory instead of a symlink, run `./setup.sh` to fix.
- **`skills.bak.*`** folders are setup backups — gitignored; safe to delete locally.

## Git

- Commit the **symlink** `.agents/skills` (not files inside it).
- If git shows deleted paths under `.agents/skills/…`, that is expected after switching from a duplicate directory to a symlink — stage the deletions and the symlink together.
- Never commit circular symlinks under `.claude/skills/` pointing back to `.agents/`.

See `core/WORKFLOW-LIBRARY.md`.

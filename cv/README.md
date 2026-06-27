# CV — single source of truth

`cv.tex` is the **only** canonical source for Kisoo Kim's CV. The published PDF
at `../assets/cv.pdf` is generated from it. Never hand-edit `assets/cv.pdf`, and
never keep a second "real" copy of the CV elsewhere.

## Edit & deploy

1. Edit `cv.tex`.
2. Run `bash build.sh` (needs `pdflatex` — TinyTeX on this machine). It compiles
   `cv.tex` twice (so hyperref links resolve) and copies the result to
   `../assets/cv.pdf`.
3. Commit `cv.tex` and `assets/cv.pdf` together.

## Keep the homepage and CV in sync

A working paper's **public status must match** between `../index.html` and
`cv.tex`:

- If the homepage links a paper to a PDF (a clickable title), the CV must wrap
  that title in `\href{...}{...}`.
- If the homepage shows a paper as plain text (no link), the CV must leave it
  unlinked.

When you add/remove a paper or change whether its PDF is public, edit **both**
files in the same change. They live in the same repo specifically so that is one
commit. PDF links use `https://kisookim.github.io/assets/papers/<slug>.pdf`.

## Versioning

The canonical CV is a single file under git — no `v1`/`v2` or date-suffixed
copies. Each meaningful change is a commit; `git log -- cv/cv.tex` is the full
history. (This satisfies the repo-wide "never overwrite previous versions" rule:
git history is the version record for this living document.)

## Application variants (e.g. "without phone")

When a job application needs a tweaked CV, copy `cv.tex` into that application's
folder under `Sharing/Application/`, edit the fork there, and compile it locally.
Leave the canonical `cv.tex` untouched. The frozen PDF in the application folder
is your record of exactly what you submitted.

## archive/

`archive/` holds past CV snapshots, consolidated from where they used to be
scattered. It is **gitignored** — kept locally and via Syncthing only, not
committed or published. See `archive/INDEX.md` for the contents and the original
location of each snapshot.

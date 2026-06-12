# kisookim.github.io

Custom single-page academic site. No build step — edit, commit, push; GitHub Pages serves it.

## Add a paper (unified title-led format)
Every entry — Publications, Working Papers, Work in Progress — uses the same `.pub` block:
`Title (with Coauthor). Venue/Status. Award. Links`. The title is plain dark text; everything after it is muted; access links go last.

```html
<!-- working paper with a PDF -->
<div class="pub">Title. <span class="meta">Submitted.</span> <span class="pdf"><a href="assets/papers/<file>.pdf">PDF</a></span></div>

<!-- title-only (no draft yet) -->
<div class="pub">Title. <span class="meta">Submitted.</span></div>

<!-- coauthored work in progress -->
<div class="pub">Title <span class="meta">(with Coauthor).</span></div>

<!-- published -->
<div class="pub">Title <span class="meta">(with Coauthor).</span> <span class="jrnl">Journal Name</span><span class="meta">, 2025. Award.</span> <span class="pdf"><a href="...">PDF</a> · <a href="...">Journal</a> · <a href="...">Replication Data</a></span></div>
```
Drop any PDF in `assets/papers/`. For the job-market paper, add `<span class="jmp">Job Market Paper</span>` right after the opening `<div class="pub">`.

## Update the bio
Edit the text inside `<p class="role">` in the hero.

## Replace the CV or headshot
Overwrite `assets/cv.pdf` or `assets/photo.jpg` (keep the same filenames).

## Keep the footer date current
When you change content, also bump the `Last updated June 2026` line in the `<footer>` of `index.html`. A stale date looks worse than none.

## Design
All styling lives in `styles.css`. Never edit it to add content — only the marked blocks in `index.html` change. Accent color (Vanderbilt gold `#CFAE70`) is used only on section-label markers and the JMP badge; body text stays `#1C1C1C`.

## Deploy
```bash
git add -A && git commit -m "update content" && git push
```
Live within a minute or two at https://kisookim.github.io.

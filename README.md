# kisookim.github.io

Custom single-page academic site. No build step — edit, commit, push; GitHub Pages serves it.

## Add a working paper
Copy one block inside the **Working Papers** `<section>` in `index.html`:
```html
<div class="pub"><a href="assets/papers/<file>.pdf">Title</a>. <span class="meta">Submitted.</span> <span class="pdf"><a href="assets/papers/<file>.pdf">PDF</a></span></div>
```
Drop the PDF in `assets/papers/`. For the job-market paper, add `<span class="jmp">Job Market Paper</span>` right after the opening `<div class="pub">`. For a title-only entry (no draft yet), omit both `<a>` tags and the `.pdf` span.

## Update the bio
Edit the text inside `<p class="role">` in the hero.

## Replace the CV or headshot
Overwrite `assets/cv.pdf` or `assets/photo.jpg` (keep the same filenames).

## Design
All styling lives in `styles.css`. Never edit it to add content — only the marked blocks in `index.html` change. Accent color (Vanderbilt gold `#CFAE70`) is used only on section-label markers and the JMP badge; body text stays `#1C1C1C`.

## Deploy
```bash
git add -A && git commit -m "update content" && git push
```
Live within a minute or two at https://kisookim.github.io.

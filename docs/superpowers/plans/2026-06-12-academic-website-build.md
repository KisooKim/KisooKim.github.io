# Academic Website Build — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build Kisoo Kim's custom single-page static academic site and deploy it to GitHub Pages at `https://kisookim.github.io`.

**Architecture:** One `index.html` (semantic, content inline in clearly-marked blocks) + one `styles.css` (the locked design system) + local `assets/`. No build step; GitHub Pages serves the repo root. Verification is by rendering the page with Playwright (desktop + mobile screenshots) and checking links/assets resolve.

**Tech Stack:** Plain HTML5 + CSS (Inter via Google Fonts). Playwright (Python, already installed) for render verification. `gh` CLI / git for deploy.

**Source of truth:** `docs/superpowers/specs/2026-06-12-academic-website-redesign-design.md`. §2 = design tokens, §5 = exact content, §6 = asset table.

---

## File Structure

```
KisooKim.github.io/   (= this folder, local name "Academic Website")
├── index.html            # the single page
├── styles.css            # design system (never edited when adding content)
├── favicon.svg           # monogram
├── .nojekyll             # tell GitHub Pages to serve files as-is
├── README.md             # "how to add a paper" recipes
├── assets/
│   ├── photo.jpg
│   ├── cv.pdf
│   └── papers/*.pdf
├── _audit/               # gitignored — dev tools (render.py) + screenshots
└── docs/                 # gitignored from site? (decided in Task 9); spec+plan live here
```

---

## Task 1: Scaffold + reusable render-check tool

**Files:**
- Create: `index.html`, `styles.css`, `.nojekyll`, `favicon.svg`, `_audit/render.py`

- [ ] **Step 1: Create `.nojekyll`** (empty file)

```
(empty)
```

- [ ] **Step 2: Create `favicon.svg`** — gold-on-white monogram "K"

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
  <rect width="32" height="32" rx="6" fill="#1C1C1C"/>
  <text x="16" y="22" font-family="Georgia, serif" font-size="18" font-weight="700"
        text-anchor="middle" fill="#CFAE70">K</text>
</svg>
```

- [ ] **Step 3: Create `index.html` skeleton** (head + empty `<main>`)

```html
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Kisoo Kim</title>
<meta name="description" content="Kisoo Kim — Postdoctoral Research Associate at the Center for Effective Lawmaking, University of Virginia. Research on electoral institutions, information environments, and legislative behavior.">
<meta name="author" content="Kisoo Kim">
<meta property="og:title" content="Kisoo Kim">
<meta property="og:description" content="Postdoctoral Research Associate, Center for Effective Lawmaking, University of Virginia.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://kisookim.github.io">
<link rel="icon" href="favicon.svg" type="image/svg+xml">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="styles.css">
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"Person","name":"Kisoo Kim",
"jobTitle":"Postdoctoral Research Associate",
"affiliation":{"@type":"Organization","name":"University of Virginia, Center for Effective Lawmaking"},
"alumniOf":{"@type":"Organization","name":"University of Chicago"},
"email":"mailto:kisoo@virginia.edu","url":"https://kisookim.github.io",
"sameAs":["https://scholar.google.com/citations?hl=en&user=YvEvk6MAAAAJ"]}
</script>
</head>
<body>
<main class="wrap">
  <!-- sections added in later tasks -->
</main>
</body>
</html>
```

- [ ] **Step 4: Create `styles.css`** (empty placeholder for now)

```css
/* design system added in Task 2 */
```

- [ ] **Step 5: Create `_audit/render.py`** (reusable verification tool)

```python
import sys, time
from playwright.sync_api import sync_playwright
URL = "file:///" + __file__.replace("\\","/").rsplit("/_audit/",1)[0] + "/index.html"
OUT = __file__.replace("\\","/").rsplit("/",1)[0]
def shoot(page, path, full=True):
    page.wait_for_timeout(900); page.screenshot(path=path, full_page=full)
with sync_playwright() as p:
    b = p.chromium.launch(channel="chrome", headless=True)
    d = b.new_context(viewport={"width":1100,"height":900}, device_scale_factor=1).new_page()
    d.goto(URL, wait_until="networkidle", timeout=30000); shoot(d, f"{OUT}/r_desktop.png")
    m = b.new_context(viewport={"width":390,"height":844}, device_scale_factor=2, is_mobile=True).new_page()
    m.goto(URL, wait_until="networkidle", timeout=30000); shoot(m, f"{OUT}/r_mobile.png")
    b.close()
print("rendered", URL)
```

- [ ] **Step 6: Run render to confirm skeleton loads**

Run: `python "_audit/render.py"`
Expected: prints `rendered file:///.../index.html`, produces `_audit/r_desktop.png` (blank page, no errors).

- [ ] **Step 7: Commit**

```bash
git add index.html styles.css .nojekyll favicon.svg
git commit -m "scaffold static site (skeleton, favicon, meta, render tool)"
```

---

## Task 2: Design system (`styles.css`)

**Files:** Modify `styles.css` (full content below — exact tokens from spec §2)

- [ ] **Step 1: Write the complete `styles.css`**

```css
:root{
  --gold:#CFAE70; --gold-dk:#B49248; --ink:#1C1C1C; --muted:#5f6671;
  --soft:#9aa0a6; --hair:#ededed; --bg:#ffffff;
}
*{box-sizing:border-box}
html{-webkit-text-size-adjust:100%}
body{margin:0;background:var(--bg);color:var(--ink);
  font-family:'Inter',system-ui,-apple-system,sans-serif;font-size:15.5px;line-height:1.6;
  -webkit-font-smoothing:antialiased;}
.wrap{max-width:900px;margin:0 auto;padding:54px 54px 64px;}
a{color:var(--ink);text-decoration:underline;text-decoration-color:#dcdcdc;text-underline-offset:2px;}
a:hover{text-decoration-color:var(--gold);}

/* hero */
.name{font-size:30px;font-weight:700;letter-spacing:-.015em;margin:0 0 22px;}
.hero{display:flex;gap:40px;align-items:flex-start;}
.hero .txt{flex:1;}
.role{font-size:15.5px;line-height:1.65;color:#33383f;max-width:54ch;margin:0;}
.links{margin-top:18px;display:flex;gap:20px;flex-wrap:wrap;font-size:13.5px;}
.photo{width:120px;height:148px;border-radius:6px;flex-shrink:0;object-fit:cover;border:1px solid var(--hair);}

/* sections */
section{margin-top:42px;}
h2.label{font-size:12.5px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;
  color:var(--ink);margin:0 0 16px;padding-bottom:9px;border-bottom:1px solid var(--hair);position:relative;}
h2.label::after{content:"";position:absolute;left:0;bottom:-1px;width:44px;height:2px;background:var(--gold);}

.pub{margin-bottom:16px;line-height:1.5;font-size:14.5px;}
.jrnl{font-style:italic;color:var(--muted);}
.meta{color:var(--muted);}
.pdf{font-size:12.5px;color:var(--muted);}
.jmp{display:inline-block;font-size:10px;font-weight:700;letter-spacing:.04em;text-transform:uppercase;
  background:var(--gold);color:var(--ink);padding:3px 8px;border-radius:4px;margin-right:9px;vertical-align:1.5px;}

.wip{margin-bottom:11px;line-height:1.5;font-size:14.5px;color:#33383f;}
.teach{font-size:14.5px;line-height:1.7;color:#33383f;}
.teach b{font-weight:600;color:var(--ink);}
details{margin-top:12px;}
summary{font-size:13px;color:var(--muted);cursor:pointer;}
details ul{margin:10px 0 0;padding-left:18px;font-size:13.5px;color:#33383f;line-height:1.7;}

.cvrow{font-size:14.5px;line-height:1.8;color:#33383f;}
.cvrow b{font-weight:600;color:var(--ink);}
footer{margin-top:54px;padding-top:20px;border-top:1px solid var(--hair);font-size:13px;color:var(--muted);}

/* responsive */
@media(max-width:640px){
  .wrap{padding:34px 22px 44px;}
  .hero{flex-direction:column-reverse;gap:22px;align-items:flex-start;}
  .photo{width:110px;height:136px;}
  .name{font-size:26px;}
}
```

- [ ] **Step 2: Commit** (visual effect appears once content lands in Task 4+)

```bash
git add styles.css
git commit -m "add design system (Direction 2 + Vanderbilt gold, strict accent rules)"
```

---

## Task 3: Gather assets from Google Drive

**Files:** Create `assets/cv.pdf`, `assets/papers/*.pdf`, `assets/photo.jpg`

- [ ] **Step 1: Download PDFs from Drive** (ids from spec §6)

```bash
mkdir -p assets/papers
dl(){ curl -sL "https://drive.google.com/uc?export=download&id=$1" -o "$2"; }
dl 1T0_c8NQ2WbA2R2oXL00gZ-pG30AbUoHW assets/cv.pdf
dl 1m1jgTXpC5zeA5zIU7wuBpfT4KOB7MViF assets/papers/partisan-media-sorting.pdf
dl 1q9ctIJOSt0T7wseUnqB-UQLFte2WV-Nt assets/papers/lame-duck-by-primary.pdf
dl 1bgdu83-3a4Hx4-0rT-jEzip4Yr-u3FXk assets/papers/strategic-media-bias.pdf
dl 1Fd8UuTniEYVeZSngnNjnQhHX3AP--NDu assets/papers/electoral-college-polarization.pdf
```

- [ ] **Step 2: Verify each is a real PDF (not an HTML error/"too large" interstitial)**

Run: `for f in assets/cv.pdf assets/papers/*.pdf; do printf "%s " "$f"; head -c4 "$f"; echo " ($(wc -c <"$f") bytes)"; done`
Expected: each starts with `%PDF` and is > 10 KB.
**If a file starts with `<!DOCTYPE` or is tiny:** Drive returned a confirm/permission page. Retry with the confirm-token form, or fall back to linking the Drive URL in the HTML and flag that file for Kisoo to supply. Record which files fell back.

- [ ] **Step 3: Extract the headshot from the current Google Site**

```python
# _audit/get_photo.py
from playwright.sync_api import sync_playwright
import urllib.request
with sync_playwright() as p:
    b=p.chromium.launch(channel="chrome",headless=True); pg=b.new_page()
    pg.goto("https://sites.google.com/view/kisookim/",wait_until="networkidle",timeout=60000)
    pg.wait_for_timeout(1500)
    srcs=pg.eval_on_selector_all("img","els=>els.map(e=>({s:e.src,w:e.naturalWidth,h:e.naturalHeight}))")
    b.close()
cands=[x for x in srcs if x["w"]>=180 and x["h"]>=180 and 0.6<x["w"]/x["h"]<1.0]
print("\n".join(f'{x["w"]}x{x["h"]} {x["s"]}' for x in (cands or srcs)))
```

Run: `python "_audit/get_photo.py"`, pick the portrait-ratio headshot URL, then:
`curl -sL "<url>=s800" -o assets/photo.jpg` (append `=s800` to googleusercontent URLs for higher res).
Expected: `assets/photo.jpg` is a JPEG > 20 KB. **If extraction fails or is low-res:** flag for Kisoo to supply a high-res headshot.

- [ ] **Step 4: Commit**

```bash
git add assets
git commit -m "add consolidated assets (CV, paper PDFs, headshot)"
```

---

## Task 4: Hero section

**Files:** Modify `index.html` (insert inside `<main class="wrap">`)

- [ ] **Step 1: Add the hero block**

```html
<h1 class="name">Kisoo Kim</h1>
<div class="hero">
  <div class="txt">
    <p class="role">I am a Postdoctoral Research Associate at the Center for Effective Lawmaking at the University of Virginia's Frank Batten School of Leadership and Public Policy. I received my Ph.D. from the University of Chicago's Harris School of Public Policy in 2025. My research examines how electoral institutions and information environments shape legislative behavior and democratic accountability in the United States.</p>
    <div class="links">
      <a href="mailto:kisoo@virginia.edu">kisoo@virginia.edu</a>
      <a href="https://scholar.google.com/citations?hl=en&user=YvEvk6MAAAAJ">Google Scholar</a>
      <a href="assets/cv.pdf">CV (PDF)</a>
    </div>
  </div>
  <img class="photo" src="assets/photo.jpg" alt="Kisoo Kim">
</div>
```

- [ ] **Step 2: Render + verify**

Run: `python "_audit/render.py"` then inspect `_audit/r_desktop.png`.
Expected: name in Inter bold, bio paragraph, three links with faint underlines, headshot at right. No broken-image icon.

- [ ] **Step 3: Commit**

```bash
git add index.html && git commit -m "add hero (bio, links, headshot)"
```

---

## Task 5: Publications + Working Papers

**Files:** Modify `index.html` (append after hero). Content verbatim from spec §5; status "Submitted" preserved; two papers title-only.

- [ ] **Step 1: Add Publications + Working Papers sections**

```html
<section>
  <h2 class="label">Publications</h2>
  <div class="pub">Fowler, Anthony and Kisoo Kim. 2022. <a href="assets/papers/partisan-media-sorting.pdf">An Information-Based Explanation for Partisan Media Sorting</a>. <span class="jrnl">Journal of Theoretical Politics</span>. <span class="meta">Ostrom Award (2023).</span>
    <span class="pdf"><a href="assets/papers/partisan-media-sorting.pdf">PDF</a> · <a href="https://journals.sagepub.com/doi/abs/10.1177/09516298221122094">Journal</a> · <a href="https://www.dropbox.com/sh/8nkxg3oa9x9acuy/AAAcxgR8PZDyruDiKVgzRmf4a?dl=0">Replication Data</a></span></div>
</section>

<section>
  <h2 class="label">Working Papers</h2>
  <div class="pub"><span class="jmp">Job Market Paper</span><a href="assets/papers/lame-duck-by-primary.pdf">Lame Duck by Primary: Effects of Electoral Incentives on U.S. House Representatives</a>. <span class="meta">R&amp;R, <span class="jrnl">Quarterly Journal of Political Science</span>. Virginia Gray Award (2024).</span> <span class="pdf"><a href="assets/papers/lame-duck-by-primary.pdf">PDF</a></span></div>
  <div class="pub">Information Poverty and Electoral Politics: Radio Expansion in Interwar America. <span class="meta">Submitted.</span></div>
  <div class="pub">The Rigidity of Legislative Positions: No Detectable Response to Extreme Challengers. <span class="meta">Submitted.</span></div>
  <div class="pub"><a href="assets/papers/strategic-media-bias.pdf">Strategic Media Bias</a>. <span class="meta">Submitted.</span> <span class="pdf"><a href="assets/papers/strategic-media-bias.pdf">PDF</a></span></div>
  <div class="pub"><a href="assets/papers/electoral-college-polarization.pdf">Does the Electoral College Foster Polarization? Turnout and Opposition Demobilization</a>. <span class="meta">Submitted.</span> <span class="pdf"><a href="assets/papers/electoral-college-polarization.pdf">PDF</a></span></div>
</section>
```

- [ ] **Step 2: Render + verify**

Run: `python "_audit/render.py"`.
Expected: gold "JOB MARKET PAPER" badge before Lame Duck; section labels show short gold underline marker; two papers (Information Poverty, Rigidity) are plain text with no link; PDF links present on the other three.

- [ ] **Step 3: Verify local PDF links resolve**

Run: `for f in partisan-media-sorting lame-duck-by-primary strategic-media-bias electoral-college-polarization; do test -s "assets/papers/$f.pdf" && echo "OK $f" || echo "MISSING $f"; done`
Expected: all `OK`.

- [ ] **Step 4: Commit**

```bash
git add index.html && git commit -m "add publications + working papers (JMP flagged)"
```

---

## Task 6: Work in Progress + Teaching

**Files:** Modify `index.html` (append). WIP 7 items + Teaching with `<details>` TA list (18 items verbatim from spec §5).

- [ ] **Step 1: Add Work in Progress**

```html
<section>
  <h2 class="label">Work in Progress</h2>
  <div class="wip">When Newspapers Made Better Lawmakers: Media Entry and Legislative Effectiveness in the U.S. House <span class="meta">(with Craig Volden)</span></div>
  <div class="wip">Electoral Reform and Legislative Effectiveness <span class="meta">(with Craig Volden)</span></div>
  <div class="wip">Seeing Is Selecting: How Television Changed Congressional Representation</div>
  <div class="wip">Seeing Your Representative: How Television Market Congruence Enables Ideological Accountability in U.S. House Elections</div>
  <div class="wip">Presidential-House Coattail Effects</div>
  <div class="wip">Political Efficacy and Voter Turnout</div>
  <div class="wip">The Impact of Social Media on Student Political Attitudes: Evidence from the Staggered Rollout of Facebook</div>
</section>
```

- [ ] **Step 2: Add Teaching (instructors visible, TA list collapsed)**

```html
<section>
  <h2 class="label">Teaching</h2>
  <div class="teach">
    <b>Instructor — University of Virginia.</b> Politics of Public Policy (2026); Seeing Politics through Theory and Data (2026)<br>
    <b>Instructor — University of Chicago.</b> Mathematical Methods for Social Science (2021, 2022)
  </div>
  <details>
    <summary>Teaching assistant — 18 appointments, 2019–2025 (show full list)</summary>
    <ul>
      <li>Statistics for Data Analysis II: Regressions (Master's, Head TA), Winter 2025</li>
      <li>Principles of Microeconomics and Public Policy II (Master's, Head TA), Winter 2025</li>
      <li>Data and Programming for Public Policy (Master's, Head TA), Spring 2024</li>
      <li>Analytical Politics 2 (Master's, Head TA), Winter 2024</li>
      <li>Game Theory (Ph.D.), Fall 2023, 2022</li>
      <li>Strategic Decision Making in Public Policy, Fall 2023</li>
      <li>Applied Econometrics, Fall 2023</li>
      <li>Microeconomics 2 (Ph.D.), Winter 2022</li>
      <li>Game Theory (Ph.D.), Fall 2021</li>
      <li>Formal Models of Domestic Politics (Ph.D.), Winter 2020</li>
      <li>Analytical Politics 1 (Master's, Head TA), Fall 2020</li>
      <li>Mathematical Methods in Social Science (Ph.D. Math Camp), Summer 2020</li>
      <li>Political Economy 2 (Ph.D.), Winter 2020</li>
      <li>Political Economy 1 (Ph.D.), Fall 2019</li>
      <li>Data and Policy Summer Scholar Program, Summer 2019</li>
      <li>Math Camp for Incoming Master's Students, Summer 2019</li>
      <li>Microeconomics for Public Policy (Undergraduate), Spring 2019</li>
    </ul>
  </details>
</section>
```
*(Note: spec lists 18 appointments but "Game Theory Fall 2023, 2022" is one line covering two terms; the verbatim list above matches the current site. If Kisoo wants each year split, adjust during review.)*

- [ ] **Step 3: Render + verify the `<details>` toggle**

Run: `python "_audit/render.py"`.
Expected: WIP shows 7 lines; Teaching shows two instructor lines + a collapsed "show full list" summary. Manually confirm clicking the summary expands the list (or add `open` temporarily to screenshot the expanded state, then remove).

- [ ] **Step 4: Commit**

```bash
git add index.html && git commit -m "add work in progress + teaching (TA list collapsible)"
```

---

## Task 7: CV section + footer

**Files:** Modify `index.html` (append).

- [ ] **Step 1: Add CV + footer**

```html
<section>
  <h2 class="label">Curriculum Vitae</h2>
  <div class="cvrow">
    <b>Education.</b> Ph.D., Harris School of Public Policy, University of Chicago, 2025<br>
    <b>Appointment.</b> Postdoctoral Research Associate, Center for Effective Lawmaking, University of Virginia, 2025–<br>
    <a href="assets/cv.pdf">Download full CV (PDF)</a>
  </div>
</section>

<footer>
  Kisoo Kim · <a href="mailto:kisoo@virginia.edu">kisoo@virginia.edu</a>
</footer>
```
*(Earlier-education entries are an Open Item — fill from the CV PDF during review if Kisoo wants them shown.)*

- [ ] **Step 2: Render full page + verify**

Run: `python "_audit/render.py"`; inspect `_audit/r_desktop.png` and `_audit/r_mobile.png`.
Expected desktop: full single-page flow Hero → Publications → Working Papers → WIP → Teaching → CV → footer, consistent gold section markers, single gold JMP badge.
Expected mobile: single column, photo stacks above the bio (column-reverse), padding reduced, no horizontal overflow.

- [ ] **Step 3: Commit**

```bash
git add index.html && git commit -m "add CV section + footer"
```

---

## Task 8: README (content recipes) + final QA pass

**Files:** Create `README.md`; possibly tweak `index.html`/`styles.css` from QA findings.

- [ ] **Step 1: Write `README.md`**

````markdown
# kisookim.github.io

Custom single-page academic site. No build step — edit, commit, push; GitHub Pages serves it.

## Add a working paper
Copy one block inside the Working Papers `<section>` in `index.html`:
```html
<div class="pub"><a href="assets/papers/<file>.pdf">Title</a>. <span class="meta">Submitted.</span> <span class="pdf"><a href="assets/papers/<file>.pdf">PDF</a></span></div>
```
Drop the PDF in `assets/papers/`. For the job-market paper add `<span class="jmp">Job Market Paper</span>` first. For a title-only entry, omit both `<a>` tags.

## Update the bio
Edit the `<p class="role">` text in the hero.

## Design
All styling is in `styles.css`. Don't edit it to add content — only the blocks in `index.html` change.
````

- [ ] **Step 2: QA checklist (fix inline if any fail)**

Run: `python "_audit/render.py"` and check:
- Contrast: body/links are `#1C1C1C` (never gold). Gold appears only on section markers + JMP badge + link hover. ✓
- All `<a href>` resolve: local files exist; external URLs are the spec's (SAGE DOI, Dropbox, Scholar, mailto).
- Semantics: one `<h1>` (name), `<h2 class="label">` per section, `<main>`/`<section>`/`<footer>` present, `<img>` has alt.
- Mobile screenshot has no overflow.

Run link existence check:
`grep -oE 'href="assets/[^"]+"' index.html | sed 's/href="//;s/"//' | sort -u | while read f; do test -e "$f" && echo "OK $f" || echo "MISSING $f"; done`
Expected: all `OK`.

- [ ] **Step 3: Commit**

```bash
git add README.md index.html styles.css
git commit -m "add README content recipes + final QA fixes"
```

---

## Task 9: Deploy to GitHub Pages

**Files:** none (repo/remote operations). **Requires Kisoo's GitHub account `KisooKim`.**

- [ ] **Step 1: Decide docs/_audit exposure**

`_audit/` and `.superpowers/` are already gitignored. Decide on `docs/` (currently tracked, holds spec + this plan):
- **Recommended:** leave it — non-sensitive design notes, unlinked, harmless. OR
- Exclude from the public site: `git rm -r --cached docs && echo "docs/" >> .gitignore && git commit -m "keep planning docs out of the published site"`.

Confirm choice with Kisoo before pushing.

- [ ] **Step 2: Check `gh` auth**

Run: `gh auth status`
Expected: logged in as `KisooKim`. If not: `gh auth login` (Kisoo completes the browser step), or create the repo manually at github.com.

- [ ] **Step 3: Create the repo and push**

```bash
gh repo create KisooKim.github.io --public --source=. --remote=origin --push
```
(If `gh` unavailable: create `KisooKim.github.io` on github.com, then `git remote add origin https://github.com/KisooKim/KisooKim.github.io.git && git push -u origin main`.)

- [ ] **Step 4: Enable Pages (user sites usually auto-enable)**

Run: `gh api repos/KisooKim/KisooKim.github.io/pages -X POST -f source[branch]=main -f source[path]=/ 2>/dev/null || echo "already enabled or set it in Settings → Pages"`

- [ ] **Step 5: Verify live**

Wait ~1–2 min, then:
Run: `python -c "import urllib.request as u; print(u.urlopen('https://kisookim.github.io',timeout=30).status)"`
Expected: `200`. Then render the live URL (edit `_audit/render.py` URL or just open in browser) and confirm it matches the local screenshots.

- [ ] **Step 6: Final report** — give Kisoo the live URL and the "how to add a paper" pointer (README).

---

## Self-Review (completed)

- **Spec coverage:** §1 goals → Tasks 4–9; §2 design system → Task 2; §3 IA order → Tasks 4–7; §4 inline model + README → Tasks 5/8; §5 content (verbatim, "Submitted", title-only ×2, JMP) → Tasks 4–7; §6 assets → Task 3; §7 deploy + docs exposure → Task 9; §8 favicon/SEO/a11y → Tasks 1/8; §9 YAGNI honored (no extra sections); §10 Open Items flagged inline (photo Task 3, CV detail Task 7, teaching links optional, bio copy Task 4). No gaps.
- **Placeholders:** none — every code step has complete code; Open Items are explicitly deferred decisions, not vague TODOs.
- **Consistency:** CSS class names (`pub`, `jmp`, `label`, `wip`, `teach`, `role`, `links`, `photo`, `cvrow`) defined in Task 2 are the same ones used in Tasks 4–7. Drive ids match spec §6.
```

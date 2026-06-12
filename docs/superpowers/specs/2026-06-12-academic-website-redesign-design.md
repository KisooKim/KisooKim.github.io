# Academic Website Redesign — Design Spec

**Date:** 2026-06-12
**Owner:** Kisoo Kim
**Goal:** Replace the current Google Sites page (`sites.google.com/view/kisookim`) with a custom static site optimized for the tenure-track job market.

---

## 1. Goals & Constraints

- **Primary purpose:** TT job-market presentation — research must dominate; the job-market paper must be unmistakable.
- **Design model (user's words):** "디자인과 format화를 내가 원하는대로 먼저 만들고, 그 포맷에 논문을 추가/변경하거나 자기소개를 바꾸고자 해." → Design is fixed and custom; content is easy to swap within that fixed format.
- **Platform:** Pure custom static site (no build toolchain). Chosen over academicpages (too templated) and custom Jekyll (build step slows design iteration).
- **Hosting:** GitHub Pages, user site. Username `KisooKim` → repo `KisooKim.github.io` → served at `https://kisookim.github.io`. No custom domain for now (can be added later via `CNAME` with zero redesign).
- **Timeline:** ASAP.
- **Structure:** Keep the current sections, tidied. Single continuous page — no separate Research/Teaching/CV pages, no page-level navigation.

---

## 2. Design System (locked)

**Direction:** Modern Minimal (Direction 2) with Vanderbilt accent.

- **Typeface:** Inter (weights 400/500/600/700), loaded from Google Fonts.
- **Color palette:**
  | Token | Hex | Use |
  |---|---|---|
  | Background | `#FFFFFF` | page background |
  | Ink | `#1C1C1C` | body text, headings, links (Vanderbilt black) |
  | Muted | `#5f6671` | secondary text, journal names, status, meta |
  | Hairline | `#ededed` | section dividers |
  | Accent gold | `#CFAE70` | accent only (see rules) — Vanderbilt flat gold |
  | Dark gold | `#B49248` | optional darker accent variant |

- **Gold usage rules (strict — gold is a graphic accent, never a text color):**
  1. **Section-label underline marker** — a short bar (~44px × 2px) under each section heading.
  2. **JMP badge fill** — gold background with `#1C1C1C` text.
  3. **Link hover** — underline turns gold on hover.
  - NEVER: gold as text/link color (fails contrast 1.8:1 on white), no top color bar, no photo border, no scattered gold. The earlier "too much gold" version is explicitly rejected.

- **Typography:**
  - Name: 30px / 700 / letter-spacing −0.015em.
  - Section labels: 12.5px / 600 / uppercase / letter-spacing 0.1em / color `#1C1C1C`, with gold underline marker + `#ededed` hairline.
  - Body: 14.5–15.5px / line-height 1.5–1.65.
  - Journal titles: italic, muted.
  - Links: `#1C1C1C` with a faint gray underline (`#dcdcdc`) at rest → gold on hover.

- **Layout:**
  - Single centered column, content max-width ~900px, generous padding (~48–54px desktop).
  - Body measure constrained (~54ch) for readability.
  - Hero: text column (left) + headshot (right, ~120×148).
  - Responsive: below ~640px the photo stacks, single column, padding reduces.

---

## 3. Information Architecture (single page, top → bottom)

1. **Hero** — name, bio paragraph, link row (email · Google Scholar · CV PDF), headshot.
2. **Publications**
3. **Working Papers** (JMP first, flagged)
4. **Work in Progress**
5. **Teaching** — instructor courses visible; full TA list inside a native HTML `<details>` collapsible (no JS).
6. **Curriculum Vitae** — education, current appointment, "Download full CV (PDF)".
7. **Footer** — email, copyright.

No top navigation (single page, per user request).

---

## 4. Content Model (inline blocks)

All content lives in `index.html` as clearly-delimited, copy-pasteable blocks. All visual styling lives in `styles.css` and is never touched when editing content. Adding a paper = copy one block, change the text:

```html
<!-- ▼ add a working paper: copy this block -->
<div class="pub"><a href="assets/papers/<file>.pdf">Title</a>.
  <span class="meta">Submitted.</span></div>
```

`README.md` documents the add/edit recipes. (Data-file + JS rendering was considered and rejected: weaker name-search SEO and more code, not worth it for ~15 entries.)

---

## 5. Content Migration (exact, from current site)

Status wording preserved as **"Submitted"** (user decision). Two working papers shown **title-only** (no draft link), per user.

**Bio (hero):** "Postdoctoral Research Associate at the Center for Effective Lawmaking, University of Virginia. Ph.D., University of Chicago, 2025. I study how electoral institutions and information environments shape legislative behavior and democratic accountability in the United States." (final wording to confirm against current site copy)

**Links:** `mailto:kisoo@virginia.edu` · Google Scholar `https://scholar.google.com/citations?hl=en&user=YvEvk6MAAAAJ` · CV `assets/cv.pdf`.

**Publications**
- Fowler, Anthony and Kisoo Kim. 2022. "An Information-Based Explanation for Partisan Media Sorting." *Journal of Theoretical Politics.* — Ostrom Award (2023). Links: PDF (local), Journal (SAGE DOI), Replication Data (Dropbox).

**Working Papers**
1. **[Job Market Paper]** "Lame Duck by Primary: Effects of Electoral Incentives on U.S. House Representatives." R&R, *Quarterly Journal of Political Science.* — Virginia Gray Award (2024). PDF (local).
2. "Information Poverty and Electoral Politics: Radio Expansion in Interwar America." Submitted. *(title only)*
3. "The Rigidity of Legislative Positions: No Detectable Response to Extreme Challengers." Submitted. *(title only)*
4. "Strategic Media Bias." Submitted. PDF (local).
5. "Does the Electoral College Foster Polarization? Turnout and Opposition Demobilization." Submitted. PDF (local).

**Work in Progress**
1. When Newspapers Made Better Lawmakers: Media Entry and Legislative Effectiveness in the U.S. House (with Craig Volden)
2. Electoral Reform and Legislative Effectiveness (with Craig Volden)
3. Seeing Is Selecting: How Television Changed Congressional Representation
4. Seeing Your Representative: How Television Market Congruence Enables Ideological Accountability in U.S. House Elections
5. Presidential-House Coattail Effects
6. Political Efficacy and Voter Turnout
7. The Impact of Social Media on Student Political Attitudes: Evidence from the Staggered Rollout of Facebook

**Teaching**
- *Instructor — University of Virginia:* Politics of Public Policy (2026); Seeing Politics through Theory and Data (2026).
- *Instructor — University of Chicago:* Mathematical Methods for Social Science (2021, 2022). [optional: syllabus + teaching-evaluation links]
- *Teaching Assistant (in `<details>`):* 18 appointments, 2019–2025 (full list copied verbatim from current site — Statistics for Data Analysis II, Microeconomics & Public Policy II, Data & Programming, Analytical Politics 1/2, Game Theory ×2, Strategic Decision Making, Applied Econometrics, Microeconomics 2, Formal Models of Domestic Politics, Math Camp, Political Economy 1/2, Data & Policy Summer Scholar, Microeconomics for Public Policy).

**Curriculum Vitae**
- Education: Ph.D., Harris School of Public Policy, University of Chicago, 2025. (earlier degrees to be filled from the CV PDF)
- Appointment: Postdoctoral Research Associate, Center for Effective Lawmaking, University of Virginia, 2025–.
- Download full CV (PDF, local).

---

## 6. Asset Plan

Consolidate scattered assets into the repo (fixes the audit's fragile-link finding). Fetch from the current Google Drive links (user-approved):

| Asset | Source (Drive id / URL) | Destination |
|---|---|---|
| CV | `1T0_c8NQ2WbA2R2oXL00gZ-pG30AbUoHW` | `assets/cv.pdf` |
| Fowler & Kim (2022) | `1m1jgTXpC5zeA5zIU7wuBpfT4KOB7MViF` | `assets/papers/partisan-media-sorting.pdf` |
| Lame Duck by Primary (JMP) | `1q9ctIJOSt0T7wseUnqB-UQLFte2WV-Nt` | `assets/papers/lame-duck-by-primary.pdf` |
| Strategic Media Bias | `1bgdu83-3a4Hx4-0rT-jEzip4Yr-u3FXk` | `assets/papers/strategic-media-bias.pdf` |
| Electoral College & Polarization | `1Fd8UuTniEYVeZSngnNjnQhHX3AP--NDu` | `assets/papers/electoral-college-polarization.pdf` |
| Headshot | extract from current Google Site (Google-hosted img) | `assets/photo.jpg` |
| (optional) Math Methods syllabus | `1cIxXEJ0DtigCfA8vFPr8sLFUKCgiTkU8` | `assets/teaching/` |
| (optional) Teaching evals 2021/2022 | `1hBUfF...` / `1IaS5h...` | `assets/teaching/` |

- Download via `https://drive.google.com/uc?export=download&id=<id>`. **Fallback:** if a Drive file is permission-restricted and cannot be fetched, link to the existing Drive URL and flag for the user to supply the file.
- **Keep external (not localized):** Journal DOI (SAGE), Replication Data (Dropbox), coauthor page (Fowler), Google Scholar.

---

## 7. Deploy

- Git repo at the project root; **only site files are tracked**. `.gitignore` excludes `docs/`, `_audit/`, `.superpowers/` so planning artifacts never ship to the public site.
- Repo name `KisooKim.github.io`, pushed to GitHub under user `KisooKim`. GitHub Pages auto-serves the default branch root for `<user>.github.io` repos.
- Live URL: `https://kisookim.github.io`. Push = deploy; no build step.

---

## 8. Extras

- **Favicon:** simple monogram (initials or a small gold mark), SVG.
- **SEO/meta:** `<title>`, meta description, `meta name=author`, Open Graph tags; optional JSON-LD `Person` schema for academic name searches.
- **Accessibility:** semantic HTML (`<header>/<main>/<section>/<footer>`, real headings), alt text on the photo, contrast verified (gold never used as text).

---

## 9. Out of Scope (YAGNI)

Blog/news, talks page, multi-page structure, CMS, custom domain, analytics, dark mode, contact form, comments. The site stays a single static page.

---

## 10. Open Items (resolve during implementation)

1. **Headshot** — extract from the Google Site; if low-res, ask Kisoo for a high-res file.
2. **CV section detail** — pull earlier-education entries from the CV PDF once fetched.
3. **Teaching links** — confirm whether to include the Math Methods syllabus + teaching-evaluation links.
4. **Bio copy** — confirm exact final wording against the current site.
5. Any Drive file that fails to download → fall back to Drive link + flag.

# NoteCreator — Detailed Agent Standards

Referenced by `CLAUDE.md`. Read before writing Typst or generating figures.

## Contents
- [Environment setup](#environment-setup)
- [Book architecture](#book-architecture)
- [Component API](#component-api)
- [Typst pitfalls](#typst-pitfalls-all-of-these-have-actually-bitten-us)
- [Figure generation standards](#figure-generation-standards)
- [Math verification](#math-verification)
- [Content fidelity and copyright](#content-fidelity-and-copyright)
- [Visual QA](#visual-qa)

---

## Environment setup

Typst and the fonts are committed to this repo — do not re-download them per
session. If `typst` is genuinely missing:

```bash
# Native
brew install typst                    # Mac
winget install --id Typst.Typst       # Windows
cargo install --locked typst-cli      # anywhere

# Or prebuilt binary
curl -sL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz -o /tmp/typst.tar.xz
tar -xf /tmp/typst.tar.xz -C /tmp && cp /tmp/typst-*/typst /usr/local/bin/ && chmod +x /usr/local/bin/typst
```

Fonts are never system-installed — always pass `--font-path fonts`.

Python needs `matplotlib`, `numpy`, `pdf2image` (+ `poppler-utils`), `genanki`.

For live iteration while editing: `typst watch --font-path fonts <file>.typ out.pdf`

---

## Book architecture

### Book 1 — `lectureNN_notes.typ` (theory / open-book lab reference)
1. **Recap & Visual Intuition** — geometric "why", 2D→3D reasoning, parameter
   progression tables, one figure per major concept via `#split()`.
2. **Classification Cheat-Sheet** — `#matrix()` recognition table keyed on
   algebraic signature → name/behaviour, plus a multi-column `#qcard()` grid
   for anything with several named cases.
3. **Assessment Traps & Lab Reference** — `#quizalert` (conceptual/dimension
   traps), `#assignalert` (rubric + real deadlines), `#mapletip` (software
   syntax via `#code("...")`).

Book 1 stays clean — no homework, no answer keys. It's what's open during a lab.

### Book 2 — `lectureNN_practice.typ` (practice / homework)
1. **Fully Worked Problems** — 2–4, complete algebra, every intermediate step,
   explicit endpoint verification.
2. **Master Problem / Deep-Dive** — one multi-part synthesis problem (full
   trace analysis, multi-variable setup).
3. **Active-Recall Worksheet** — 2–4 `#question(n)` with `#worklines(n)`.
4. **Detached Answer Key** — `#pagebreak()` then all `#answer(n)` blocks, so
   pages 1..n-1 print as a clean practice copy.

### Orientation

```typst
#show: doc.with(title: "...", subtitle: "...", landscape: true, paper-size: "us-letter")
```

Landscape is the default. In landscape, `#qcard()` grids should use 3 columns
rather than 2, and `#worklines()` get noticeably wider — check both visually
after switching orientation, don't assume the reflow is right.

---

## Component API

Full signatures: read `template.typ` directly. Summary:

| Component | Color | Purpose |
|---|---|---|
| `#definition[...]` | teal | definitions, core formulas |
| `#keytip[...]` | amber | recall shortcuts, mnemonics |
| `#example(title: [...])[...]` | lilac | worked problems |
| `#quizalert(title: "...")[...]` | coral | exam/iClicker traps |
| `#assignalert(title: "...")[...]` | indigo | assignment/rubric/deadline |
| `#mapletip(title: "...")[...]` | emerald | lab software tips |
| `#question(n)[...]` / `#worklines(n)` | — | worksheet |
| `#answer(n)[...]` | — | answer key |
| `#matrix(headers, ..rows)` | — | recognition table |
| `#qcard(name, formula, img, blurb)` | — | compact concept card |
| `#fig(path, caption: [...], w: ...)` | — | framed figure |
| `#split(left, right)` | — | two-column row |
| `#code("...")` | — | verbatim code |
| `#hl[...]` / `#hl(color: coral)[...]` | — | inline highlighter |
| `#refs([...], [...])` | — | reference chips |

Extend `template.typ` for genuinely new components; never inline one-off
styling into a lecture file, or the books drift apart visually over time.

---

## Typst pitfalls (all of these have actually bitten us)

**1. `angle.l` / `angle.r` do not exist.**
Error: `unknown symbol modifier`. Use literal Unicode `⟨` `⟩`:
`$⟨3, 4, 1⟩$` ✅ — `$angle.l 3,4,1 angle.r$` ❌

**2. Multi-letter math identifiers are parsed as variables.**
Error: `unknown variable: xy`. Writing `$xy$-plane` fails because Typst looks
for a variable named `xy`. Put a space between the letters:
`$x y$-plane` ✅ — `$xy$-plane` ❌
Same for `$yz$`, `$xz$`, and any multi-letter run in math mode.

**3. Backslash-space is not a math linebreak.**
LaTeX habit. `$⟨a,\ b⟩$` throws. Just use a normal space, or split into
separate `$...$` blocks.

**4. Smart-dash substitution silently corrupts code.**
Typst converts `-` to a typographic minus (−) in normal text. Code copied out
of the PDF into Maple/Python then fails with a confusing syntax error.
Always use `#code("...")` (which wraps `raw(..., block: true)` internally),
and pass a **plain string with real newlines** — never a content block with
`#linebreak()` and `\*` escapes.

```typst
#code("with(plots):
spacecurve([-1+3*t, -4+4*t, -4+t], t=0..1, thickness=3);")   ✅
```

**5. Hard `#pagebreak()` strands near-empty pages.**
If the block after the break doesn't fill a page, you get a page with three
lines on it. Prefer natural flow; use `#pagebreak(weak: true)` when you need a
break; reserve hard `#pagebreak()` for exactly one place — before the answer
key, where the separation is the point.

**6. Boxes split mid-sentence across page boundaries.**
All `template.typ` callouts set `breakable: false` so the whole box moves to
the next page instead. Keep it when extending them.

**7. `memory`/asset paths are relative to the `.typ` file**, not the CWD.
`#image("figs/x.png")` resolves from the document's directory.

---

## Figure generation standards

Shared palette — use these exact values so every figure matches the documents:

```python
INK="#2b2d42"; TEAL="#0f8b8d"; AMBER="#e0a458"
CORAL="#ef6461"; LILAC="#8e7dbe"; GRID="#c9c9c9"
```

Standard 3D styling: hide panes and grid, label axes, transparent background.

```python
def style_3d(ax, elev=20, azim=-60):
    ax.set_facecolor("none")
    for p in (ax.xaxis.pane, ax.yaxis.pane, ax.zaxis.pane): p.fill = False
    ax.grid(False)
    ax.set_xlabel("x"); ax.set_ylabel("y"); ax.set_zlabel("z")
    ax.view_init(elev=elev, azim=azim)

fig.savefig(name, dpi=170, bbox_inches="tight", transparent=True)
```

Surfaces: `alpha≈0.75–0.85`, `edgecolor=INK`, `linewidth≈0.15`,
`rstride=2, cstride=2` for a light wireframe over a solid fill.

**Aspect ratio is a real failure mode.** A mathematically-correct cone can
render as a flat disc if the axis scales differ wildly. Use
`ax.set_box_aspect((x, y, z))` and choose `elev`/`azim` so the defining
feature is visible. Always view the PNG before embedding it.

Annotate meaningfully where it helps: mark and label a vertex, a saddle point,
or a constraining plane (e.g. a translucent `plot_surface` showing that a line
with direction number `b = 0` is trapped in the plane `y = y₀`).

---

## Math verification

Before a worked problem goes in the book, verify it:

- **Segment/parameterization:** confirm `t=0` gives `P₀` and `t=1` gives `P₁`,
  and show that check in the text.
- **Completing the square:** confirm the constants actually cancel/combine to
  the value you claim. Re-add them explicitly.
- **Classification:** re-derive the surface name from the standard form you
  produced, not from the original messy equation.
- **Traces:** substitute the slice value back into the original equation and
  confirm the curve type.

If a computation is long enough that a slip is plausible, verify it in Python
rather than by eye. The whole value of the artifact is that the student trusts
it enough to study from without re-checking.

---

## Content fidelity and copyright

- **Do not reproduce textbook problem statements verbatim.** Write original
  problems in the same style and topic, and cite the assigned ranges
  (e.g. "Stewart 9e §12.5 #23–39") as pointers so the student can find them.
- Cross-reference section numbers and **match the source's notation
  conventions** (if the lecture writes `⟨a,b,c⟩`, don't switch to `ai+bj+ck`).
- External references (Paul's Online Notes, Prof. Leonard, Khan Academy) go in
  `#refs()` chips at the end of a section — links/pointers, not copied content.

---

## Visual QA

After rasterizing, check every page for:

| Symptom | Cause | Fix |
|---|---|---|
| Page >40% empty | hard `#pagebreak()` | remove it, or `weak: true` |
| Box split across pages | missing `breakable: false` | add it |
| Caption touching next paragraph | no spacing after `#fig()` | `#v(7pt)` after |
| Figure looks flat/squashed | bad box aspect | `set_box_aspect`, new `view_init` |
| Table runs past margin | too many columns for orientation | drop a column or go landscape |
| Code has `−` instead of `-` | content block instead of `#code("...")` | convert to raw string |
| Cramped answer key | insufficient block spacing | increase `above`/`below` in `#answer` |

Dense is good; cramped is not. It is fine for a page to end with visible
whitespace — the goal is "dense but never overwhelming," not "zero whitespace."

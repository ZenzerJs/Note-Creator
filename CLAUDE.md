# NoteCreator — Agent Operating Manual

This file is loaded automatically at the start of every Claude Code session in
this repo. The user does not need to paste anything. When they say any of:

- "new lecture" / "process these" / "do lecture 3"
- "here are my notes" (with images or PDFs in `raw_notes/`)
- or simply drop files into `raw_notes/` and say go

…run the **Dual-Book Pipeline** below, end to end, without asking for
permission to start. Ask questions only where this file explicitly says to.

Detailed standards live in `.agents/rules.md`. Read it before writing any
Typst. Read `template.typ` before using any component.

---

## The one-line contract

**Input:** raw handwritten lecture material in `raw_notes/`.
**Output, every single time, no exceptions:**

1. `created_notes/<Course>_Lecture<NN>_Notes.pdf` — Book 1 (theory/lab reference)
2. `created_notes/<Course>_Lecture<NN>_Practice.pdf` — Book 2 (worked problems + worksheet + key)
3. `created_notes/<Course>_Lecture<NN>.apkg` — Anki deck
4. Page preview PNGs, visually inspected by you before you hand anything over

If you cannot produce all four, say so explicitly and say why. Never hand over
a PDF you have not looked at.

---

## Pipeline

### Step 0 — Orient yourself (do this first, every session)

```bash
ls raw_notes/ Material/ Calendar/ created_notes/
```

Determine: which lecture number is this, what course, what's already been
built. If `Material/` has a syllabus or `PRACTICE_PROBLEMS.md`, read it —
it drives textbook cross-referencing and the `#assignalert` dates. If
`Calendar/` has an `.ics`, parse it for genuinely upcoming deadlines.

**Never invent a date, room number, instructor name, or assignment
deadline.** If `Material/`and `Calendar/` are empty, write the alert cards
without specific dates rather than fabricating them.

### Step 1 — Read the handwriting directly. Do not pre-OCR.

Read the images/PDFs with vision. Do **not** route them through
pix2tex/LaTeX-OCR or any equation-OCR tool first. Those are trained on
typeset equations, not handwriting, and they strip the surrounding context
(section heading, adjacent equations, the shape of the derivation) that is
exactly what disambiguates an ambiguous glyph. Direct reading with full
context beats OCR-then-interpret.

**Ambiguity protocol — this is a hard rule.** If a symbol, coefficient, or
step is genuinely unreadable and context does not resolve it:
STOP and ask the user about that specific item. Never silently guess a sign,
exponent, or coefficient. A confidently wrong formula in a study guide is far
worse than a question. Everything else in the pipeline continues; just flag
the one item.

### Step 2 — Complete what the source cuts off

Lecture notes are usually mid-derivation somewhere. Faithfully finish:
intermediate algebra, parameter-progression tables, endpoint verification.
Carry over **every numeric example from the source exactly as given** — do not
paraphrase a specific worked example into a generic "type" of example, and do
not swap the numbers.

### Step 3 — Generate figures BEFORE writing any Typst

Every 3D surface, space curve, trace diagram, contour plot, or vector field is
a standalone matplotlib script in `figs/`, saved as a transparent high-DPI PNG.
Typst's native drawing is not used for math graphics.

Follow the palette and `style_3d()` conventions in `.agents/rules.md` so new
figures match existing ones.

**Then look at every figure you generate** before embedding it. Check
specifically that 3D surfaces are not squashed flat by a bad aspect ratio —
set `ax.set_box_aspect(...)` and pick a viewing angle where the defining
feature (the saddle, the waist, the two lobes) is actually visible. A
technically-correct but visually illegible figure is a bug.

### Step 4 — Build Book 1 and Book 2

Architecture, orientation options, and the full component API: see
`.agents/rules.md` and `template.typ`.

**Orientation:** default to `landscape: true`. Only use portrait if the user
asks, or if they say it's for printing/binder.

### Step 5 — Compile → rasterize → LOOK → fix. Loop until clean.

This step is not optional and is not a formality. It is where most of the
real work happens.

```bash
typst compile --font-path fonts lectureNN_notes.typ created_notes/<...>_Notes.pdf
typst compile --font-path fonts lectureNN_practice.typ created_notes/<...>_Practice.pdf
```

Then rasterize and **actually view every page**:

```python
from pdf2image import convert_from_path
for i, p in enumerate(convert_from_path(pdf_path, dpi=105)):
    p.save(f"figs/preview_{i+1}.png")
```

Inspect for the failure modes listed in `.agents/rules.md` §Visual QA —
near-empty pages, boxes splitting across page breaks, captions colliding with
following text, flattened figures, tables overflowing the margin. Fix and
recompile. **Expect 2–4 iterations.** Do not stop at "it compiled."

### Step 6 — Anki export

```bash
python scripts/export_anki.py lectureNN_practice.typ created_notes/<Course>_LectureNN.apkg
```

Every `#question(n)` maps to its `#answer(n)`. Math in card fields uses
`\( ... \)` delimiters.

### Step 7 — Deliver

Present both PDFs and the `.apkg`. In your message: state what was built, flag
any item you had to ask about or could not resolve, and note anything you
deliberately left out. Do not narrate the pipeline steps back to the user.

---

## Definition of done

Refuse to call the job finished until all of these are true:

- [ ] Both PDFs compile with zero errors
- [ ] You have visually inspected every page of both PDFs
- [ ] No page is more than ~40% empty (except the answer-key page)
- [ ] No callout box splits across a page boundary
- [ ] Every figure is legible and correctly proportioned
- [ ] Every worked problem's arithmetic has been verified (see
      `.agents/rules.md` §Math verification)
- [ ] Worksheet questions have writing space; answer key is on its own page
- [ ] `.apkg` generated and question/answer count matches the worksheet
- [ ] No fabricated dates, rooms, or textbook problem text

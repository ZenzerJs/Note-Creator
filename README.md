# MA201 Note Creator

> Autonomous Multivariable Calculus study guide & active-recall pipeline in Typst, designed for landscape viewing on an 11" iPad Pro in **Noteful**.

---

## Architecture: Dual-Book System

Every lecture generates two separate horizontal (`11" × 8.5"`) notebooks:

1. **Book 1: Notes & Lab Guide (`created_notes/MA201_LectureXX_Notes.pdf`)**
   - **Recap & Visual Intuition**: 2D-to-3D reasoning, cylinders, rulings, and space curves.
   - **Classification Cheat-Sheet**: Recognition matrix table & 3D quadric cards in a 3-column grid.
   - **Assessment Traps & Maple Lab Reference**: iClicker traps, rubric checklists, and copy-pasteable Maple code for Thursday open-book labs.
2. **Book 2: Practice & Homework Worksheet (`created_notes/MA201_LectureXX_Practice.pdf`)**
   - **Fully Worked Exam Problems**: Multi-step derivations, complete algebra, and 3D diagrams.
   - **Active-Recall Worksheet**: Questions with wide ruled writing lines (`#worklines()`) calibrated for Apple Pencil in Noteful.
   - **Detached Answer Key**: Step-by-step solutions on final page.
3. **Flashcard Deck (`created_notes/MA201_LectureXX.apkg`)**
   - Spaced-repetition Anki deck auto-extracted from worksheet `#question()` and `#answer()` pairs.

---

## Directory Layout

```text
├── .agents/
│   ├── rules.md                 # Antigravity master prompt, syllabus deadlines & formatting standards
│   └── mcp_config.json          # MCP tool definitions (typst-mcp)
├── Calendar/                    # Laurier Fall 2026 course schedule (.ics)
├── created_notes/               # Final output deliverables (PDFs & Anki .apkg)
│   ├── MA201_Lecture01_Notes.pdf
│   ├── MA201_Lecture01_Practice.pdf
│   └── MA201_Lecture01.apkg
├── figs/                        # 3D diagram assets & matplotlib generators (gen_figs.py)
├── fonts/                       # Atkinson Hyperlegible, Caveat, Patrick Hand (.ttf)
├── Material/                    # Stewart 9e textbook, syllabus outline, PRACTICE_PROBLEMS.md
├── raw_notes/                   # Drop incoming handwritten notes / lecture scans here
├── scripts/
│   └── export_anki.py           # Extracts worksheet Q&A into importable Anki decks
├── docker-compose.yml           # Zero-install Typst compiler & MCP container
├── lecture01_notes.typ          # Lecture 01 Notes Book source
├── lecture01_practice.typ       # Lecture 01 Practice Book source
├── template.typ                 # Reusable landscape layout components
└── README.md
```

---

## Quick Start & Compilation

### Option A: Via Docker (Zero Local Installs)
```bash
# Compile Notes Book:
docker compose run --rm typst compile --font-path fonts lecture01_notes.typ created_notes/MA201_Lecture01_Notes.pdf

# Compile Practice Book:
docker compose run --rm typst compile --font-path fonts lecture01_practice.typ created_notes/MA201_Lecture01_Practice.pdf

# Export Anki Flashcard Deck:
python scripts/export_anki.py lecture01_practice.typ created_notes/MA201_Lecture01.apkg
```

### Option B: Local Typst CLI
```powershell
# Install Typst on Windows:
winget install --id Typst.Typst

# Compile:
typst compile --font-path fonts lecture01_notes.typ created_notes/MA201_Lecture01_Notes.pdf
typst compile --font-path fonts lecture01_practice.typ created_notes/MA201_Lecture01_Practice.pdf
```

---

## Standard Prompt for Claude / AI Agents

Copy and paste this prompt when giving an AI agent (Claude Code or Antigravity) new handwritten lecture notes or photos:

```markdown
You are an expert Multivariable Calculus TA and note designer for MA201 (Stewart 9th Edition, Laurier Fall 2026).

I have uploaded new raw lecture material into `raw_notes/` (e.g. `raw_notes/MA201_LectureXX.pdf` or photos). 

Process this material and build our standard Dual-Book horizontal landscape package according to `template.typ` and `.agents/rules.md`:

### 1. Ingestion & Analysis
- Read the raw handwritten scans directly using vision. Do not guess illegible formulas; complete any cut-off derivations faithfully.
- Cross-reference the relevant section in `Material/Calculus Early Transcendentals 9th Edition...` and assigned problems in `Material/PRACTICE_PROBLEMS.md`.

### 2. 3D Diagram Generation
- For any 3D surface, space curve, or trace, generate standalone Python/matplotlib scripts in `figs/` using `style_3d()` with transparent background.
- Save diagrams as PNGs in `figs/` and embed them into Typst via `#fig("figs/name.png", caption: [...])` or `#qcard(...)`.

### 3. Book 1: Lecture Notes & Lab Guide (`lectureXX_notes.typ`)
- Format: Horizontal landscape (`doc.with(landscape: true)`).
- Section 1: Recap & Visual Intuition (2D-to-3D reasoning, missing variable rules, parameter tables).
- Section 2: Classification Cheat-Sheet (`#matrix()` recognition table + 3-column grid of `#qcard()`).
- Section 3: Assessment Traps & Lab Tips (`#quizalert` for iClicker/dimension traps, `#assignalert` for syllabus deadlines, `#mapletip` with copy-pasteable Maple code wrapped in `#code("...")`).

### 4. Book 2: Practice & Homework Worksheet (`lectureXX_practice.typ`)
- Section 1: Fully Worked Problems (2-4 step-by-step Stewart-style problems with complete algebra and verification).
- Section 2: Master Problem / Trace Analysis.
- Section 3: Active-Recall Worksheet (2-4 `#question(n)` blocks with wide `#worklines(n)` for Apple Pencil handwriting in Noteful).
- Section 4: Detached Answer Key (final page with complete `#answer(n)` solutions).

### 5. Build & Export Deliverables
- Compile both books into `created_notes/`:
  - `created_notes/MA201_LectureXX_Notes.pdf`
  - `created_notes/MA201_LectureXX_Practice.pdf`
- Export flashcards: run `python scripts/export_anki.py lectureXX_practice.typ created_notes/MA201_LectureXX.apkg`.
- Export preview PNGs (`figs/notes_page_{p}.png`, `figs/practice_page_{p}.png`) and render an in-chat visual carousel artifact.

Typst Rules to Follow:
- Use literal Unicode `⟨ ⟩` for vectors (not `angle.l` / `angle.r`).
- Keep `breakable: false` on callout boxes.
- No hard `pagebreak()`; use `pagebreak(weak: true)` or natural flow to avoid empty whitespace.
```

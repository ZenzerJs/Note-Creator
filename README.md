# Note Creator

> Autonomous academic study guide & active-recall notebook pipeline in [Typst](https://typst.app/), designed for horizontal landscape viewing on an 11" iPad Pro in **Noteful** or **Goodnotes**.

Transform messy handwritten lecture notes, whiteboard photos, or lecture slides into publication-grade, dense, card-based digital study guides with zero configuration.

---

## Architecture: Dual-Book System

Every lecture generates two focused horizontal (`11" × 8.5"`) notebooks:

1. **Book 1: Notes & Lab Guide (`created_notes/<Course>_LectureXX_Notes.pdf`)**
   - **Recap & Visual Intuition**: 2D-to-3D geometric reasoning, spatial intuition, and parameter progressions.
   - **Classification Cheat-Sheet**: Recognition matrix tables & surface/concept cards in a balanced 3-column grid.
   - **Assessment Traps & Lab Reference**: Exam/quiz traps, rubric checklists, and copy-pasteable software code (Maple, Python, MATLAB, R).
2. **Book 2: Practice & Homework Worksheet (`created_notes/<Course>_LectureXX_Practice.pdf`)**
   - **Fully Worked Exam Problems**: Multi-step derivations, complete algebra, and clean diagrams.
   - **Active-Recall Worksheet**: Practice questions with wide ruled writing lines (`#worklines()`) calibrated for Apple Pencil handwriting.
   - **Detached Answer Key**: Step-by-step verified solutions on the final page.
3. **Flashcard Deck (`created_notes/<Course>_LectureXX.apkg`)**
   - Spaced-repetition Anki deck automatically generated from worksheet `#question()` and `#answer()` pairs.

---

## Quick Start (Clone & Run)

### 1. Requirements
- Docker & Docker Compose (for zero-install compilation), OR
- Local [Typst CLI](https://github.com/typst/typst) (`winget install --id Typst.Typst` / `brew install typst`).

### 2. Add Your Material
- **`raw_notes/`**: Drop your handwritten notes, phone photos, or lecture PDFs here.
- **`Material/` (Optional, Recommended for Best Results)**:
  - Course syllabus / outline PDF (enables the agent to detect marking schemes, exam dates, and software requirements).
  - Textbook PDF or edition name (enables the agent to cite exact theorem names and model assigned problems).
  - Problem set lists or homework files.
- **`Calendar/` (Optional)**:
  - Export your personal `.ics` calendar here so the agent automatically aligns alerts with your upcoming deadlines (ignored by Git for privacy).

### 3. Compile Deliverables
```bash
# Via Docker (Zero Installs):
docker compose run --rm typst compile --font-path fonts lecture01_notes.typ created_notes/Lecture01_Notes.pdf
docker compose run --rm typst compile --font-path fonts lecture01_practice.typ created_notes/Lecture01_Practice.pdf

# Export Anki Deck:
python scripts/export_anki.py lecture01_practice.typ created_notes/Lecture01.apkg
```

---

## Directory Structure

```text
├── .agents/
│   ├── rules.md                 # Universal agent instructions, standards & workflow
│   └── mcp_config.json          # MCP tool definitions (typst-mcp)
├── Calendar/                    # Optional student calendar exports (.ics, gitignored)
├── created_notes/               # Compiled deliverables (PDFs & Anki .apkg)
├── figs/                        # 3D diagram assets & matplotlib generators
├── fonts/                       # Atkinson Hyperlegible, Caveat, Patrick Hand TTF files
├── Material/                    # Optional syllabus, textbook, and problem lists (gitignored)
├── raw_notes/                   # Incoming raw lecture scans / photos (gitignored)
├── scripts/
│   └── export_anki.py           # Auto-generates Anki decks from Typst worksheets
├── docker-compose.yml           # Pre-configured Typst compiler container
├── template.typ                 # Reusable landscape layout components & card designs
└── README.md
```

---

## Master Prompt for AI Agents (Claude / Antigravity)

When you have new notes to process, copy and paste this prompt into Claude or Antigravity:

```markdown
You are an expert academic TA and instructional designer.

I have uploaded new raw lecture material into `raw_notes/` (e.g. photos of handwritten pages, whiteboard captures, or scans).

Process this lecture and generate our standard Dual-Book horizontal landscape package according to `template.typ` and `.agents/rules.md`:

### 1. Ingestion & Context Analysis
- Read the raw handwritten scans directly using vision. Do not guess illegible formulas; complete any cut-off derivations faithfully.
- Check `Material/` for any course syllabus, textbook name/PDF, or problem lists. Cross-reference textbook sections, official notation, and assigned homework problems if available.
- Check `Calendar/` for any upcoming test/assignment dates to populate real deadlines into alert boxes.

### 2. Diagram & Visualization Layer
- For any 3D surface, space curve, geometric setup, or data plot, generate standalone Python/matplotlib scripts in `figs/` using `style_3d()` with transparent background.
- Save diagrams as PNGs in `figs/` and embed them into Typst via `#fig("figs/name.png", caption: [...])` or `#qcard(...)`.

### 3. Book 1: Notes & Lab Reference (`lectureXX_notes.typ`)
- Format: Horizontal landscape (`doc.with(landscape: true)`).
- Section 1: Recap & Visual Intuition (spatial reasoning, geometric definitions, parameter tables).
- Section 2: Classification Cheat-Sheet (`#matrix()` recognition table + 3-column grid of `#qcard()`).
- Section 3: Assessment Traps & Lab Tips (`#quizalert` for conceptual/exam traps, `#assignalert` for deadlines/rubrics, `#mapletip` or relevant software code wrapped in `#code("...")`).

### 4. Book 2: Practice & Homework Worksheet (`lectureXX_practice.typ`)
- Section 1: Fully Worked Problems (2-4 step-by-step problems with complete algebra, intermediate steps, and verification).
- Section 2: Master Problem / Deep-Dive Analysis.
- Section 3: Active-Recall Worksheet (2-4 `#question(n)` blocks with wide `#worklines(n)` for Apple Pencil handwriting in Noteful/Goodnotes).
- Section 4: Detached Answer Key (final page with complete `#answer(n)` solutions).

### 5. Build & Delivery
- Compile both books into `created_notes/`:
  - `created_notes/<Course>_LectureXX_Notes.pdf`
  - `created_notes/<Course>_LectureXX_Practice.pdf`
- Export flashcards: `python scripts/export_anki.py lectureXX_practice.typ created_notes/<Course>_LectureXX.apkg`.
- Export preview PNGs (`figs/notes_page_{p}.png`, `figs/practice_page_{p}.png`) and render an interactive carousel artifact in chat.

Typst Rules:
- Unicode `⟨ ⟩` for vectors (not `angle.l` / `angle.r`).
- Keep `breakable: false` on callout boxes.
- No hard `pagebreak()`; use `pagebreak(weak: true)` or natural flow to eliminate trailing whitespace.
```

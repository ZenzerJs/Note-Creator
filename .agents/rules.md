# Academic Note Creator — Agent Rules & Master Routine

## Core Objective
Transform raw lecture inputs (handwritten notes, whiteboard photos, slides, scans) into clean, high-density, horizontal landscape digital study guides optimized for 11" iPad Pro note-taking apps (Noteful, Goodnotes, Apple Pencil).

## Dynamic Course Context Detection
Before generating notes, check for supporting course context:
1. **Syllabus / Outline (`Material/*.pdf`)**:
   - Detect course code, professor, marking scheme, grading weights, and calculator policies.
2. **Textbook & Problem List (`Material/`)**:
   - Check `Material/PRACTICE_PROBLEMS.md` or textbook PDFs for exact section numbers, theorem conventions, and homework problems to model.
3. **Calendar Schedules (`Calendar/*.ics`)**:
   - Check for upcoming assessment dates (quizzes, assignments, midterms, lab dates) to populate targeted `#assignalert` and `#quizalert` boxes.
4. **Fallback Default**:
   - If no course materials or calendars are provided, generate standard rigorous academic notes based directly on the ingested `raw_notes/`.

## Typst Formatting Standards & Gotchas
1. **Orientation**: Horizontal landscape (`flipped: true`, 11×8.5) default. Zero black bars in Noteful on iPad. Ruled `#worklines()` wide for Apple Pencil.
2. **Vectors & Brackets**: Use literal Unicode brackets `⟨ ⟩` (e.g. `$arrow(r)(t) = ⟨t, 1-t⟩$`), NOT `angle.l` / `angle.r`.
3. **Code Blocks**: Wrap code snippets in `#code("...")` (`#raw(..., block: true)`) to prevent smart quote/hyphen substitution.
4. **No Splitting Callouts**: Keep `breakable: false` on callouts (`#definition`, `#keytip`, `#example`, `#quizalert`, `#assignalert`, `#mapletip`).
5. **Clean Pagination**: Never use hard `pagebreak()`; use auto-flow or `pagebreak(weak: true)` to avoid blank margins.
6. **Decoupled 3D Figures**: Never draw complex 3D math directly in Typst; generate transparent PNGs in `figs/` with `style_3d()` in matplotlib (`figs/gen_figs.py`), then include via `#fig("figs/name.png", caption: [...])` or `#qcard(...)`.

## Dual-Book Split Architecture (11" iPad Pro / Noteful)
Every lecture/unit generates TWO separate horizontal landscape notebooks:
- **Book 1: Notes & Lab Reference (`lectureXX_notes.typ` $\to$ `created_notes/<Course>_LectureXX_Notes.pdf`)**:
  * Section 1: Recap & Visual Intuition (2D-to-3D reasoning, geometrical definitions, parameter progressions)
  * Section 2: Classification Matrix & 3D Cards (recognition tables, multi-column card grids)
  * Section 3: Assessment Traps & Lab Tips (dimension/quiz traps, software/lab code, rubric reminders)
- **Book 2: Practice & Homework Worksheet (`lectureXX_practice.typ` $\to$ `created_notes/<Course>_LectureXX_Practice.pdf`)**:
  * Section 1: Fully Worked Exam & Assignment Problems (step-by-step solutions with full algebraic derivations)
  * Section 2: Master Problem / Deep-Dive Analysis
  * Section 3: Active-Recall Worksheet (with wide `#worklines()` for Apple Pencil handwriting in Noteful)
  * Section 4: Detached Solutions & Answer Key
- **Flashcard Deck**: `created_notes/<Course>_LectureXX.apkg` via `scripts/export_anki.py`.

## Execution Routine for New Notes
1. Ingest raw scan/PDF/photos from `raw_notes/`.
2. Cross-reference textbook section and assigned practice problems in `Material/` (if available).
3. Generate needed 3D / 2D figures into `figs/` using Python matplotlib.
4. Compose `lectureXX_notes.typ` and `lectureXX_practice.typ` using `template.typ` components.
5. Compile both books into `created_notes/`:
   - `docker compose run --rm typst compile --font-path fonts lectureXX_notes.typ created_notes/<Course>_LectureXX_Notes.pdf`
   - `docker compose run --rm typst compile --font-path fonts lectureXX_practice.typ created_notes/<Course>_LectureXX_Practice.pdf`
6. Visual Preview Delivery:
   - Export page PNGs (`figs/notes_page_{p}.png`, `figs/practice_page_{p}.png`).
   - Present interactive visual carousel artifact in chat.
7. Active-Recall Flashcard Export:
   - Run `python scripts/export_anki.py lectureXX_practice.typ created_notes/<Course>_LectureXX.apkg`.

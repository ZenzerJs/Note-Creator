# MA201 Note Creator

Multivariable Calculus (Stewart 9th Ed.) study guide generator for 11" iPad Pro in Noteful.

## Directory Structure
- `created_notes/` — Final output PDFs and Anki flashcard decks.
- `figs/` — 3D PNG diagrams + matplotlib generator scripts.
- `fonts/` — Atkinson Hyperlegible, Caveat, Patrick Hand TTF files.
- `Material/` — Course syllabus, textbook, and assigned practice problems index.
- `raw_notes/` — Drop incoming lecture scans/photos here.
- `scripts/` — Utility scripts (e.g. `export_anki.py`).
- `template.typ` — Shared components, colors, and landscape page setup.

## Workflow

1. **Drop raw notes**: Save into `raw_notes/` (e.g. `raw_notes/MA201_Lecture02.pdf`).
2. **Compile Book 1 (Lecture Notes & Lab Guide)**:
   ```bash
   docker compose run --rm typst compile --font-path fonts lecture01_notes.typ created_notes/MA201_Lecture01_Notes.pdf
   ```
3. **Compile Book 2 (Practice & Homework Worksheet)**:
   ```bash
   docker compose run --rm typst compile --font-path fonts lecture01_practice.typ created_notes/MA201_Lecture01_Practice.pdf
   ```
4. **Export Anki flashcards**:
   ```bash
   python scripts/export_anki.py lecture01_practice.typ created_notes/MA201_Lecture01.apkg
   ```

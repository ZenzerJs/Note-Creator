# MA201 & Term Master Rules

## Course Scope & Staff
- **Course**: MA201A - Multivariable Calculus (Laurier Fall 2026, Waterloo Campus, In-Person)
- **Instructor**: Dr. Anne-Marie Allison (LH3050, aallison@wlu.ca)
- **Lab Coordinator**: Katie McGarry (LH3074, cmcgarry@wlu.ca)
- **Textbook**: Stewart, Clegg, Watson, *Calculus (Early Transcendentals)*, 9th Edition.
- **Reference Problem Index**: `Material/PRACTICE_PROBLEMS.md`

## Evaluation Breakdown
- **iClickers (5%)**: Starts Monday Sept 21. Lowest 10% dropped. Covers pre-lecture prep & active learning.
- **In-Class Assignments (10%)**: 5 handwritten assignments (Wednesdays: Sep 23, Oct 7, Oct 28, Nov 11, Nov 25). Max 4 students/group. Topics mirror next day's lab.
- **Laboratories (25%)**: Bi-weekly Thursdays starting Sept 10 in LH3068. Open-book (text, notes, calculator allowed). Maple work submitted to Gradescope.
- **Term Test 1 (15%)**: Wed Oct 21 (cooperative format: max(individual, 80% ind + 20% group)).
- **Term Test 2 (15%)**: Wed Nov 18 (cooperative format).
- **Final Exam (30%)**: 2.5 hours, Dec 12–23. **Crucial threshold**: $\ge 40\%$ required on final exam to pass course.
- **Calculator**: Non-programmable, non-graphing without diff/int keys only (e.g. Casio FX-300MS Plus).

## Weekly Routine
- **Mon & Wed**:
  - Inbound Transit: 10:00 - 12:05 (Brampton $\to$ WLU)
  - MA201 Lecture: 13:00 - 14:20 (Science Building N1044)
  - MA201 Library Problem Review: 14:20 - 15:10 (Laurier Library)
  - GO Train Home: 15:10 - 16:35 (Kitchener GO 15:38)
- **Thursday (Bi-weekly Lab Day)**:
  - Transit: 08:15 - 09:35 (GO Bus 30)
  - MA201 Calculus Lab: 10:00 - 11:20 (Lazaridis Hall LH3068)
  - Campus Deep Work (Discrete Proofs): 11:30 - 14:15
  - GO Train Home: 14:15 - 15:45 (Kitchener GO 14:41)
- **Friday (C & HW Polish)**:
  - CP264 C Implementation & Lab Submission: 10:30 - 15:00
  - MA201 HW Polish (Block 4): 15:30 - 17:00
- **Weekend**:
  - NeetCode 150 & Portfolio Sprints (Sat)
  - Job Application Batch 7 & Interview Prep (Sun)

## Typst Formatting Standards & Gotchas
1. **Orientation**: Horizontal landscape (`flipped: true`, 11×8.5) default. Zero black bars in Noteful on iPad. Ruled `#worklines()` wide for Apple Pencil.
2. **Vectors**: Use literal Unicode brackets `⟨ ⟩` (e.g. `$arrow(r)(t) = ⟨t, 1-t⟩$`), NOT `angle.l` / `angle.r`.
3. **Maple Code**: Wrap in `#code("...")` (`#raw(..., block: true)`) to prevent smart quote/hyphen substitution.
4. **No Splitting Callouts**: Keep `breakable: false` on callouts (`#definition`, `#keytip`, `#example`, `#quizalert`, `#assignalert`, `#mapletip`).
5. **Clean Pagination**: Never use hard `pagebreak()`; use auto-flow or `pagebreak(weak: true)` to avoid blank margins.
6. **Decoupled 3D Figures**: Never draw complex 3D math directly in Typst; generate transparent PNGs in `figs/` with `style_3d()` in matplotlib (`figs/gen_figs.py`), then include via `#fig("figs/name.png", caption: [...])` or `#qcard(...)`.

7. **Dual-Book Split Architecture (11" iPad Pro / Noteful)**:
   Every lecture generates TWO separate horizontal landscape notebooks:
   - **Book 1: Notes & Lab Reference (`lectureXX_notes.typ` $\to$ `created_notes/MA201_LectureXX_Notes.pdf`)**:
     * Section 1: Recap & Visual Intuition (Cylinders, rulings, 3D parameterization)
     * Section 2: Classification Matrix & 3D Cards (6 Quadric surfaces, trace synthesis)
     * Section 3: Assessment Traps & Maple Lab Tips (Permitted in open-book Thursday labs!)
   - **Book 2: Practice & Homework Worksheet (`lectureXX_practice.typ` $\to$ `created_notes/MA201_LectureXX_Practice.pdf`)**:
     * Section 1: Fully Worked Exam & Assignment Problems (Stewart 9e problem types)
     * Section 2: Trace Analysis Master Problem
     * Section 3: Active-Recall Worksheet (with wide `#worklines()` for Apple Pencil in Noteful)
     * Section 4: Detached Solutions & Answer Key
   - **Flashcard Deck**: `created_notes/MA201_LectureXX.apkg` via `scripts/export_anki.py`.

## Execution Routine for New Lectures
1. Ingest raw scan/PDF from `raw_notes/`.
2. Cross-reference textbook section in Stewart 9th Ed and assigned practice problems in `Material/PRACTICE_PROBLEMS.md`.
3. Generate needed 3D / 2D figures into `figs/` using `figs/gen_figs.py`.
4. Compose `lectureXX_notes.typ` and `lectureXX_practice.typ`.
5. Compile both books into `created_notes/`:
   - `docker compose run --rm typst compile --font-path fonts lectureXX_notes.typ created_notes/MA201_LectureXX_Notes.pdf`
   - `docker compose run --rm typst compile --font-path fonts lectureXX_practice.typ created_notes/MA201_LectureXX_Practice.pdf`
6. Visual Preview Delivery:
   - Export page PNGs (`figs/notes_page_{p}.png`, `figs/practice_page_{p}.png`).
   - Present interactive visual carousel artifact in chat.
7. Active-Recall Flashcard Export:
   - Run `python scripts/export_anki.py lectureXX_practice.typ created_notes/MA201_LectureXX.apkg`.



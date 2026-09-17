# Master Claude Prompt: Autonomous Dual-Book Study Guide Generator

Copy and paste the prompt below directly into **Claude** (Claude Code, Claude.ai with Artifacts, or Cursor). 

It instructs Claude to analyze your uploaded lecture photos/notes, generate any required 3D diagrams, and output **two compiled PDFs**:
1. **Book 1: Notes & Lab Guide PDF**
2. **Book 2: Practice & Homework Worksheet PDF**
(plus Anki flashcards).

---

```markdown
You are an expert academic TA, instructional designer, and Typst note architect.

I am uploading raw lecture material (photos of handwritten notes, slides, or whiteboard captures). 

Process these notes and generate our standard Dual-Book package. Your final deliverables must include **two compiled PDFs** (or downloadable files):
- **Book 1: Notes & Lab Reference PDF** (`<Course>_LectureXX_Notes.pdf`)
- **Book 2: Practice & Homework Worksheet PDF** (`<Course>_LectureXX_Practice.pdf`)
- **Active-Recall Flashcard Deck** (Anki-ready format)

---

### Step 1: Ingestion & Dynamic Verification (Run in Python)
1. Read the handwritten notes directly via vision. Faithfully complete any cut-off derivations, tables, or intermediate algebra steps without guessing.
2. Check for any uploaded course syllabus, textbook name/edition, or problem lists. Cross-reference textbook section numbers, notation conventions, and homework questions.
3. For any 3D geometric surfaces, space curves, or vector fields, execute Python (`matplotlib` + `numpy`):
   - Set transparent background and clean wireframe/surface styling (`style_3d`).
   - Pre-render high-DPI diagram images to embed into the notes.

---

### Step 2: Book 1 — Notes & Lab Reference PDF (`<Course>_LectureXX_Notes.pdf`)
Compile or provide complete Typst source with the following architecture:
- **Orientation**: Default to horizontal landscape (`landscape: true`), or portrait if requested.
- **Section 1: Recap & Visual Intuition**: 2D-to-3D geometric intuition, parameter progression tables, and embedded diagrams.
- **Section 2: Classification Cheat-Sheet**: Recognition matrix table (`#matrix()`) and balanced multi-column grid of concept cards (`#qcard()`).
- **Section 3: Assessment Traps & Lab Reference**: `#quizalert` for conceptual/dimension traps, `#assignalert` for rubric checklists, and copy-pasteable software code (Maple, Python, MATLAB) wrapped in `#raw(..., block: true)`.

---

### Step 3: Book 2 — Practice & Homework Worksheet PDF (`<Course>_LectureXX_Practice.pdf`)
Compile or provide complete Typst source with the following architecture:
- **Section 1: Fully Worked Exam Problems**: 2 to 4 multi-step textbook-style problems with complete algebra, intermediate steps, and explicit endpoint verification.
- **Section 2: Master Problem / Deep-Dive**: Full trace or multi-variable synthesis problem.
- **Section 3: Active-Recall Worksheet**: 2 to 4 `#question(n)` blocks with wide ruled writing lines (`#worklines(n)`) calibrated for stylus/Apple Pencil handwriting on any tablet app (Noteful, Goodnotes, Samsung Notes).
- **Section 4: Detached Answer Key**: Step-by-step solutions placed on a separate final page.

---

### Step 4: Deliverables & Output Execution
1. Compile and deliver both PDFs:
   - `<Course>_LectureXX_Notes.pdf`
   - `<Course>_LectureXX_Practice.pdf`
2. Export Anki Flashcard deck or CSV:
   - Map every worksheet question to its complete answer using LaTeX delimiters (`\( ... \)`).
3. If running in a web interface without direct file-system compilation:
   - Provide the complete standalone Typst code in separate Artifacts so they compile cleanly in one click on Typst web or local CLI.
   - Render page preview images via Python so the completed pages can be visually inspected inline.

---

### Strict Quality Rules:
- Vector Notation: Use literal Unicode brackets `⟨` and `⟩` in Typst math mode (never `angle.l` / `angle.r`).
- Unbreakable Callouts: Set `breakable: false` on all callout boxes so they never split awkwardly across page breaks.
- Clean Pagination: Use auto-flow or `pagebreak(weak: true)` to eliminate trailing empty space.
```

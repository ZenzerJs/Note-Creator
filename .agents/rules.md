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

## Execution Routine for Note Generation
1. Ingest lecture / raw scans from `raw_notes/`.
2. Cross-reference textbook section in Stewart 9th Ed and assigned practice problems in `Material/PRACTICE_PROBLEMS.md`.
3. Generate 3D / 2D figures via `figs/`.
4. Compose `lectureXX/main.typ` using `#definition`, `#keytip`, and `#problem` cards from `template.typ`. Include Stewart practice problem numbers and worked solutions.
5. Compile via `docker compose run --rm typst compile --root . lectureXX/main.typ lectureXX/out.pdf`.

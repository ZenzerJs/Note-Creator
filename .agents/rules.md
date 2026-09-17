# MA201 Agent Rules & Master Routine

## Course Scope
- Textbook: Stewart Calculus (9th Edition), Multivariable Calculus.
- Course: MA201 - Multivariable Calculus (Dr. Allison).
- Labs: Katie McGarry Maple Labs.

## Key Assessment Deadlines
- **In-Class Assignment 1**: Wednesday, Sept 23 in N1044.
- **Maple Lab 1**: Thursday, Sept 24 in LH3068.

## Execution Routine
1. **Raw Notes Ingestion**:
   - Inspect raw scans/PDFs in `raw_notes/`.
   - Transcribe core definitions, theorems, formulas, and worked examples.
2. **Diagrams & Visualizations**:
   - Generate 3D / 2D calculus figures in `figs/` with Python (`matplotlib`, `numpy`).
   - Save figures as PNG/SVG into `figs/` or lecture folder.
3. **Typst Note Composition**:
   - Assemble `lectureXX/main.typ` using `#definition`, `#keytip`, and `#problem` cards from `template.typ`.
   - Use clean KaTeX/Typst math notation for vectors ($\vec(v)$ or $bold(v)$), gradients ($\nabla f$), partials, space curves, quadric surfaces.
4. **Build Output**:
   - Compile: `typst compile --font-path fonts lectureXX/main.typ lectureXX/output.pdf`
   - Or live watch: `typst watch --font-path fonts lectureXX/main.typ lectureXX/output.pdf`

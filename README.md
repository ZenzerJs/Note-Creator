# MA201 Note Creator

Multivariable Calculus (Stewart 9th Ed.) study guide generator in Google Antigravity.

## Workflow

1. **Drop raw scans/notes**:
   Save into `raw_notes/` (e.g. `raw_notes/MA201_Lecture01.pdf`).
2. **Generate figures**:
   `python figs/gen_lecture01.py`
3. **Compile study guide**:
   `typst compile --font-path fonts lecture01/main.typ lecture01/MA201_Lecture01_StudyGuide.pdf`
4. **Live preview**:
   `typst watch --font-path fonts lecture01/main.typ lecture01/MA201_Lecture01_StudyGuide.pdf`

## Install Typst

```powershell
winget install --id Typst.Typst
```

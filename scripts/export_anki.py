"""Extract #question() and #answer() blocks from a Typst file and generate an Anki .apkg deck."""

import re
import sys
from pathlib import Path
import genanki

# Define Anki Model
CALC_MODEL = genanki.Model(
    1607392319,
    "MA201 Calculus Active Recall",
    fields=[
        {"name": "QuestionNumber"},
        {"name": "Question"},
        {"name": "Answer"},
    ],
    templates=[
        {
            "name": "Card 1",
            "qfmt": '<div style="font-family: Arial; font-size: 14px; color: #3d5a99; font-weight: bold;">MA201 — {{QuestionNumber}}</div><hr><div style="font-size: 18px;">{{Question}}</div>',
            "afmt": '{{FrontSide}}<hr id="answer"><div style="font-size: 16px; color: #15803d; font-weight: bold;">Solution:</div><div style="font-size: 17px;">{{Answer}}</div>',
        },
    ],
    css="""
    .card {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        text-align: left;
        color: #2b2d42;
        background-color: #fffdf8;
        padding: 16px;
    }
    """,
)

def parse_typst_qa(typ_path: Path):
    text = typ_path.read_text(encoding="utf-8")

    # Match #question(n)[body]
    # Handle optional title or plain number
    q_matches = re.findall(r'#question\s*\(\s*(\d+)\s*\)\s*\[(.*?)\]\s*(?=#question|#pagebreak|#answer|$)', text, re.DOTALL)
    # Match #answer(n)[body]
    a_matches = re.findall(r'#answer\s*\(\s*(\d+)\s*\)\s*\[(.*?)\]\s*(?=#answer|#question|$)', text, re.DOTALL)

    q_dict = {n.strip(): body.strip() for n, body in q_matches}
    a_dict = {n.strip(): body.strip() for n, body in a_matches}

    cards = []
    for n, q_body in q_dict.items():
        a_body = a_dict.get(n, "No answer provided.")
        # Basic cleanup of typst syntax to plain html
        q_html = q_body.replace("$", "\\(").replace("\n", "<br>")
        a_html = a_body.replace("$", "\\(").replace("\n", "<br>")
        cards.append((f"Question {n}", q_html, a_html))

    return cards

def build_deck(typ_path: Path, out_apkg: Path):
    cards = parse_typst_qa(typ_path)
    if not cards:
        print(f"No #question/#answer pairs found in {typ_path}")
        return

    deck_id = 2059400100 + abs(hash(typ_path.stem)) % 100000
    deck_title = f"MA201: Multivariable Calculus — {typ_path.stem.capitalize()}"
    deck = genanki.Deck(deck_id, deck_title)

    for q_num, q_text, a_text in cards:
        note = genanki.Note(
            model=CALC_MODEL,
            fields=[q_num, q_text, a_text],
        )
        deck.add_note(note)

    package = genanki.Package(deck)
    out_apkg.parent.mkdir(parents=True, exist_ok=True)
    package.write_to_file(str(out_apkg))
    print(f"Generated {out_apkg} with {len(cards)} flashcards.")

if __name__ == "__main__":
    src_file = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("main.typ")
    dest_file = Path(sys.argv[2]) if len(sys.argv) > 2 else src_file.with_suffix(".apkg")
    build_deck(src_file, dest_file)

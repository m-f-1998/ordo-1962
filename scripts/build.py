#!/usr/bin/env python3
"""
Build script: merges source data files into the docs/data/ structure
served by GitHub Pages.

Source layout:
  data/ordo/YYYY.json         → docs/data/ordo/YYYY.json  (copied as-is)
  data/prayers.json           → docs/data/prayers.json    (copied as-is)
  data/locale/*.json          → docs/data/locale.json     (merged)
  data/votives/*.json         → docs/data/votives.json    (merged into array)
"""

import json
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
DATA_SRC = ROOT / "data"
DOCS_DATA = ROOT / "docs" / "data"


def build_ordo() -> int:
    src = DATA_SRC / "ordo"
    dst = DOCS_DATA / "ordo"
    dst.mkdir(parents=True, exist_ok=True)
    count = 0
    for f in sorted(src.glob("*.json")):
        shutil.copy2(f, dst / f.name)
        count += 1
    return count


def build_prayers() -> None:
    shutil.copy2(DATA_SRC / "prayers.json", DOCS_DATA / "prayers.json")


def build_locale() -> None:
    result: dict = {
        "in_certain_locations": [],
        "feasts": {"countries": [], "locale": {}},
    }
    for f in sorted((DATA_SRC / "locale").glob("*.json")):
        doc = json.loads(f.read_text())
        location: str = doc["location"]
        if location == "In Certain Locations":
            result["in_certain_locations"] = doc.get("locale", [])
        else:
            result["feasts"]["countries"].append(location)
            result["feasts"]["locale"][location] = doc["locale"]

    (DOCS_DATA / "locale.json").write_text(
        json.dumps(result, ensure_ascii=False, separators=(",", ":"))
    )


def build_votives() -> None:
    votives = []
    for f in sorted((DATA_SRC / "votives").glob("*.json")):
        doc = json.loads(f.read_text())
        votives.append(doc)

    (DOCS_DATA / "votives.json").write_text(
        json.dumps(votives, ensure_ascii=False, separators=(",", ":"))
    )


def main() -> None:
    DOCS_DATA.mkdir(parents=True, exist_ok=True)

    count = build_ordo()
    print(f"  ordo:    {count} year files copied")

    build_prayers()
    print("  prayers: copied")

    build_locale()
    print("  locale:  merged")

    build_votives()
    print("  votives: merged")

    print(f"\nOutput: {DOCS_DATA}")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Build failed: {e}", file=sys.stderr)
        sys.exit(1)

#!/usr/bin/env python3
"""
Build script: merges source data files into the docs/data/ structure
served by GitHub Pages, and creates a compressed copy in app/data/ for the iOS bundle.

Source layout:
  data/ordo/YYYY.json         → docs/data/ordo/YYYY.json  (copied as-is)
                              → app/data/ordo/YYYY.zlib   (compressed)
  data/prayers.json           → docs/data/prayers.json    (copied as-is)
                              → app/data/prayers.json     (copied as-is)
  data/locale/*.json          → docs/data/locale.json     (merged)
                              → app/data/locale.json      (merged)
  data/votives/*.json         → docs/data/votives.json    (merged)
                              → app/data/votives.json     (merged)
"""

import json
import shutil
import sys
import zlib
from pathlib import Path

ROOT = Path(__file__).parent.parent
DATA_SRC = ROOT / "data"
DOCS_DATA = ROOT / "docs" / "data"
APP_DATA = ROOT / "app" / "data"

def compress_file(src_path: Path, dst_path: Path):
    with open(src_path, 'rb') as f_in:
        data = f_in.read()
    compress = zlib.compressobj(level=9, wbits=-zlib.MAX_WBITS)
    compressed = compress.compress(data) + compress.flush()
    with open(dst_path, 'wb') as f_out:
        f_out.write(compressed)

def build_ordo() -> int:
    src = DATA_SRC / "ordo"
    dst = DOCS_DATA / "ordo"
    app_dst = APP_DATA / "ordo"
    dst.mkdir(parents=True, exist_ok=True)
    app_dst.mkdir(parents=True, exist_ok=True)
    count = 0
    for f in sorted(src.glob("*.json")):
        shutil.copy2(f, dst / f.name)
        compress_file(f, app_dst / f.with_suffix('.zlib').name)
        count += 1
    return count


def build_prayers() -> None:
    shutil.copy2(DATA_SRC / "prayers.json", DOCS_DATA / "prayers.json")
    shutil.copy2(DATA_SRC / "prayers.json", APP_DATA / "prayers.json")


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

    json_str = json.dumps(result, ensure_ascii=False, separators=(",", ":"))
    (DOCS_DATA / "locale.json").write_text(json_str)
    (APP_DATA / "locale.json").write_text(json_str)


def build_votives() -> None:
    votives = []
    for f in sorted((DATA_SRC / "votives").glob("*.json")):
        doc = json.loads(f.read_text())
        votives.append(doc)

    json_str = json.dumps(votives, ensure_ascii=False, separators=(",", ":"))
    (DOCS_DATA / "votives.json").write_text(json_str)
    (APP_DATA / "votives.json").write_text(json_str)


def main() -> None:
    DOCS_DATA.mkdir(parents=True, exist_ok=True)
    APP_DATA.mkdir(parents=True, exist_ok=True)

    count = build_ordo()
    print(f"  ordo:    {count} year files copied and compressed")

    build_prayers()
    print("  prayers: copied")

    build_locale()
    print("  locale:  merged")

    build_votives()
    print("  votives: merged")

    print(f"\nOutput: {DOCS_DATA} and {APP_DATA}")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Build failed: {e}", file=sys.stderr)
        sys.exit(1)

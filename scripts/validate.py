#!/usr/bin/env python3
"""
Validates all source JSON data files in data/.
Checks:
  - All files are valid JSON
  - Ordo files have required top-level keys: Year, Ordo
  - Locale files have required keys: location, locale
  - Votives files have required keys: title, masses
  - prayers.json has at least one entry
  - No year gaps in data/ordo/ between min and max year present
"""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
DATA = ROOT / "data"

ERRORS: list[str] = []


def err(msg: str) -> None:
    ERRORS.append(msg)
    print(f"  ✗ {msg}")


def ok(msg: str) -> None:
    print(f"  ✓ {msg}")


def validate_ordo() -> None:
    print("Ordo files:")
    ordo_dir = DATA / "ordo"
    years: list[int] = []
    for f in sorted(ordo_dir.glob("*.json")):
        try:
            doc = json.loads(f.read_text())
        except json.JSONDecodeError as e:
            err(f"{f.name}: invalid JSON — {e}")
            continue
        if "Year" not in doc:
            err(f"{f.name}: missing 'Year' key")
        elif doc["Year"] != int(f.stem):
            err(f"{f.name}: Year value {doc['Year']} does not match filename")
        if "Ordo" not in doc:
            err(f"{f.name}: missing 'Ordo' key")
        elif not isinstance(doc["Ordo"], list) or len(doc["Ordo"]) == 0:
            err(f"{f.name}: 'Ordo' must be a non-empty list")
        else:
            years.append(int(f.stem))

    if years:
        ok(f"{len(years)} ordo files valid")
        full_range = set(range(min(years), max(years) + 1))
        missing = full_range - set(years)
        if missing:
            err(f"Missing ordo years: {sorted(missing)}")
        else:
            ok(f"No year gaps ({min(years)}–{max(years)})")


def validate_locale() -> None:
    print("Locale files:")
    locale_dir = DATA / "locale"
    for f in sorted(locale_dir.glob("*.json")):
        try:
            doc = json.loads(f.read_text())
        except json.JSONDecodeError as e:
            err(f"{f.name}: invalid JSON — {e}")
            continue
        for key in ("location", "locale"):
            if key not in doc:
                err(f"{f.name}: missing '{key}' key")
    ok(f"{len(list(locale_dir.glob('*.json')))} locale files checked")


def validate_votives() -> None:
    print("Votives files:")
    votives_dir = DATA / "votives"
    for f in sorted(votives_dir.glob("*.json")):
        try:
            doc = json.loads(f.read_text())
        except json.JSONDecodeError as e:
            err(f"{f.name}: invalid JSON — {e}")
            continue
        for key in ("title", "masses"):
            if key not in doc:
                err(f"{f.name}: missing '{key}' key")
    ok(f"{len(list(votives_dir.glob('*.json')))} votives files checked")


def validate_prayers() -> None:
    print("Prayers:")
    f = DATA / "prayers.json"
    try:
        doc = json.loads(f.read_text())
        if not doc:
            err("prayers.json is empty")
        else:
            ok("prayers.json valid")
    except json.JSONDecodeError as e:
        err(f"prayers.json: invalid JSON — {e}")


def main() -> None:
    validate_ordo()
    validate_locale()
    validate_votives()
    validate_prayers()

    print()
    if ERRORS:
        print(f"❌ {len(ERRORS)} error(s) found.")
        sys.exit(1)
    else:
        print("✅ All data files valid.")


if __name__ == "__main__":
    main()

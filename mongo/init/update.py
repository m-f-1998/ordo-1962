import json
import os
import re

def fix_fasting_format(filename):
    print (f"Processing {filename}...")
    with open(filename, 'r', encoding='utf-8') as f:
        data = json.load(f)

    changed = False

    for month in data['Ordo']:
      for day in month:
        fasting = day.get("fasting")
        if isinstance(fasting, str):
          # Split by delimiter and strip whitespace
          split_fasting = [x.strip() for x in fasting.split('|') if x.strip()]
          data["Ordo"][data["Ordo"].index(month)][month.index(day)]["fasting"] = split_fasting
          changed = True

    if changed:
        with open(filename, 'w', encoding='utf-8') as f:
            print (f"Fixing fasting format in {filename}...")
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"✅ Fixed: {filename}")
    else:
        print(f"✅ Already OK: {filename}")

# Run for all matching files
for fname in os.listdir('.'):
    if re.match(r'ordo\.universal\.(20[2-9][0-9]|210[0-9]|211[0-9]|212[0-3])\.json', fname):
        fix_fasting_format(fname)

print("🎉 Done fixing fasting fields.")

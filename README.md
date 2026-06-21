## 1962 Liturgical Ordo (iOS)

Available on the [Apple App Store](https://apps.apple.com/gb/app/1962-liturgical-ordo/id6450934181).

*"If you want a church full of Catholics who know their faith, love their faith and practice their faith, give them a liturgy that is demanding, profound and rigourous. They will rise to the challenge."*  
— Peter Kwasniewski

A Traditional Catholic Liturgical Calendar for the Holy Sacrifice of the Mass according to the 1962 Missale Romanum issued by Pope St. John XXIII. Designed for the easy accessibility of the faithful and an increase of awareness regarding the Traditional Mass.

This repository is open for data contributions — new locale data (countries or dioceses), additional prayers, or corrections to existing propers are all welcome.

## 🌱 Features

- Liturgical Ordo (2023–2123)
- Lock Screen & Home Screen Widgets
- watchOS Support
- Propers of the Mass (English & Latin)
- Basic Prayers
- Changeable Years
- Votive Masses
- Localisation Support (country & diocesan feasts)

## 🗂️ Data

All liturgical data lives in `data/` as individual JSON files. 

**Adding locale data:** Add a new file in `data/locale/` following the existing format.  
**Adding propers:** Edit the relevant file in `data/ordo/`.

### Building Data

The `docs/data` and `app/data` directories are generated automatically from the source files in `data/`. These generated files are explicitly ignored from source control.

To generate these files locally (required before building the iOS app in Xcode), run:
```bash
python3 scripts/build.py
```

On every push to `main`, a GitHub Actions workflow automatically builds and publishes the generated data to [GitHub Pages](https://m-f-1998.github.io/ordo-1962/).

## 📄 Privacy Policy

[https://m-f-1998.github.io/ordo-1962/](https://m-f-1998.github.io/ordo-1962/)
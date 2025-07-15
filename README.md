## 1962 Liturgical Ordo (iOS & Android)

Available on the [Apple App Store](https://apps.apple.com/gb/app/1962-liturgical-ordo/id6450934181) and [Google Play Store](https://play.google.com/store/apps/details?id=com.mfrankland.ordo_1962&hl=en_US).

“If you want a church full of Catholics who know their faith, love their faith and practice their faith, give them a liturgy that is demanding, profound and rigourous. They will rise to the challenge.”  Peter Kwasniewski

A Traditional Catholic Liturgical Calendar for the Holy Sacrifice of the Mass according to the 1962 Missale Romanum issued by Pope St. John XXIII. This App is designed for the easy accessibility of the faithful and an increase of awareness regarding the Traditional Mass. Features include:

This Repository is for contributing more data to the app, including for individual locales and languages. Propers have a required format - see the universal calendar - and are ready in markdown format. New Locale Data is welcome for countries or dioceses. Or both :)

## 🌱 Features

- Ordo Implementation
- Lock Screen Widgets
- Home Screen Widgets
- Basic Prayers
- Changeable Years
- Propers of the Mass
- Localization Support
- Votive Masses

## 🚀 Deployment

Images are published to:
- `ghcr.io/m-f-1998/ordo-1962:dev` – Dev (`beta.*`)
- `ghcr.io/m-f-1998/ordo-1962:latest` – Production

## 🐳 Local Development

```bash
./dev.sh # Docker Compose Local Development Server on Port 3000
./deploy.sh ${dev|latest} # Deploy Package (Requires GHCR Access Token)
```

## 🔧 Required Environment Variables

The backend server requires the following environment variables to function properly:

| Variable              | Description                         |
|-----------------------|-------------------------------------|
| `DB` | The name of the connected postgres database |
| `USER`           | The user connected to the database |
| `PASS`           | The password for the database |

## 📁 Example `.env` (for local dev)

```env
DB=ordo-1962
USER=your@email.com
PASS=yourpassword
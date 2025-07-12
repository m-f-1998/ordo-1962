#!/bin/bash

set -e

# Get the directory of the script to handle relative paths correctly
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Cleaning previous builds..."
rm -rf "$SCRIPT_DIR/../client/dist" "$SCRIPT_DIR/../server/dist"

echo "📦 Installing server dependencies..."
cd server
npm ci

echo "⚙️ Compiling backend (TypeScript)..."
npx tsc
cd ..

echo "✅ Build complete."
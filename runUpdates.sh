#!/bin/bash

set -e

echo ""
echo "🔄 Updating server packages..."
cd ../server
npm update --save
if [ -n "$(npm outdated)" ]; then
  echo "Some packages have major updates and need to be checked manually."
  npm outdated
fi

read -p "Press any key to exit..." -n1 -s
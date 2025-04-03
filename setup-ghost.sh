#!/bin/bash

set -e

# Load nvm
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "🚀 Setting up Ghost local development..."

if ! command -v nvm &> /dev/null
then
    echo "❌ nvm is not installed. Please install it first using Homebrew and configure your shell."
    exit 1
fi

echo "📁 Creating ghost/ folder next to this repo..."
cd ..
mkdir -p ghost
cd ghost

echo "📦 Installing latest Node.js v20.x with nvm..."
nvm install 20
nvm use 20
nvm alias default 20

echo "📝 Writing .nvmrc..."
echo "20" > .nvmrc

echo "⚙️ Installing Ghost locally using ghost-cli..."

# Ensure ghost-cli is globally available
if ! command -v ghost &> /dev/null; then
    echo "🔧 Installing ghost-cli globally..."
    npm install -g ghost-cli
fi

# Run the Ghost install
ghost install local

echo "📁 Initializing project metadata for theme tools..."
npm init -y

echo "🔧 Installing yarn and gscan (optional dev tools)..."
npm install --save-dev yarn gscan

echo "✅ Ghost is running at http://localhost:2368"
echo "🛠️ Admin panel: http://localhost:2368/ghost"

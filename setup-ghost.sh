#!/bin/bash

set -e

echo "🚀 Setting up Ghost local development..."

# Make sure nvm is available
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

echo "📁 Initializing project..."
npm init -y

echo "🔧 Installing ghost-cli and yarn locally..."
npm install --save-dev ghost-cli yarn

echo "⚙️ Installing Ghost locally in dev mode..."
npx ghost install local

echo "✅ Ghost is running at http://localhost:2368"
echo "🛠️ Admin panel: http://localhost:2368/ghost"

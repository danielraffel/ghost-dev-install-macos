#!/bin/bash

set -e

echo "🚀 Setting up Ghost local development..."

# Check for nvm
if ! command -v nvm &> /dev/null
then
    echo "❌ nvm is not installed. Please install it first using Homebrew and configure your shell."
    exit 1
fi

echo "📦 Installing Node.js latest v20.x via nvm..."
nvm install 20
nvm use 20
nvm alias default 20

echo "📝 Creating .nvmrc..."
echo "20" > .nvmrc

echo "📁 Initializing project..."
npm init -y

echo "🔧 Installing ghost-cli and yarn locally..."
npm install --save-dev ghost-cli yarn

echo "⚙️ Installing Ghost (local mode)..."
npx ghost install local

echo "✅ Ghost is running at http://localhost:2368"
echo "🛠️ Admin panel: http://localhost:2368/ghost"

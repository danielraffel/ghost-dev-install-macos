#!/bin/bash

set -e

echo "🚀 Setting up Ghost local development..."

if ! command -v nvm &> /dev/null
then
    echo "❌ nvm is not installed. Please install it first using Homebrew and configure your shell."
    exit 1
fi

echo "📦 Installing Node.js v20.19.0 via nvm..."
nvm install 20.19.0
nvm use 20.19.0
nvm alias default 20.19.0

echo "📝 Creating .nvmrc..."
echo "20.19.0" > .nvmrc

echo "📁 Initializing project..."
npm init -y

echo "🔧 Installing ghost-cli and yarn locally..."
npm install --save-dev ghost-cli yarn

echo "⚙️ Installing Ghost (local mode)..."
npx ghost install local

echo "✅ Ghost is running at http://localhost:2368"
echo "🛠️ Admin panel: http://localhost:2368/ghost"

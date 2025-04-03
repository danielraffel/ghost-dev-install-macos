# 🧑‍💻 Ghost Development on macOS Using Local-Only Dependencies 

This guide helps you set up a [Ghost local development environment](https://ghost.org/docs/install/local/) on macOS with minimal global dependencies, so it’s easy to maintain — and just as easy to delete without leaving anything behind.

It includes:
- Node.js **v20** installed via [`nvm`](https://github.com/nvm-sh/nvm), matching the [recommended version](https://ghost.org/docs/faq/node-versions/) for Ghost at the time of publishing.
- Local installs of `yarn` and `gscan`, avoiding global clutter
- Auto-managed Node versions via `.nvmrc`
- Theme development with GitHub integration
- A cleanup-friendly setup — just delete the project folder to remove everything

---
Table of Contents
- [Quick Start](https://github.com/danielraffel/ghost-dev-install-macos/blob/main/README.md#%EF%B8%8F-quick-start-recommended)
- [Configuring your profile with Node](https://github.com/danielraffel/ghost-dev-install-macos/blob/main/README.md#-bonus-auto-use-nvmrc-node-version-on-cd)
- [How to run yarn and gscan](https://github.com/danielraffel/ghost-dev-install-macos/edit/main/README.md#-how-to-run-yarn-and-gscan)
 
---

## 🧰 Prerequisites

Make sure the following are installed:

### 1. Homebrew (if not already)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. `nvm` (Node Version Manager)

```bash
brew install nvm
mkdir ~/.nvm
```

In your shell config (`~/.zshrc` or `~/.bashrc`):

```bash
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
```

Then run:

```bash
source ~/.zshrc  # or ~/.bashrc
```

---

## ⚙️ Quick Start (Recommended)

From the directory where you want both this repo and the Ghost project to live side by side:

```bash
git clone https://github.com/danielraffel/ghost-dev-install-macos.git
cd ghost-dev-install-macos
chmod +x setup-ghost.sh
./setup-ghost.sh
```

This script will:
- Install Node (via nvm)
- Create a .nvmrc file
- Clone and set up Ghost in a sibling folder called `ghost`
- Install `yarn` and `gscan` as local dev tools
- Launch your local Ghost development site

---

## 🛠 Manual Setup (Not Recommended _But If You Prefer_)

### 1. Install Node.js v20

```bash
nvm install 20
nvm use 20
```

Then create `.nvmrc`:

```bash
echo "20" > .nvmrc
```

✅ **Why `.nvmrc` matters**:
- It pins the Node version for the project.
- Anyone who clones the repo can just run `nvm use` to switch to the correct version.
- No need to remember or hardcode Node versions in CI/dev tools.

---

### 2. Install Ghost Locally

Use the globally installed `ghost-cli` or install it first:

```bash
npm install -g ghost-cli
```

Then in your working directory:

```bash
mkdir ghost && cd ghost
ghost install local
```

---

### 3. Install Dev Tools

```bash
npm init -y
npm install --save-dev yarn gscan
```

This gives you access to:

- `npx yarn` for theme dependency management
- `npx gscan` for theme validation

---

### 4. Develop Your Custom Theme

```bash
cd content/themes
git clone https://github.com/YOUR_USERNAME/YOUR_THEME_REPO.git my-theme
```

Activate the theme via Admin → **Settings → Design**.

Ghost supports live reload for `.hbs`, `.css`, `.js`.  
Restart Ghost if you add **new files**:

```bash
ghost restart
```

---

### 5. Cleanup

To delete the Ghost dev environment:

```bash
rm -rf ../ghost
```

To remove the installed Node version:

```bash
nvm uninstall 20
```

To remove `nvm` entirely (if desired):

```bash
rm -rf ~/.nvm
```

---

## 📂 Project Structure

```
path/to/your/dev/folder/
├── ghost/                    # Ghost project folder
│   ├── content/
│   ├── versions/
│   ├── config.development.json
│   ├── .nvmrc
│   ├── package.json
│   └── node_modules/
└── ghost-dev-install-macos/  # Setup helper repo
    ├── setup-ghost.sh
    └── README.md
```

---

## ❓ FAQ

### 🤔 Why use `npx` instead of installing tools globally?

- Keeps your system clean
- Makes installs portable and per-project
- No conflicts between node versions across projects

### 🤓 Do I need to install `npm`?

No — it comes bundled with Node.js when you install via `nvm`.

### 🧩 Can I run multiple Node projects?

Yes. You can install and switch between versions easily using `nvm`:

```bash
nvm install 18
nvm use 18
```

Use `.nvmrc` to pin versions per project.

### 🪄 What is `.nvmrc` and why use it?

`.nvmrc` is a simple file that specifies which version of Node to use in a project. It makes collaboration and automation easier.

```bash
echo "20" > .nvmrc
nvm use  # will auto-switch to the correct version
```

### 🧽 How do I clean up everything?

- Delete the Ghost dev setup:
  ```bash
  rm -rf ../ghost
  ```
- Remove Node version:
  ```bash
  nvm uninstall 20
  ```
- Remove `nvm`:
  ```bash
  rm -rf ~/.nvm
  ```

### ⚠️ Why do I see npm warnings and vulnerabilities after installation?

This is normal. Some dev tools like `gscan` use outdated or deprecated packages. These warnings are safe to ignore for local development.

You can optionally run:

```bash
npm audit fix
```

But unless you're publishing a package to production, it’s probably fine to leave them.

---

## ✅ Summary

| Task                    | Command / File                            |
|-------------------------|-------------------------------------------|
| Install Node            | `nvm install 20`                          |
| Auto Node switching     | `.nvmrc` + `nvm use`                      |
| Install Ghost           | `ghost install local`                    |
| Install tools           | `npm install --save-dev yarn gscan`      |
| Restart Ghost           | `ghost restart`                          |
| Validate theme (opt)    | `npx gscan path/to/theme`                |
| Cleanup                 | `rm -rf ../ghost`                         |

---

## 🧙 Bonus: Auto-Use `.nvmrc` Node Version on `cd`

To automatically use the correct Node.js version when switching into your Ghost dev folder (or any folder with an `.nvmrc`), add this to your `~/.zshrc` (for Zsh) or `~/.bashrc`:

```bash
# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Auto-switch Node versions when entering folders with .nvmrc
autoload -U add-zsh-hook

load-nvmrc() {
  if [ -f .nvmrc ]; then
    nvm use &> /dev/null
  elif nvm_rc_version=$(nvm version default); then
    nvm use default &> /dev/null
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc  # run once at startup
```

Once added, run:

```bash
source ~/.zshrc  # or ~/.bashrc
```

Now when you `cd ghost`, your terminal will automatically use Node v20 from `.nvmrc` — no need to run `nvm use` manually again.

---

### 💡 Why the `elif`?

The added `elif` fallback helps prevent getting “N/A” errors if `.nvmrc` is missing — it falls back to your **default Node version**, which you can set with:

```bash
nvm alias default 20
```

This sets Node.js v20 as your go-to version when no `.nvmrc` file is found. You only need to run that once, and `nvm` will remember it. To check what your current default is:

```bash
nvm alias
```

This makes your shell experience smoother overall, especially if you switch between projects that do or don’t have `.nvmrc` files.

---

## 🧶 How to Run `yarn` and `gscan`

Since this guide installs both `yarn` and `gscan` as **local dev dependencies**, you'll run them using [`npx`](https://docs.npmjs.com/cli/v9/commands/npx). This ensures you're always using the version specific to the project — no need for global installs.

### ✅ To install theme dependencies

If your theme has a `package.json`, run:

```bash
npx yarn install
```

This installs the theme's dependencies using `yarn`.

> 💡 If you see a warning about `package-lock.json`, it's because Yarn prefers using `yarn.lock`. You can safely delete `package-lock.json` to avoid conflicts:
> ```bash
> rm package-lock.json
> ```

---

### 🧪 To validate your Ghost theme

Use `gscan` to check for compatibility or errors:

```bash
npx gscan path/to/your-theme/
```

For example:

```bash
npx gscan content/themes/my-theme/
```

This scans your theme and reports any issues or deprecations based on the current Ghost version.

---

## 🛑 Disclaimer:

Note: Use this at your own risk. This setup is provided as-is and may change or break as dependencies evolve.

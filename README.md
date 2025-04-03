# 🧑‍💻 Ghost Local Development on macOS

This guide helps you set up a fully disposable, version-controlled Ghost development environment on macOS using:

- Node.js **v20** via [`nvm`](https://github.com/nvm-sh/nvm)
- Local-only installs of `ghost-cli`, `yarn`, and optionally `gscan`
- Auto-managed Node versions via `.nvmrc`
- Theme development with GitHub integration
- A cleanup-friendly structure — delete the folder, and it's gone!

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

## ⚙️ Quick Start (One-Command Setup)

Clone this repo and run the script:

```bash
git clone https://github.com/danielraffel/ghost-dev-install-macos.git
cd ~/ghost-dev
./setup-ghost.sh
```

This does all the steps below automatically: installs Node, sets up Ghost, creates `.nvmrc`, installs `yarn`, and starts your dev site.

---

## 🛠 Manual Setup (If You Prefer)

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

### 2. Initialize and Install Dev Tools

```bash
npm init -y
npm install --save-dev ghost-cli yarn
```

You now have access to:

- `npx ghost` for all Ghost CLI commands
- `npx yarn` for theme dependency management

---

### 3. Install Ghost Locally (Dev Mode)

```bash
npx ghost install local
```

This sets up:
- Ghost running on http://localhost:2368
- Admin panel at http://localhost:2368/ghost
- SQLite3 database in `content/data/`
- Content folder with themes at `content/themes/`

---

### 4. Develop Your Custom Theme

Clone your theme repo inside the Ghost content folder:

```bash
cd content/themes
git clone https://github.com/YOUR_USERNAME/YOUR_THEME_REPO.git my-theme
```

Then activate it via Admin → **Settings → Design**.

Ghost supports automatic reload on changes to `.hbs`, `.css`, `.js`.  
Restart Ghost if you add **new files**:

```bash
npx ghost restart
```

---

### 5. (Optional) Validate Your Theme

```bash
npm install --save-dev gscan
npx gscan content/themes/my-theme
```

---

### 6. Cleanup

To delete the Ghost dev environment:

```bash
rm -rf ~/ghost-dev
```

To remove the installed Node version:

```bash
nvm uninstall 20.19.0
```

To remove `nvm` entirely (if desired):

```bash
rm -rf ~/.nvm
```

---

## 📂 Project Structure

```
ghost-dev/
├── .nvmrc
├── content/
│   ├── data/         # SQLite DB
│   ├── themes/       # Custom themes go here
│   └── logs/         # Optional log output
├── versions/         # Ghost core binary
├── node_modules/     # Local dependencies (ghost-cli, yarn, etc.)
├── package.json
└── setup-ghost.sh    # Setup script
```

---

## ❓ FAQ

### 🤔 Why use `npx` instead of installing tools globally?

- Keeps your system clean
- Makes installs portable and per-project
- No conflicts between versions across projects

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
echo "20.19.0" > .nvmrc
nvm use  # will auto-switch to the correct version
```

### 🧽 How do I clean up everything?

- Delete the entire Ghost dev setup:
  ```bash
  rm -rf ~/ghost-dev
  ```
- Remove Node version:
  ```bash
  nvm uninstall 20.19.0
  ```
- Remove `nvm` (if you really want to):
  ```bash
  rm -rf ~/.nvm
  ```

---

## ✅ Summary

| Task                    | Command / File                      |
|-------------------------|-------------------------------------|
| Install Node            | `nvm install 20.19.0`               |
| Auto Node switching     | `.nvmrc` + `nvm use`                |
| Install tools           | `npm install --save-dev ghost-cli yarn` |
| Start Ghost             | `npx ghost install local`           |
| Restart Ghost           | `npx ghost restart`                 |
| Validate theme (opt)    | `npx gscan path/to/theme`           |
| Cleanup                 | `rm -rf ~/ghost-dev`                |

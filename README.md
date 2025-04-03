# 🧑‍💻 Ghost Local Development on macOS

This guide helps you set up a [Ghost local development environment](https://ghost.org/docs/install/local/) on macOS with minimal global dependencies, so it’s easy to maintain — and just as easy to delete without leaving anything behind.

It includes:
	•	Node.js **v20** installed via [`nvm`](https://github.com/nvm-sh/nvm), matching the [recommended version](https://ghost.org/docs/faq/node-versions/) for Ghost at the time of publishing.
	•	Local installs of `yarn` and `gscan`, avoiding global clutter
	•	Auto-managed Node versions via `.nvmrc`
	•	Theme development with GitHub integration
	•	A cleanup-friendly setup — just delete the project folder to remove everything
 
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

## ⚙️ Quick Start

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

## 🛑 Disclaimer:

Note: Use this at your own risk. This setup is provided as-is and may change or break as dependencies evolve.

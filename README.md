# AstroNvim Template

Forked from [AstroNvim template](https://github.com/AstroNvim/template)

**NOTE:** This is for AstroNvim v5+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

To use this config, make sure to have the following packages available on the system:

- neovim v0.10+ (0.11 preferred)
- rust/rust-analyzer/rustfmt
- nodejs
- npm
- python-pip
- ruby
- zip/unzip/gzip
- lazygit/git
- latex
- fzf
- ripgrep
- lldb
- llvm/clang/clangd/clang-format
- yarn
- optional: gdu, bottom

For Arch Linux:

```bash
pacman -S --needed neovim rustup nodejs npm zip unzip gzip fzf ripgrep git lazygit llvm lldb yarn gdu bottom ruby texlive-latexrecommended
```

For the minimal branch:

```bash
pacman -S --needed neovim rustup nodejs npm zip unzip gzip fzf ripgrep git lazygit llvm lldb yarn gdu bottom
```

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone https://github.com/joske/astronvim_v4 ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

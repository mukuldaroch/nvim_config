
# Neovim Configuration

This repository contains my personal Neovim configuration. It aims to provide a streamlined and efficient development environment with a focus on clean looks and minimal plugins(e.g., LSP, code completion, syntax highlighting, etc.).
## Installation

For Installation : Run these command in .config Directory 

```bash
git clone https://github.com/mukuldaroch/nvim_config.git
```
```bash
mv nvim_config/ nvim
```
### Directory structure
```bash
└───lua
    ├───config
    ├───core
    ├───plugins
    └───remaps

```
### File structure
```bash
nvim/
├── coc-settings.json
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── colors.lua
│   │   ├── dashboard.lua
│   │   ├── Explorer.lua
│   │   ├── luasnip.lua
│   │   ├── null-ls.lua
│   │   ├── nvim_tree.lua
│   │   └── terminal.lua
│   ├── core
│   │   ├── lazy.lua
│   │   └── mason.lua
│   ├── plugins
│   │   ├── alpha_dashboard.lua
│   │   ├── colorschemes.lua
│   │   ├── Git.lua
│   │   ├── lspconfig.lua
│   │   ├── nvim_cmp.lua
│   │   ├── snippets.lua
│   │   ├── telescope.lua
│   │   ├── terminal.lua
│   │   ├── treesitter.lua
│   │   └── vimbegood.lua
│   └── remaps
│       ├── init.lua
│       ├── plugins.lua
│       └── remap.lua
└── README.md

6 directories, 26 files

```
## Features
Plugin Management: Using lazy.nvim for efficient plugin management.
Language Server Protocol (LSP): Configured for Lua, Python, C++, and other languages.
Code Completion: Integrated with nvim-cmp for autocompletion.
File Explorer: Customized file tree view with Telescope.nvim.
Custom Keybindings: Various custom keybindings for enhanced productivity.
Theming: carbonfox for an aesthetically pleasing and functional interface.
Installation
Clone the Repository:


# Neovim Configuration

This repository contains my personal Neovim configuration. It aims to provide a streamlined and efficient development environment with a focus on clean looks and minimal plugins(e.g., LSP, code completion, syntax highlighting, etc.).
## Installation

For Installation : Run this command in .config Directory 

```bash
git clone https://github.com/Mukul-daroch/nvim_config.git
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
│
├── lua/
│   │
│   ├── config/
│   │   ├── cmp
│   │   ├── colorscheme
│   │   ├── dashboard
│   │   ├── luasnip
│   │   ├── null-ls
│   │   ├── nvim_tree
│   │   └── path
│   │
│   ├── core/
│   │   ├── lazy
│   │   └── mason
│   │
│   ├── custom/
│   │   ├── Explorer
│   │   ├── buffer
│   │   └── show_path
│   │
│   ├── plugins/
│   │   ├── alpha_dashboard
│   │   ├── autocompletion
│   │   ├── cloak
│   │   ├── fugitive
│   │   ├── init
│   │   ├── lspconfig
│   │   ├── neotest
│   │   ├── nvim_cmp
│   │   ├── nvim_tree
│   │   ├── other
│   │   ├── snippets
│   │   ├── telescope
│   │   ├── terminal
│   │   ├── treesitter
│   │   ├── trouble
│   │   └── vimbegood
│   │
│   └── remaps/
│       ├── init
│       ├── plugins
│       └── remap
│
├── Readme.text
├── init
├── lazy-lock.json

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

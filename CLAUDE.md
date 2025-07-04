# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration using a hybrid Lua/VimScript approach with local plugin management. The configuration prioritizes stability, offline availability, and customization over automatic updates.

### Configuration Structure

- **Entry Point**: `init.lua` - Main configuration file that sources VimScript and sets up plugins
- **VimScript Core**: `vimrc.vim` - Traditional Vim settings, keymaps, and core behavior
- **Lua Configuration**: 
  - `lua/global-options.lua` - Neovim-specific options
  - `lua/global-keymaps.lua` - Global key mappings
  - `lua/lazy-desc.lua` - Plugin specification manifest
  - `lua/lazy/` - Individual plugin configurations

### Plugin Management

**Unique Local Plugin Architecture**: This configuration uses a local plugin directory approach rather than fetching from remote repositories.

- **Plugin Directory**: `plugins/` contains actual plugin repositories
- **Loading Pattern**: Each plugin config uses `dir = vim.fn.stdpath("config") .. "/plugins/[plugin-name]"`
- **No Auto-Updates**: All plugins are vendored locally and must be updated manually
- **Plugin Manifest**: `lua/lazy-desc.lua` defines which plugins are loaded

### Key Components

#### LSP Configuration
Multiple language servers are configured in `lua/lazy/nvim-lspconfig.lua`:
- Python (pylsp)
- Nix (nil)
- Terraform (terraformls)
- PowerShell (powershell_es)
- Zig (zls)
- Azure Pipelines (custom server)

#### Search & Navigation
Two search tools are configured:
- **Telescope**: Primary fuzzy finder with extensive customization
- **fzf-lua**: Alternative search interface
- **Harpoon**: Quick file navigation between frequently used files

#### Git Integration
- **Fugitive**: Core Git operations and commands
- **Gitsigns**: Git status in sign column
- **Diffview**: Enhanced diff and merge tools

### Leader Key Configuration

Space bar (`<Space>`) is the leader key. Key patterns:
- `<leader>p/P` - Paste from yank register
- `<leader>z` - Save and quit
- `<leader>q` - Quit all without saving
- `kj` - Exit insert mode
- `<C-s>` - Save file (works in Normal, Visual, and Insert modes)

### TreeSitter Parsers

Custom TreeSitter parser directory at `treesitter-parsers/` with locally managed parsers for syntax highlighting and text objects.

### Working with This Configuration

#### Adding New Plugins
1. Add the plugin repository to `plugins/` directory
2. Create configuration file in `lua/lazy/[plugin-name].lua`
3. Add require statement to `lua/lazy-desc.lua`
4. Plugin config should use local path: `dir = vim.fn.stdpath("config") .. "/plugins/[plugin-name]"`

#### Updating Plugins
Plugins must be updated manually by pulling changes in their respective directories under `plugins/`.

#### Modifying Keymaps
- Core Vim mappings: Edit `vimrc.vim`
- Plugin-specific mappings: Edit the relevant plugin config in `lua/lazy/`
- Global Lua mappings: Edit `lua/global-keymaps.lua`

## Nix Flake Integration

This configuration includes a `flake.nix` for reproducible Neovim environments using Nix.

### Nix Setup Commands

**Remote Usage** (from anywhere):
```bash
# Primary method - submodules should be automatically fetched
nix run github:realbogart/nvim

# Fallback if submodules aren't fetched automatically
nix run 'github:realbogart/nvim?submodules=1'

# Or use a specific revision for reproducibility
nix run 'github:realbogart/nvim/COMMIT-HASH?submodules=1'
```

**Local Usage**:
```bash
# First, initialize submodules
git submodule update --init --recursive

# Then run locally
nix run
nix develop
nix build
```

### Nix Architecture

- **Portable Design**: Can be run from anywhere using `github:realbogart/nvim`
- **Submodule Support**: Uses `inputs.self.submodules = true` to attempt automatic submodule fetching
- **Fallback Option**: `?submodules=1` parameter as backup for guaranteed submodule fetching
- **Dependencies**: Includes all required LSP servers, formatters, and tools:
  - neovim, ripgrep, git, fzf, jq
  - nil (Nix LSP), stylua (Lua formatter), prettierd (JS/TS formatter)
  - python-lsp-server, terraform-ls, powershell, zig
- **Isolation**: Creates temporary XDG_CONFIG_HOME to avoid conflicts with existing nvim configs
- **Package Output**: `nvim-johan` executable with all dependencies

**Note**: The `inputs.self.submodules = true` feature is relatively new. Use the `?submodules=1` fallback if plugins don't load properly.

### Development Notes

This configuration has no central build/test/lint commands. Individual plugins maintain their own tooling. The configuration is designed to be self-contained and work offline.

The hybrid approach leverages VimScript for traditional Vim functionality while using Lua for modern Neovim features like LSP, TreeSitter, and advanced plugin configurations.

The Nix flake provides additional reproducibility for development environments and deployment scenarios.
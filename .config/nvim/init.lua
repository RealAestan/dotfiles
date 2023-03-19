require('keymaps')
require('plugins')
require('impatient') --Uses impatient plugin to load faster
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true
vim.wo.relativenumber = true

---
-- Old VIM Script Commands
--
vim.cmd([[
set spell
]])

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd('colorscheme nord')

-- LSP and Linting Config
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'bashls', -- bash, npm i -g bash-language-server
    'clangd', -- c/c++, clang package
    'cssls', -- css, npm i -g vscode-langservers-extracted
    'dockerls', -- dockerfile, npm install -g dockerfile-language-server-nodejs
    'docker_compose_language_service', -- docker-compose, npm install @microsoft/compose-language-service
    'gopls', -- go, gopls package
    'html', -- html, npm i -g vscode-langservers-extracted
    'jsonls', -- json, npm i -g vscode-langservers-extracted
    'lua_ls', -- lua, lua-language-server package
    'marksman', -- markdown, marksman-bin package
    'rust_analyzer', -- rust, rust-analyzer package
    'sqlls', -- sql, npm i -g sql-language-server
    'tsserver', -- typescript, npm install -g typescript typescript-language-server
    'lemminx', -- xml, lemminx package
    'yamlls' -- yaml, npm install -g yaml-language-server
  },
  automatic_installation = true,
})

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- File Explorer nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup()

--Pretty Status bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'nord',
	},
}

-- Add Ctrl + X and initialize toggle term 
require("toggleterm").setup {
	open_mapping = [[<c-x>]],
	shade_terminals = false
}

-- Add projects capability to telescope
require('telescope').load_extension('projects')
require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/" },
    }
})

-- Smarter Indent setup
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}


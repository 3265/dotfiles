-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  {
    "preservim/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTreeFind", "NERDTreeFocus" },
    dependencies = {
      "ryanoasis/vim-devicons",
    },
  },
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_startup_folded = "overview",
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
})

-- Options
local opt = vim.opt

opt.autoread = true
opt.scrolloff = 5
opt.splitbelow = true
opt.title = false
opt.textwidth = 0
opt.wrap = true
opt.hidden = true
opt.visualbell = false
opt.errorbells = false
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 75
opt.belloff = "all"
opt.clipboard:prepend({ "unnamed", "unnamedplus" })

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true
opt.expandtab = true

vim.cmd("syntax enable")
opt.number = true
opt.encoding = "utf-8"
opt.laststatus = 2
opt.showtabline = 2
opt.cmdheight = 1
opt.shortmess:append("I")
opt.cursorline = true
opt.fileformats = { "unix", "dos", "mac" }
opt.background = "dark"
opt.completeopt:remove("preview")

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.wildmenu = true
opt.wildmode = "list:full"
opt.incsearch = true
opt.hlsearch = true
opt.infercase = true
opt.virtualedit = "all"
opt.switchbuf = "usetab"
opt.showmatch = true
opt.matchtime = 3
opt.backspace = "indent,eol,start"

opt.writebackup = false
opt.backup = false
opt.swapfile = false

-- User commands
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})

-- Keymaps
vim.keymap.set({ "n", "v" }, "<C-n>", "<Cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("i", "<C-n>", "<Esc><Cmd>nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "<C-t><C-t>", "<Cmd>tabprevious<CR>")
vim.keymap.set("i", "<C-t><C-t>", "<Esc><Cmd>tabprevious<CR>")
vim.keymap.set("n", "<C-t>h", "<Cmd>tabprevious<CR>")
vim.keymap.set("i", "<C-t>h", "<Esc><Cmd>tabprevious<CR>")
vim.keymap.set("n", "<C-t><C-h>", "<Cmd>tabprevious<CR>")
vim.keymap.set("i", "<C-t><C-h>", "<Esc><Cmd>tabprevious<CR>")
vim.keymap.set("n", "<C-t>l", "<Cmd>tabnext<CR>")
vim.keymap.set("i", "<C-t>l", "<Esc><Cmd>tabnext<CR>")
vim.keymap.set("n", "<C-t><C-l>", "<Cmd>tabnext<CR>")
vim.keymap.set("i", "<C-t><C-l>", "<Esc><Cmd>tabnext<CR>")

vim.keymap.set("n", "<C-w>H", "<Cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-w>J", "<Cmd>resize +5<CR>")
vim.keymap.set("n", "<C-w>K", "<Cmd>resize -5<CR>")
vim.keymap.set("n", "<C-w>L", "<Cmd>vertical resize +5<CR>")
vim.keymap.set("n", "H", "<Cmd>vertical resize -5<CR>")
vim.keymap.set("n", "J", "<Cmd>resize +5<CR>")
vim.keymap.set("n", "K", "<Cmd>resize -5<CR>")
vim.keymap.set("n", "L", "<Cmd>vertical resize +5<CR>")

vim.keymap.set("n", "Z", "ZZ")
vim.keymap.set("n", "q", "ZZ")

vim.keymap.set("n", "<C-e>", "<Cmd>NERDTreeToggle<CR>", { silent = true })
vim.keymap.set("i", "<C-e>", "<Esc><Cmd>NERDTreeToggle<CR>", { silent = true })

vim.keymap.set("n", "<C-m>", "<Cmd>marks<CR>")

vim.keymap.set("n", "<Leader>a", '<Cmd>echo "Hello"<CR>')
vim.keymap.set("n", "<Leader>t", "<Cmd>botright split | terminal<CR>", { silent = true })

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  command = "set noexpandtab shiftwidth=4 softtabstop=0",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.fish",
  command = "set filetype=sh",
})

-- Netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- Nerdtree settings
vim.g.NERDTreeShowHidden = 1

vim.cmd("filetype plugin indent on")

-- Colorscheme
vim.cmd("colorscheme kanagawa")

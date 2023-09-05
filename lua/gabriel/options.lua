vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = "<Space>"
vim.opt.number = true
vim.cmd [[set encoding=UTF-8]]
vim.cmd [[set bg=dark]]
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.conceallevel = 0

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.opt.title = false
vim.opt.clipboard = "unnamedplus"

vim.o.guifont = "FiraCode Nerd Font:h12"

if vim.g.neovide then
  -- vim.g.neovide_transparency = 0.94
  vim.g.neovide_floating_blur_amount_x = 5.0
  vim.g.neovide_floating_blur_amount_y = 5.0
  vim.g.neovide_scroll_animation_length = 1.5
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_profiler = false
end

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})
vim.cmd "set whichwrap+=<,>,[,],h,l"

vim.filetype.add({
  extension = {
    cl = 'opencl', -- just doesnt recognize OpenCL
  }
})

-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

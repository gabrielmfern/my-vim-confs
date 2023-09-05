vim.api.nvim_command("hi clear")
vim.api.nvim_command("syntax reset")

vim.cmd [[colorscheme melange]]

local pallete = {
  grays = {
    bg      = "#292522",
    float   = "#34302C",
    sel     = "#403A36",
    ui      = "#867462",
    com     = "#C1A78E",
    fg      = "#ECE1D7",
  },
  bright_foreground = {
    red     = "#D47766",
    yellow  = "#EBC06D",
    green   = "#85B695",
    cyan    = "#89B3B6",
    blue    = "#A3A9CE",
    magenta = "#CF9BC2",
  },
  foreground = {
    red     = "#BD8183",
    yellow  = "#E49B5D",
    green   = "#78997A",
    cyan    = "#7B9695",
    blue    = "#7F91B2",
    magenta = "#B380B0",
  },
  background = {
    red     = "#7D2A2F",
    yellow  = "#8B7449",
    green   = "#233524",
    cyan    = "#253333",
    blue    = "#273142",
    magenta = "#422741",
  },
}


-- neo-tree
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = pallete.grays.float, fg = pallete.grays.fg })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { link = 'NeoTreeNormal' })
vim.api.nvim_set_hl(0, 'NeoTreeVertSplit', { bg = pallete.grays.bg, fg = pallete.grays.bg })
vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { link = 'NeoTreeVertSplit' })

vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', { bg = pallete.grays.sel })

vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = pallete.bright_foreground.green })
vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = pallete.foreground.green })
vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = pallete.bright_foreground.red })
vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = pallete.foreground.red })
vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = pallete.bright_foreground.magenta })

vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = pallete.grays.sel })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'IlluminatedWordText' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'IlluminatedWordText' })


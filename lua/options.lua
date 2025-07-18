vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true


vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4


vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 24

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " " -- g == vimglobal

vim.diagnostic.config({
    -- virtual_text = true,
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.opt.diffopt:append {
  "vertical",
  "foldcolumn:0",
  "indent-heuristic",
  "algorithm:patience",
  "iwhite",
}




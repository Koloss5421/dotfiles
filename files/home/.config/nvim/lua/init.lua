require("snip_config")
require("cmp_config")
require("lsp_config")
require("ts_config")
require("keybinds")
require("theme")


-- setup must be called before loading
vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.set "relativenumber"
vim.cmd.set "number"
vim.cmd.set "cursorline"
vim.cmd.set "tabstop=4"
vim.cmd.set "shiftwidth=4"
vim.cmd.set "expandtab"
vim.o.winborder = 'rounded'

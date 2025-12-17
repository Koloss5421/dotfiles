-- nvim keybinds

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

vim.api.nvim_set_keymap("n", "<leader>r", "<Cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })

local ls = require('luasnip')
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.expand()
	end
end, {silent = true})

-- Converted keymaps
vim.api.nvim_set_keymap("n", "<F2>", "<Cmd>NERDTreeToggle<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-0>", "<Cmd>BufferLast<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-s-c>", "<Cmd>BufferRestore<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })  
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })

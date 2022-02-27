vim.g.mapleader = [[ ]]
local map = vim.keymap.set

-- better escape
map('i', 'kj', '<esc>')

-- I don't like pressing shift with my weak left pinky:(
map('n', '<leader>;', ':')

-- search through help tags and open in a new window
map('n', '<leader>h', '<cmd>lua require"telescope.builtin".help_tags()<cr>')

-- write file
map('n', '<leader>w', '<cmd>w<cr>')

-- format selected
map('v', 'gw', '<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>')

-- vim lsp code actions
map('n', '<leader>va', function ()
	require'telescope.builtin'.lsp_code_actions()
end)
map('n', '<leader>vr', '<cmd>lua vim.lsp.buf.rename()<cr>')

-- fuzzy find files
map("n", "<leader>ff", function ()
	require'telescope.builtin'.find_files()
end)

-- buffers
map('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<cr>')

-- search through commands
map('n', '<leader>c', '<cmd>lua require"telescope.builtin".commands()<cr>')

-- file tree
map('n', '<leader>ft', '<cmd>NvimTreeFocus<cr>')

-- file browser
map('n', '<leader>fb', function ()
	require'telescope'.extensions.file_browser.file_browser()
end)

-- toggle diagnostics window
map('n', '<leader>vd', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>', { silent = true })

-- coq recommended mappings
vim.g.coq_settings = { keymap = { recommended = false } }
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

-- comp
vim.api.nvim_set_keymap('i', '<CR>', '(pumvisible())?("\\<C-y>"):("\\<cr>")',  {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true, noremap = true})

-- quick
vim.api.nvim_set_keymap('n', '<LEADER>rc', ':e ~/.config/nvim/init.lua<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<LEADER><LEADER>', '<Esc>/<++><CR>:nohlsearch<CR>i<Del><Del><Del><Del>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', ':set hlsearch!<CR>', {noremap = true})

-- window
vim.api.nvim_set_keymap('n', '<up>', ':resize +3<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<down>', ':resize -3<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<left>', ':vertical resize-5<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<right>', ':vertical resize+5<CR>', {noremap = true})

-- change indent and select in v-mode
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- add blank line and move line
vim.api.nvim_set_keymap('n', '[e', ':<c-u>execute \'move -1-\'. v:count1<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', ']e', ':<c-u>execute \'move +\'. v:count1<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '[<LEADER>', ':<c-u>put! =repeat(nr2char(10), v:count1)<cr>\'[', {noremap = true})
vim.api.nvim_set_keymap('n', ']<LEADER>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', {noremap = true})

-- yank line
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

-- move the chosen zone
vim.api.nvim_set_keymap('v', 'J', ':m \'>+1<CR>gv=gv', {noremap = true})
vim.api.nvim_set_keymap('v', 'K', ':m \'<-2<CR>gv=gv', {noremap = true})

-- place the cursor in the middle
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true})
vim.api.nvim_set_keymap('n', 'J', 'mzJ\'z', {noremap = true})

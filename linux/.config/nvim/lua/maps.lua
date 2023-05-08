local keymap = vim.keymap

-- Change <Leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Move window
keymap.set('', '<C-h>', '<C-w>h')
keymap.set('', '<C-k>', '<C-w>k')
keymap.set('', '<C-j>', '<C-w>j')
keymap.set('', '<C-l>', '<C-w>l')

-- Resize window
keymap.set('n', '<Leader><left>', '<C-w><')
keymap.set('n', '<Leader><right>', '<C-w>>')
keymap.set('n', '<Leader><up>', '<C-w>+')
keymap.set('n', '<Leader><down>', '<C-w>-')

-- Disable highlight search
keymap.set('n', '<Leader>,', ':nohlsearch<CR>')

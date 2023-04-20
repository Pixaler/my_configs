local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map("n","<C-t>", ":NeoTreeShowToggle<CR>")
map("n","<C-y>", ":vs<CR>")
-- turn off search highlight
map("n",",<space>", ":nohlsearch<CR>")
-- Go to next or prev tab by H and L accordingly
map("n", "H", "gT")
map("n", "L", "gt")  
-- Change active window
map("n","<C-h>","<C-w>h")
map("n","<C-l>","<C-w>l")
map("n","<C-j>","<C-w>j")
map("n","<C-k>","<C-w>k")
-- map("n", "<Esc>","<C-/><C-n>")

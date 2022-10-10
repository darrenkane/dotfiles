local nnoremap = require("dkane.keymap").nnoremap
local inoremap = require("dkane.keymap").inoremap

nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-l>", "<C-w>l")
nnoremap("<leader>k", "<cmd>Ex<CR>")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-s>", "<cmd>w<CR>")
inoremap("<C-s>", "<Esc><cmd>w<CR>")


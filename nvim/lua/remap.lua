local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-l>", "<C-w>l")
nnoremap("<leader>k", "<cmd>Ex<CR>")
nnoremap("<leader>v", "<C-w>v<bar> :Ex <bar> :vertical resize 30<CR>")
nnoremap("<leader><CR>", ":so ~/.config/nvim/init.lua")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-s>", "<cmd>w<CR>")
nnoremap("<C-p>", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
inoremap("<C-s>", "<Esc><cmd>w<CR>")


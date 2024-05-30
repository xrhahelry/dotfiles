-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- close neovim
keymap.set("n", "<leader>q", "<cmd>qall<cr>", { desc = "Close Neovim" })
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- horizontal movement
keymap.set("n", "L", "$", { desc = "Move cursor to end of line" })
keymap.set("n", "H", "^", { desc = "Move cursor to start of line" })
keymap.set("v", "L", "$", { desc = "Move cursor to end of line" })
keymap.set("v", "H", "^", { desc = "Move cursor to start of line" })

-- vertical movement
keymap.set("n", "<C-i>", "<C-d>zz", { desc = "Half page down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
keymap.set("n", "n", "nzzzv", { desc = "Next item in search" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous item in search" })
keymap.set("n", "J", "mzJ`z", { desc = "Merge line below" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sk", "<cmd>close<CR>", { desc = "Close current split" })

-- buffer management
keymap.set("n", "<leader>bk", "<cmd>bdelete<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Go to previous tab" })

-- visual mode line moving
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

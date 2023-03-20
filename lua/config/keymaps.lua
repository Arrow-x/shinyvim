local opts = { silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Netrw Mappings
-- keymap("n", "<leader>e", ":Lex 20<cr>", opts)
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Quicklist nice navigation
keymap("n", "<Tab>", ":cnext<CR>zzzv", opts)
keymap("n", "<S-Tab>", ":cprevious<CR>zzzv", opts)

-- Move text up and Down
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)

-- Keeping it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Make Y behave like the other capital modifiers
keymap("n", "Y", "y$", opts)

-- Jumplist mutation
vim.cmd('nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . \'k\'')
vim.cmd('nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . \'j\'')

-- quickly fix formatting
-- keymap("n", "<leader>=", "gg<S-v>G=", opts)

-- Insert --
-- Press jk to step over one in insert mode
keymap("i", "jk", "<Esc>la", opts)

-- Move text up and down
keymap("i", "<C-j>", "<Esc>:m .+1<CR>==i", opts)
keymap("i", "<C-k>", "<Esc>:m .-2<CR>==i ", opts)

--Undo Break Points
keymap("i", ",", ",<C-g>u", opts)
keymap("i", ".", ".<C-g>u", opts)
keymap("i", ";", ";<C-g>u", opts)
keymap("i", "!", "!<C-g>u", opts)
keymap("i", "?", "?<C-g>u", opts)
keymap("i", "=", "=<C-g>u", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Better Paste
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<C-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv=gv", opts)

-- split manager
keymap("n", "<leader>\\", ":vsplit<CR>", { desc = "split vertically" })
keymap("n", "<leader>-", ":split<CR>", { desc = "split horizontally" })

-- terminal --
-- better terminal navigation
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<A-c>", [[<C-\><C-n>]], term_opts)

-- System Clipboard --
-- Copy to system clipboard
keymap("n", "<leader>y", '"+y', { desc = "Copy Action to system clipboard" })
keymap("n", "<leader>Y", '"+yg_', { desc = "Copy to system clipbaord the rest of the line" })
keymap("n", "<leader>yy", '"+yy', { desc = "Copy the current line to system clipboard" })

keymap("v", "<leader>y", '"+y', { desc = "Normal Mode Copy the selected text to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Visual mode Copy the selected text to system clipboard" })

-- Paste from system clipboard
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)

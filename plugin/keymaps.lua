local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<leader>q", ":confirm bd<cr>", { desc = "close buffer" })
keymap("n", "<leader>n", ":enew<cr>", { desc = "New File" })

keymap("n", "<C-s>", ":w!<cr>", { desc = "force save" })
keymap("n", "<C-q>", ":qa!<cr>", { desc = "force quite" })

-- Netrw Mappings
-- keymap("n", "<leader>e", ":Lex 20<cr>")

-- Remove Highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })

-- Resize with arrows
keymap("n", "<A-k>", ":resize +2<CR>")
keymap("n", "<A-j>", ":resize -2<CR>")
keymap("n", "<A-h>", ":vertical resize +2<CR>")
keymap("n", "<A-l>", ":vertical resize -2<CR>")

-- Quicklist nice navigation
keymap("n", "<C-n>", "<cmd>cnext<CR>zz")
keymap("n", "<C-p>", "<cmd>cprev<CR>zz")

-- Localtion list navigation
-- keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Move text up and Down
keymap("n", "<C-j>", ":m .+1<CR>==")
keymap("n", "<C-k>", ":m .-2<CR>==")
-- scroll through buffers
keymap("n", "<C-l>", ":bnext<CR>", { silent = true })
keymap("n", "<C-h>", ":bprevious<CR>", { silent = true })

-- Keeping it centered
keymap("n", "n", "nzzzv")
keymap("n", "N", "nzzzv")
keymap("n", "J", "mzJ`z")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Make Y behave like the other capital modifiers
keymap("n", "Y", "y$")

-- Add 5 up and down movments to the jump list
vim.cmd('nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . \'k\'')
vim.cmd('nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . \'j\'')

-- quickly fix formatting
-- keymap("n", "<leader>=", "gg<S-v>G=")

-- Insert --
-- Press jk to step over one in insert mode
keymap("i", "jk", "<Esc>la")

-- Move text up and down
keymap("i", "<C-j>", "<Esc>:m .+1<CR>==i")
keymap("i", "<C-k>", "<Esc>:m .-2 <CR>==i ")

--Undo Break Points
keymap("i", ",", ",<C-g>u")
keymap("i", ".", ".<C-g>u")
keymap("i", ";", ";<C-g>u")
keymap("i", "!", "!<C-g>u")
keymap("i", "?", "?<C-g>u")
keymap("i", "=", "=<C-g>u")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Better Paste
keymap("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
keymap("x", "<C-j>", ":move '>+1<CR>gv=gv")
keymap("x", "<C-k>", ":move '<-2<CR>gv=gv")

-- terminal --
-- better terminal navigation
-- keymap("t", "<M-h>", [[<C-\><C-N><C-w>h]], term_opts)
-- keymap("t", "<M-j>", [[<C-\><C-N><C-w>j]], term_opts)
-- keymap("t", "<M-k>", [[<C-\><C-N><C-w>k]], term_opts)
-- keymap("t", "<M-l>", [[<C-\><C-N><C-w>l]], term_opts)
keymap("t", "<A-q>", [[<C-\><C-n><C-w>k]], term_opts)
keymap("n", "<A-q>", "<C-w>j")

-- System Clipboard --
-- Copy to system clipboard
keymap("n", "<leader>y", '"+y', { desc = "Copy Action to system clipboard" })
keymap("n", "<leader>Y", '"+yg_', { desc = "Copy to system clipbaord the rest of the line" })
keymap("n", "<leader>yy", '"+yy', { desc = "Copy the current line to system clipboard" })

keymap("v", "<leader>y", '"+y', { desc = "Normal Mode Copy the selected text to system clipboard" })

-- Cut to system clipboard
keymap("n", "<leader>d", '"+d', { desc = "Cut to system clipboard" })
keymap("n", "<leader>D", '"+dg_', { desc = "Cut to system clipbaord the rest of the line" })
keymap("n", "<leader>dd", '"+dd', { desc = "Cut the current line to system clipboard" })

keymap("v", "<leader>d", '"+d', { desc = "Visual mode Copy the selected text to system clipboard" })

-- Paste from system clipboard
keymap("n", "<leader>p", '"+p')
keymap("v", "<leader>p", '"+p')
keymap("n", "<leader>P", '"*p')
keymap("v", "<leader>P", '"*p')

-- Disable annoying command history but bigger buffer
keymap("n", "Q", "<nop>")

keymap("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { desc = "make current file excutable" })
keymap("n", "<leader>mX", "<cmd>!chmod -x %<CR>", { desc = "make current file not excutable" })

keymap("n", "<leader>zz", "<cmd>Lazy<cr>", { desc = "show lazy" })
keymap("n", "<leader>zm", "<cmd>Mason<cr>", {desc = "Mason UI"})

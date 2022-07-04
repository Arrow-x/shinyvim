local opts = { silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function available(plugin)
	return pcall(require, plugin)
end

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
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true, desc = "No Highlight" })

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Buffer Managment Keymaps
keymap("n", "<leader>Q", ":%bd|e#<CR>", { silent = true, desc = "Close All Buffers" })
keymap("n", "<leader>q", "<cmd>Bdelete!<CR>", { silent = true, desc = "Close Buffer" })

keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)

-- Quicklist nice navigation
keymap("n", "<Tab>", ":cnext<CR>zzzv", opts)
keymap("n", "<S-Tab>", ":cprevious<CR>zzzv", opts)

keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

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
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<C-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv=gv", opts)

-- terminal --
-- better terminal navigation
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<A-c>", [[<C-\><C-n>]], term_opts)

-- System Clipboard --
-- Copy to system clipboard
keymap("n", "<leader>y", '"+y', { silent = true, desc = "Copy Action to system clipboard" })
keymap("n", "<leader>Y", '"+yg_', { silent = true, desc = "Copy to system clipbaord the rest of the line" })
keymap("n", "<leader>yy", '"+yy', { silent = true, desc = "Copy the current line to system clipboard" })

keymap("v", "<leader>y", '"+y', { silent = true, desc = "Normal Mode Copy the selected text to system clipboard" })
keymap("v", "<leader>y", '"+y', { silent = true, desc = "Visual mode Copy the selected text to system clipboard" })

-- Paste from system clipboard
keymap("n", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("v", "<leader>P", '"+P', opts)

-- Lsp keymaps
if available("lspconfig") then
	keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, desc = "go to Definition" })
	keymap("n", "<leader>lc", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, desc = "go to Declaration" })
	keymap(
		"n",
		"<leader>li",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		{ silent = true, desc = "go to Implementation" }
	)
	keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, desc = "go to references" })
	keymap("n", "<leader>lH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, desc = "Signature Help" })
	keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true, desc = "Rename" })
	keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true, desc = "Code Actions" })
	keymap(
		"n",
		"<leader>ln",
		'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
		{ silent = true, desc = "Go to next Diagnostics" }
	)
	keymap(
		"n",
		"<leader>lp",
		'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
		{ silent = true, desc = "Go to prev Diagnostics" }
	)
	keymap("n", "<leader>lh", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true, desc = "Hover Diagnostics" })
	keymap(
		"n",
		"<leader>lq",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		{ silent = true, desc = "Diagnostics to loacal list" }
	)
	keymap("n", "<leader>lI", "<cmd>LspInfo<cr>", { silent = true, desc = "Info" })
	keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", { silent = true, desc = "Format" })
end

-- Git keymaps
if available("gitsigns") then
	keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { silent = true, desc = "Next Hunk" })
	keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { silent = true, desc = "Prev Hunk" })
	keymap("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", { silent = true, desc = "Blame" })
	keymap(
		"n",
		"<leader>gp",
		"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
		{ silent = true, desc = "Preview Hunk" }
	)
	keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { silent = true, desc = "Reset Hunk" })
	keymap(
		"n",
		"<leader>gR",
		"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
		{ silent = true, desc = "Reset Buffer" }
	)
	keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { silent = true, desc = "Stage Hunk" })
	keymap(
		"n",
		"<leader>gu",
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		{ silent = true, desc = "Undo Stage Hunk" }
	)
	keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { silent = true, desc = "Diff" })
end

-- Debug keymap
if available("dap") then
	keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { silent = true, desc = "Continue" })
	keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true, desc = "Breakpoint" })
	keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { silent = true, desc = "Step Over" })
	keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { silent = true, desc = "Step Into" })
	keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", { silent = true, desc = "inspect REPL" })
end

-- ToggleTerm keymap
if available("toggleterm") then
	keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { silent = true, desc = "Lazygit" })
	keymap("n", "<leader>`t", "<cmd>lua _HTOP_TOGGLE()<cr>", { silent = true, desc = "Htop" })
	keymap("n", "<leader>`p", "<cmd>lua _PYTHON_TOGGLE()<cr>", { silent = true, desc = "Python" })
	keymap("n", "<leader>``", "<cmd>ToggleTerm direction=float<cr>", { silent = true, desc = "Float" })
	keymap(
		"n",
		"<leader>`h",
		"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
		{ silent = true, desc = "Horizontal" }
	)
end
-- Telescope
if available("telescope") then
	keymap("n", "<leader>ff", function()
		local fopts = { hidden = true } -- define here if you want to define something
		local ok = pcall(require("telescope.builtin").git_files)
		if not ok then
			require("telescope.builtin").find_files(fopts)
		end
	end, { silent = true, desc = "Find Files" })
	keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Show Buffers" })
	keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { silent = true, desc = "Colorscheme" })
	keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Find Help" })
	keymap("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", { silent = true, desc = "Man Pages" })
	keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true, desc = "Open Recent File" })
	keymap("n", "<leader>fR", "<cmd>Telescope registers<cr>", { silent = true, desc = "Registers" })
	keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { silent = true, desc = "Keymaps" })
	keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", { silent = true, desc = "Commands" })
	keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Find word" })
	keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", { silent = true, desc = "Projects" })

	keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", { silent = true, desc = "Open changed file" })
	keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { silent = true, desc = "Checkout branch" })
	keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { silent = true, desc = "Checkout commit" })
	keymap(
		"n",
		"<leader>b",
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		{ silent = true, desc = "Buffers" }
	)
end

-- Packer Keympas
if available("Packer") then
	keymap("n", "<leader>Pc", "<cmd>PackerCompile<cr>", { silent = true, desc = "Compile" })
	keymap("n", "<leader>Pi", "<cmd>PackerInstall<cr>", { silent = true, desc = "Install" })
	keymap("n", "<leader>Ps", "<cmd>PackerSync<cr>", { silent = true, desc = "Sync" })
	keymap("n", "<leader>PS", "<cmd>PackerStatus<cr>", { silent = true, desc = "Status" })
	keymap("n", "<leader>Pu", "<cmd>PackerUpdate<cr>", { silent = true, desc = "Update" })
end

-- Alpha
if available("alpha") then
	keymap("n", "<leader>m", "<cmd>Alpha<cr>", { silent = true, desc = "Alpha" })
end

-- Nvim Tree Keymaps
if available("nvim-tree") then
	keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, desc = "Explorer" })
end

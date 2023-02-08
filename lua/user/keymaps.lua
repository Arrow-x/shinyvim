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

-- Better Paste
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
keymap("v", "<leader>p", '"+p', opts)

-- Lsp keymaps
if pcall(require, "lspconfig") then
	keymap("n", "<leader>ld", function()
		vim.lsp.buf.definition()
	end, { silent = true, desc = "go to Definition" })
	keymap("n", "<leader>lc", function()
		vim.lsp.buf.declaration()
	end, { silent = true, desc = "go to Declaration" })
	keymap("n", "<leader>li", function()
		vim.lsp.buf.implementation()
	end, { silent = true, desc = "go to Implementation" })
	keymap("n", "<leader>lR", function()
		vim.lsp.buf.references()
	end, { silent = true, desc = "go to references" })
	keymap("n", "<leader>lH", function()
		vim.lsp.buf.signature_help()
	end, { silent = true, desc = "Signature Help" })
	keymap("n", "<leader>lr", function()
		vim.lsp.buf.rename()
	end, { silent = true, desc = "Rename" })
	keymap("n", "<leader>la", function()
		vim.lsp.buf.code_action()
	end, { silent = true, desc = "Code Actions" })
	keymap("n", "<leader>ln", function()
		vim.diagnostic.goto_next({ border = "rounded" })
	end, { silent = true, desc = "Go to next Diagnostics" })
	keymap("n", "<leader>lp", function()
		vim.diagnostic.goto_prev({ border = "rounded" })
	end, { silent = true, desc = "Go to prev Diagnostics" })
	keymap("n", "<leader>lh", function()
		vim.diagnostic.open_float()
	end, { silent = true, desc = "Hover Diagnostics" })
	keymap("n", "<leader>lq", function()
		vim.diagnostic.setloclist()
	end, { silent = true, desc = "Diagnostics to loacal list" })
	keymap("n", "<leader>lI", function()
		vim.cmd("LspInfo")
	end, { silent = true, desc = "Info" })
	keymap("n", "<leader>lf", function()
		vim.lsp.buf.formatting()
	end, { silent = true, desc = "Format" })
end

-- Git keymaps
local status_ok, gitsigns = pcall(require, "gitsigns")
if status_ok then
	keymap("n", "<leader>gj", function()
		gitsigns.next_hunk()
	end, { silent = true, desc = "Next Hunk" })
	keymap("n", "<leader>gk", function()
		gitsigns.prev_hunk()
	end, { silent = true, desc = "Prev Hunk" })
	keymap("n", "<leader>gl", function()
		gitsigns.blame_line()
	end, { silent = true, desc = "Blame" })
	keymap("n", "<leader>gp", function()
		gitsigns.preview_hunk()
	end, { silent = true, desc = "Preview Hunk" })
	keymap("n", "<leader>gr", function()
		gitsigns.reset_hunk()
	end, { silent = true, desc = "Reset Hunk" })
	keymap("n", "<leader>gR", function()
		gitsigns.reset_buffer()
	end, { silent = true, desc = "Reset Buffer" })
	keymap("n", "<leader>gs", function()
		gitsigns.stage_hunk()
	end, { silent = true, desc = "Stage Hunk" })
	keymap("n", "<leader>gu", function()
		gitsigns.undo_stage_hunk()
	end, { silent = true, desc = "Undo Stage Hunk" })
	keymap("n", "<leader>gd", function()
		vim.cmd("Gitsigns diffthis HEAD end")
	end, { silent = true, desc = "Show this file's Diff" })
end

-- Debug keymap
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
	keymap("n", "<leader>dc", function()
		dap.continue()
	end, { silent = true, desc = "Continue" })
	keymap("n", "<leader>db", function()
		dap.toggle_breakpoint()
	end, { silent = true, desc = "Breakpoint" })
	keymap("n", "<leader>do", function()
		dap.step_over()
	end, { silent = true, desc = "Step Over" })
	keymap("n", "<leader>di", function()
		dap.step_into()
	end, { silent = true, desc = "Step Into" })
	keymap("n", "<leader>dr", function()
		dap.repl.open()
	end, { silent = true, desc = "inspect REPL" })
end

-- ToggleTerm keymap
if available("toggleterm") then
	keymap("n", "<leader>gg", function()
		_LAZYGIT_TOGGLE()
	end, { silent = true, desc = "Lazygit" })
	keymap("n", "<leader>`t", function()
		_HTOP_TOGGLE()
	end, { silent = true, desc = "Htop" })
	keymap("n", "<leader>`p", function()
		_PYTHON_TOGGLE()
	end, { silent = true, desc = "Python" })
	keymap("n", "<leader>``", function()
		vim.cmd("ToggleTerm direction=float")
	end, { silent = true, desc = "Float" })
	keymap("n", "<leader>`h", function()
		vim.cmd("ToggleTerm size=10 direction=horizontal")
	end, { silent = true, desc = "Horizontal" })
end
-- Telescope
local tel_status_ok, telescope = pcall(require, "telescope.builtin")
if tel_status_ok then
	keymap("n", "<leader>ff", function()
		local fopts = { hidden = true } -- define here if you want to define something
		local ok = pcall(telescope.git_files)
		if not ok then
			telescope.find_files(fopts)
		end
	end, { silent = true, desc = "Find Files" })
	keymap("n", "<leader>fb", function()
		telescope.buffers()
	end, { silent = true, desc = "Show Buffers" })
	keymap("n", "<leader>fc", function()
		telescope.colorscheme()
	end, { silent = true, desc = "Colorscheme" })
	keymap("n", "<leader>fh", function()
		telescope.help_tags()
	end, { silent = true, desc = "Find Help" })
	keymap("n", "<leader>fM", function()
		telescope.man_pages()
	end, { silent = true, desc = "Man Pages" })
	keymap("n", "<leader>fr", function()
		telescope.oldfiles()
	end, { silent = true, desc = "Open Recent File" })
	keymap("n", "<leader>fR", function()
		telescope.registers()
	end, { silent = true, desc = "Registers" })
	keymap("n", "<leader>fk", function()
		telescope.keymaps()
	end, { silent = true, desc = "Keymaps" })
	keymap("n", "<leader>fC", function()
		telescope.commands()
	end, { silent = true, desc = "Commands" })
	keymap("n", "<leader>fg", function()
		telescope.live_grep()
	end, { silent = true, desc = "Find word" })
	keymap("n", "<leader>fp", function()
		telescope.projects()
	end, { silent = true, desc = "Projects" })

	keymap("n", "<leader>b", function()
		telescope.buffers(require("telescope.themes").get_dropdown({ previewer = false }))
	end, { silent = true, desc = "Buffers" })
end

-- Packer Keympas
if available("packer") then
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

if available("neo-tree") then
	keymap("n", "<leader>e", "<cmd>NeoTreeRevealToggle<cr>", { silent = true, desc = "Explorer" })
end

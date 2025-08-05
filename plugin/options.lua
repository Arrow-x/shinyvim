local O = vim.opt
local G = vim.g

-- O.clipboard = "unnamedplus" --uses all the + register for clipboard
O.cmdheight = 1 -- more space in the neovim command line for displaying messages
O.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- O.conceallevel = 0 -- so that `` is visible in markdown files
O.fileencoding = "utf-8" -- the encoding written to a file
-- O.mouse = "a" -- allow the mouse to be used in neovim
O.showmode = false
O.pumheight = 14 -- pop up menu height
O.showtabline = 2 -- always show tabs
O.smartcase = true -- smart case
O.splitbelow = true -- force all horizontal splits to go below current window
O.splitright = true -- force all vertical splits to go to the right of current window
O.hidden = true -- buffers are kept open in the background
O.errorbells = false
O.termguicolors = true -- set term gui colors (most terminals support this)
O.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
O.undofile = true -- enable persistent undo
O.backup = false -- creates a backup file
O.swapfile = false -- creates a swapfile
O.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
O.updatetime = 300 -- faster completion (4000ms default)
O.shiftwidth = 4 -- the number of spaces inserted for each indentation
O.cursorline = false -- highlight the current line
O.number = true -- set numbered lines
O.relativenumber = true -- set relative numbered lines
O.numberwidth = 2 -- set number column width to 2 {default 4}
O.signcolumn = "yes:2" -- always show the sign column, otherwise it would shift the text each time
O.wrap = false -- display lines as one long line
O.scrolloff = 8 -- is one of my fav
O.sidescrolloff = 8
O.autoread = true
-- O.guifont = "monospace:h17"               -- the font used in graphical neovim applications
O.foldlevel = 8
O.title = true

O.hlsearch = true -- highlight all matches on previous search pattern
O.incsearch = true
O.ignorecase = false -- ignore case in search patterns
O.inccommand = "split" -- interactive commands (like grep and sed)

O.expandtab = false -- convert tabs to spaces
O.tabstop = 4 -- insert 4 spaces for a tab
O.smartindent = false -- make indenting smarter again
O.cindent = true

O.shortmess:append("c")
O.whichwrap:append("<,>,[,],h,l")
O.iskeyword:append("-")
-- O.path:append("**")

-- Folds
O.foldmethod = "indent"
O.foldexpr = "v:lua.shinyvim.foldtext()"

O.winborder = "rounded"

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

G.highlighturl_enabled = true -- highlight URLs by default

G.zipPlugin = false -- disable zip
G.load_black = false -- disable black
G.loaded_2html_plugin = true -- disable 2html
G.loaded_getscript = true -- disable getscript
G.loaded_getscriptPlugin = true -- disable getscript
G.loaded_gzip = true -- disable gzip
G.loaded_logipat = true -- disable logipat
G.loaded_matchit = true -- disable matchit
G.loaded_remote_plugins = true -- disable remote plugins
G.loaded_tar = true -- disable tar
G.loaded_tarPlugin = true -- disable tar
G.loaded_zip = true -- disable zip
G.loaded_zipPlugin = true -- disable zip
G.loaded_vimball = true -- disable vimball
G.loaded_vimballPlugin = true -- disable vimball

G.netrw_banner = 0
G.netrw_brows_split = 4
G.netrw_liststyle = 3
G.markdown_recommended_style = 0

if vim.g.neovide then
	vim.g.neovide_opacity = 0.9
	-- vim.g.neovide_floating_shadow = false
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	vim.keymap.set("n", "<C-S-S>", ":w<CR>") -- Save
	vim.keymap.set("v", "<C-S-C>", '"+y') -- Copy
	vim.keymap.set("n", "<C-S-V>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<C-S-V>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<C-S-V>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-S-V>", '<ESC>l"+Pli') -- Paste insert mode
	-- Allow clipboard copy paste in neovim
	vim.api.nvim_set_keymap("", "<C-S-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
end

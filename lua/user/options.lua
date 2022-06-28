-- :help options
O = vim.opt

O.clipboard = ""
O.cmdheight = 1 -- more space in the neovim command line for displaying messages
O.completeopt = { "menuone", "noselect" } -- mostly just for cmp
O.conceallevel = 0 -- so that `` is visible in markdown files
O.fileencoding = "utf-8" -- the encoding written to a file
-- o.mouse = "a"                             -- allow the mouse to be used in neovim
O.showmode = false
O.pumheight = 10 -- pop up menu height
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
O.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
O.wrap = false -- display lines as one long line
O.scrolloff = 8 -- is one of my fav
O.sidescrolloff = 8
-- o.guifont = "monospace:h17"               -- the font used in graphical neovim applications

O.hlsearch = true -- highlight all matches on previous search pattern
O.incsearch = true
O.ignorecase = false -- ignore case in search patterns
vim.cmd("highlight Normal guibg=none")

O.smartindent = true -- make indenting smarter again
O.expandtab = false -- convert tabs to spaces
O.tabstop = 4 -- insert 4 spaces for a tab

O.shortmess:append("c")
-- O.whichwrap:append("<,>,[,],h,l")
-- O.iskeyword:append("-")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
-- vim.cmd("let g:did_load_filetypes = 0")
-- vim.cmd("let g:do_filetype_lua = 1")

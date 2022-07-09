local O = vim.opt
local G = vim.g

-- O.clipboard = "unnamedplus" --uses all the + register for clipboard
O.cmdheight = 1 -- more space in the neovim command line for displaying messages
O.completeopt = { "menuone", "noselect" } -- mostly just for cmp
O.conceallevel = 0 -- so that `` is visible in markdown files
O.fileencoding = "utf-8" -- the encoding written to a file
-- O.mouse = "a"                             -- allow the mouse to be used in neovim
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
-- O.guifont = "monospace:h17"               -- the font used in graphical neovim applications

O.hlsearch = true -- highlight all matches on previous search pattern
O.incsearch = true
O.ignorecase = false -- ignore case in search patterns

O.smartindent = true -- make indenting smarter again
O.expandtab = false -- convert tabs to spaces
O.tabstop = 4 -- insert 4 spaces for a tab

O.shortmess:append("c")
O.whichwrap:append("<,>,[,],h,l")
O.iskeyword:append("-")

G.do_filetype_lua = 1 -- use filetype.lua
G.did_load_filetypes = 0 -- don't use filetype.vim
G.highlighturl_enabled = true -- highlight URLs by default
G.zipPlugin = false -- disable zip
G.load_black = false -- disable black
G.loaded_2html_plugin = true -- disable 2html
G.loaded_getscript = true -- disable getscript
G.loaded_getscriptPlugin = true -- disable getscript
G.loaded_gzip = true -- disable gzip
G.loaded_logipat = true -- disable logipat
G.loaded_matchit = true -- disable matchit
G.loaded_netrwFileHandlers = true -- disable netrw
G.loaded_netrwPlugin = true -- disable netrw
G.loaded_netrwSettngs = true -- disable netrw
G.loaded_remote_plugins = true -- disable remote plugins
G.loaded_tar = true -- disable tar
G.loaded_tarPlugin = true -- disable tar
G.loaded_zip = true -- disable zip
G.loaded_zipPlugin = true -- disable zip
G.loaded_vimball = true -- disable vimball
G.loaded_vimballPlugin = true -- disable vimball

-- vim.cmd("highlight Normal guibg=none")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


local gr = {
	general_settings = augroup("general_settings", { clear = true }),
	writing = augroup("writing", { clear = true }),
	exe_code = augroup("exe_code", { clear = true }),
	term = augroup("exe_code", { clear = true }),
	ui = augroup("exe_code", { clear = true }),
}

autocmd("TextYankPost", {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		require("vim.hl").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

autocmd("FileType", {
	pattern = "qf",
	group = gr.general_settings,
	callback = function()
		vim.o.buflisted = false
	end,
})

autocmd({ "BufWinEnter" }, {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

autocmd("FileType", {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "vim", "notify", "snipe-menu" },
	group = gr.general_settings,
	callback = function()
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { silent = true, buffer = true })
	end,
})

autocmd("FileType", {
	pattern = { "gitcommit", "mail", "markdown", "vimwiki" },
	group = gr.writing,
	callback = function()
		vim.opt.conceallevel = 2
		vim.wo.spell = true
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.list = false
		vim.wo.virtualedit = ""
		vim.opt.display:append("lastline")
		vim.opt.number = false
		vim.opt.relativenumber = false

		vim.keymap.set("n", "k", "gk", { silent = true, buffer = true })
		vim.keymap.set("n", "j", "gj", { silent = true, buffer = true })
		vim.keymap.set("n", "^", "g<Home>", { silent = true, buffer = true })
		vim.keymap.set("n", "$", "g<End>", { silent = true, buffer = true })

		vim.keymap.set("i", "<Up>", "<C-o>gk", { silent = true, buffer = true })
		vim.keymap.set("i", "<Down>", "<C-o>gj", { silent = true, buffer = true })
		vim.keymap.set("i", "<Home>", "<C-o>g<Home>", { silent = true, buffer = true })
		vim.keymap.set("i", "<End>", "<C-o>g<End>", { silent = true, buffer = true })
	end,
})

autocmd("BufReadPre", {
	pattern = { "/home/arrowx/Sources/Vault/**" },
	group = gr.writing,
	callback = function()
		vim.o.background = "light"
		vim.cmd([[colorscheme gruvbox]])
	end,
})

autocmd("VimResized", {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

autocmd("FileType", {
	pattern = "python",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set("n", "<C-F5>", ":sp<CR> :term python3 %<CR> :startinsert<CR>", {
			buffer = true,
			noremap = true,
			silent = true,
			desc = "Executer the current buffer",
		})
	end,
})

autocmd("FileType", {
	pattern = "rust",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set("n", "<C-F5>", ":sp<CR> :term cargo run %<CR> :startinsert<CR>", {
			buffer = true,
			noremap = true,
			silent = true,
			desc = "Executer the current buffer",
		})
	end,
})

autocmd("FileType", {
	pattern = "cs",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set(
			"n",
			"<C-F5>",
			":sp<CR> :term dotnet run<CR> :startinsert<CR>",
			{ buffer = true, noremap = true, silent = true, desc = "Executer the current buffer" }
		)
	end,
})
autocmd("FileType", {
	pattern = "cs",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set(
			"n",
			"<C-F7>",
			":sp<CR> :term dotnet build<CR> :startinsert<CR>",
			{ buffer = true, noremap = true, silent = true, desc = "Executer the current buffer" }
		)
	end,
})

autocmd("FileType", {
	pattern = "go",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set("n", "<C-F5>", ":vsp<CR> :term go run %<CR> :startinsert<CR>", {
			buffer = true,
			noremap = true,
			silent = true,
			desc = "Executer the current buffer",
		})
	end,
})

autocmd("FileType", {
	pattern = { "bash", "sh" },
	group = gr.exe_code,
	callback = function()
		vim.keymap.set("n", "<C-F5>", ":sp<CR> :term sh %<CR> :startinsert<CR>", {
			buffer = true,
			noremap = true,
			silent = true,
			desc = "Executer the current buffer",
		})
	end,
})

autocmd("TermOpen", {
	group = gr.term,
	desc = "Disable foldcolumn and signcolumn for terinals",
	callback = function()
		vim.opt.foldcolumn = "0"
		vim.opt.signcolumn = "no"
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

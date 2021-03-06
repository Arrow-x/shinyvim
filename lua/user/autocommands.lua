local gr = {
	general_settings = vim.api.nvim_create_augroup("general_settings", { clear = true }),
	writing = vim.api.nvim_create_augroup("writing", { clear = true }),
	alpha = vim.api.nvim_create_augroup("alpha", { clear = true }),
	exe_code = vim.api.nvim_create_augroup("exe_code", { clear = true }),
}

local acmd = vim.api.nvim_create_autocmd

acmd("TextYankPost", {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

acmd("FileType", {
	pattern = "qf",
	group = gr.general_settings,
	callback = function()
		vim.o.buflisted = false
	end,
})

acmd({ "BufWinEnter" }, {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

acmd("FileType", {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "vim" },
	group = gr.general_settings,
	callback = function()
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { silent = true, buffer = true })
	end,
})

acmd("BufWritePre", {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		vim.lsp.buf.formatting_sync()
	end,
})

acmd("FileType", {
	pattern = { "gitcommit", "mail", "markdown" },
	group = gr.writing,
	callback = function()
		vim.opt.conceallevel = 2
		vim.wo.spell = true
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.list = false
		vim.wo.virtualedit = ""
		vim.opt.display:append("lastline")

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

acmd("FileType", {
	pattern = "vimwiki",
	group = gr.writing,
	callback = function()
		vim.cmd("colorscheme gruvbox")
		vim.cmd("set background=light")
		-- vim.cmd("TZAtaraxisOn")
	end,
})

acmd("User", {
	pattern = "AlphaReady",
	group = gr.alpha,
	callback = function()
		vim.cmd("set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
	end,
})

acmd("VimResized", {
	pattern = "*",
	group = gr.general_settings,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

acmd("FileType", {
	pattern = "python",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set(
			"n",
			"<F5>",
			":sp<CR> :term python3 %<CR> :startinsert<CR>",
			{ buffer = true, noremap = true, silent = true },
			{ desc = "Executer the current buffer" }
		)
	end,
})

acmd("FileType", {
	pattern = "go",
	group = gr.exe_code,
	callback = function()
		vim.keymap.set(
			"n",
			"<F5>",
			":vsp<CR> :term go run %<CR> :startinsert<CR>",
			{ buffer = true, noremap = true, silent = true },
			{ desc = "Executer the current buffer" }
		)
	end,
})
acmd("FileType", {
	pattern = { "bash", "sh" },
	group = gr.exe_code,
	callback = function()
		vim.keymap.set(
			"n",
			"<F5>",
			":sp<CR> :term sh %<CR> :startinsert<CR>",
			{ buffer = true, noremap = true, silent = true },
			{ desc = "Executer the current buffer" }
		)
	end,
})

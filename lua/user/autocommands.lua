-- local groups = {
-- 	general_settings = vim.api.nvim_create_augroup("general_settings", { clear = true }),
-- 	git = vim.api.nvim_create_augroup("git", { clear = true }),
-- 	markdown = vim.api.nvim_create_augroup("markdown", { clear = true }),
-- 	mail = vim.api.nvim_create_augroup("mail", { clear = true }),
-- 	auto_resize = vim.api.nvim_create_augroup("auto_resize", { clear = true }),
-- 	alpha = vim.api.nvim_create_augroup("alpha", { clear = true }),
-- 	lsp = vim.api.nvim_create_augroup("lsp", { clear = true }),
-- 	exe_code = vim.api.nvim_create_augroup("exe_code", { clear = true }),
-- }

local acmd = vim.api.nvim_create_autocmd

acmd("TextYankPost", {
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

acmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.cmd("set nobuflisted")
	end,
})

acmd({ "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		-- vim.opt.formatoptions:remove("cro")
		vim.cmd("set formatoptions-=cro")
	end,
})

acmd("FileType", {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { silent = true, buffer = true })
	end,
})

acmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.formatting_sync()
	end,
})

acmd("FileType", {
	pattern = { "gitcommit", "mail", "markdown" },
	callback = function()
		vim.wo.spell = true
		vim.cmd("set wrap linebreak")
	end,
})

acmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.cmd("set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
	end,
})
acmd("VimResized", {
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

acmd("FileType", {
	pattern = "python",
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
	pattern = "bash, sh",
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

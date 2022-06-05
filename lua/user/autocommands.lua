local groups = {
	general_settings = vim.api.nvim_create_augroup("general_settings", { clear = true }),
	git = vim.api.nvim_create_augroup("git", { clear = true }),
	markdown = vim.api.nvim_create_augroup("markdown", { clear = true }),
	mail = vim.api.nvim_create_augroup("mail", { clear = true }),
	auto_resize = vim.api.nvim_create_augroup("auto_resize", { clear = true }),
	alpha = vim.api.nvim_create_augroup("alpha", { clear = true }),
	lsp = vim.api.nvim_create_augroup("lsp", { clear = true }),
	exe_code = vim.api.nvim_create_augroup("exe_code", { clear = true }),
}

local c_autocmd = vim.api.nvim_create_autocmd

c_autocmd("TextYankPost", {
	group = groups.general_settings,
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

c_autocmd("FileType", {
	group = groups.general_settings,
	pattern = "qf",
	callback = function()
		vim.cmd("set nobuflisted")
	end,
})

c_autocmd({ "BufWinEnter" }, {
	group = groups.general_settings,
	pattern = "*",
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

c_autocmd("FileType", {
	group = groups.general_settings,
	pattern = "qf,help,lspinfo",
	callback = function()
		vim.keymap.set("n", "q", function()
			vim.cmd("close")
		end, { silent = true, buffer = true })
	end,
})

c_autocmd("BufWritePre", {
	group = groups.lsp,
	pattern = "*",
	callback = function()
		vim.lsp.buf.formatting_sync()
	end,
})

c_autocmd("FileType", {
	group = groups.git,
	pattern = "gitcommit",
	callback = function()
		vim.wo.spell = true
		vim.wo.wrap = true
	end,
})

c_autocmd("FileType", {
	group = groups.mail,
	pattern = "mail",
	callback = function()
		vim.wo.spell = true
		vim.wo.wrap = true
	end,
})

c_autocmd("FileType", {
	group = groups.markdown,
	pattern = "markdown",
	callback = function()
		vim.wo.spell = true
		vim.wo.wrap = true
	end,
})
c_autocmd("User", {
	group = groups.alpha,
	pattern = "AlphaReady",
	callback = function()
		vim.cmd("set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
	end,
})
c_autocmd("VimResized", {
	group = groups.auto_resize,
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

c_autocmd("FileType", {
	group = groups.exe_code,
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

c_autocmd("FileType", {
	group = groups.exe_code,
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

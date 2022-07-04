local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- local function lsp_keymaps(bufnr)
-- 	local opts = { noremap = true, silent = true }
-- 	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- 	vim.keymap.set("n", "c", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	vim.keymap.set("n", "i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	vim.keymap.set("n", "r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- 	vim.keymap.set("n", "H", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- 	vim.keymap.set("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- 	vim.keymap.set("n", "a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- 	vim.keymap.set("n", "n", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
-- 	vim.keymap.set("n", "p", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
-- 	vim.keymap.set("n", "h", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- 	vim.keymap.set("n", "q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
-- 	vim.keymap.set("n", "I", "<cmd>LspInfo<cr>", opts)
-- 	vim.keymap.set("n", "f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
-- 	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
-- end

M.on_attach = function(client)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	-- lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end
return M

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local insert = table.insert
local tbl_deep_extend = vim.tbl_deep_extend
local handlers = require("user.lsp.handlers")
local on_attach = handlers.on_attach

-- Lsp servers that are not installed by mason
local servers = {
	"gdscript",
	-- "ltex",
}

local status_ok, mason = pcall(require, "mason")
if status_ok then
	mason.setup()
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if status_ok then
	mason_lspconfig.setup()
	for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		insert(servers, server)
	end
end

for _, server in ipairs(servers) do
	local opts = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
		capabilities = tbl_deep_extend("force", handlers.capabilities, lspconfig[server].capabilities or {}),
	}

	local present, custom_settings = pcall(require, "user.lsp.settings." .. server)
	if present then
		opts = tbl_deep_extend("force", custom_settings, opts)
	end
	lspconfig[server].setup(opts)
end

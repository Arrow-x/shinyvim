local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local insert = table.insert
local tbl_deep_extend = vim.tbl_deep_extend
local handlers = require("user.lsp.handlers")
local on_attach = handlers.on_attach

-- Lsp servers that are not installed by lsp_installer
local servers = {
	"gdscript",
	-- "ltex",
}

local installer_avail, lsp_installer = pcall(require, "nvim-lsp-installer")
if installer_avail then
	lsp_installer.setup()
	for _, server in ipairs(lsp_installer.get_installed_servers()) do
		insert(servers, server.name)
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

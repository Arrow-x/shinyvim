local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local handlers = require("user.lsp.handlers")
local on_attachs = handlers.on_attach

local opts = {
	on_attach = function(client, bufnr)
		on_attachs(client, bufnr)
	end,
	capabilities = handlers.capabilities,
}

lspconfig.gdscript.setup(opts)

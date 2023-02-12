local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neotree.setup({
	-- close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	default_component_configs = {
		diagnostics = {
			symbols = {
				hint = "",
				info = "",
				warn = "",
				error = "",
			},
			highlights = {
				hint = "DiagnosticSignHint",
				info = "DiagnosticSignInfo",
				warn = "DiagnosticSignWarn",
				error = "DiagnosticSignError",
			},
		},
	},
	window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
		-- possible options. These can also be functions that return these options.
		width = 30, -- applies to left and right positions
		mappings = {
			["l"] = "open",
		},
	},
})

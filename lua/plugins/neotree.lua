return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,
	opts = {
		-- close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		filesystem = {
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				visible = true,
				never_show = {
					".git",
				},
			},
		},
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
		window = {
			-- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
			-- possible options. These can also be functions that return these options.
			width = 30, -- applies to left and right positions
			mappings = {
				["l"] = "open",
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					require("neo-tree").close_all()
				end,
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>NeoTreeRevealToggle<cr>", desc = "Explorer" },
	},
}

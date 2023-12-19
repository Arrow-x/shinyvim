return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 20, -- Maximum number of lines to show for a single context
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	},
	keys = {
		{
			"<leader>mt",
			function()
				local tsc = require("treesitter-context")
				tsc.toggle()
				shinyvim.ts_context_toggle = not shinyvim.ts_context_toggle
				if shinyvim.ts_context_toggle == true then
					vim.notify("Treesitter Context is Turned On")
				else
					vim.notify("Treesitter Context is Turned Off")
				end
			end,
			desc = "Toggle Treesitter Context",
		},
	},
}

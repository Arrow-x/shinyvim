return {
	"nvim-lualine/lualine.nvim",
	event = { "VeryLazy" },
	config = function()
		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "hint" },
			symbols = { error = " ", warn = " ", hint = "󰌵 " },
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local branch = {
			"branch",
			icons_enabled = true,
			icon = "",
		}

		local location = {
			"location",
			padding = 0,
		}

		local filename = {
			"filename",
			path = 0,
		}

		-- cool function for progress
		local progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end

		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				always_divide_middle = true,
				theme = "auto",
				component_separators = { "" },
				section_separators = { "" },
				disabled_filetypes = { "alpha", "dashboard", "toggleterm", "oil" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { branch },
				lualine_c = { diff, filename, diagnostics },
				lualine_y = { location },
				lualine_z = { progress },
			},
			tabline = {},
			extensions = {},
		})
	end,
}

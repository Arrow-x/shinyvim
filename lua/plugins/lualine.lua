return {
	"nvim-lualine/lualine.nvim",
	event = { "VeryLazy" },
	config = function()
		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " },
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
				disabled_filetypes = { "alpha", "dashboard" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { diff, filename, "diagnostics" },
				lualine_y = { "location" },
				lualine_z = { progress },
			},
			tabline = {},
			extensions = { "oil", "lazy", "toggleterm", "mason", "trouble", "nvim-dap-ui" },
		})
	end,
}

return {
	"Pocco81/true-zen.nvim",
	cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
	config = function()
		require("true-zen").setup({
			integrations = {
				lualine = true,
			},
		})
	end,
	keys = { {
		"<leader>za",
		function()
			vim.cmd("TZAtaraxis")
		end,
		desc = "Switch to TZAtaraxis",
	} },
}

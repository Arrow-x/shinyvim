return {
	"Pocco81/true-zen.nvim",
	commit = "1488013",
	cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
	config = function()
		require("true-zen").setup({
			integrations = {
				lualine = true,
			},
		})
	end,
}

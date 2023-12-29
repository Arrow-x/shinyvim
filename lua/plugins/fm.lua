return {
	"is0n/fm-nvim",
	keys = {
		{
			"<leader>e",
			function()
				require("fm-nvim").Lf(vim.fn.expand("%:p"))
			end,
		},
	},
}

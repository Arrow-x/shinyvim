return {
	"tpope/vim-dispatch",
	cmd = { "Dispatch", "FocusDispatch", "Make" },
	keys = {
		{
			"<leader>mm",
			function()
				vim.cmd("Make")
			end,
			desc = "Run :Make",
		},
	},
}

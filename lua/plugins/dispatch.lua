return {
	"tpope/vim-dispatch",
	lazy = false,
	keys = {
		{
			"<leader>dd",
			"<cmd>Dispatch<CR>",
			desc = "Dispatch",
		},
		{
			"<leader>dm",
			"<cmd>Make<CR>",
			desc = "run :make async",
		},
		{
			"<leader>do",
			"<cmd>Copen<CR>",
			desc = "Open the pane where Dispatch made it stuff",
		},
	},
}

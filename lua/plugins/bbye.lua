return {
	"moll/vim-bbye",
	keys = {
		{ "<leader>Q", ":%bd|e#<CR>", desc = "Close All Buffers" },
		{ "<leader>q", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
	},
}

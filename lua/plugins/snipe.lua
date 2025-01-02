return {
	"leath-dub/snipe.nvim",
	opts = {
		hints = {
			dictionary = "asdfghjkl;",
		},
	},
	keys = {
		{
			"<leader>s",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
}

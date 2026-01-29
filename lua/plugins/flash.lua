return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = true,
			},
		},
		search = {
			exclude = {
				"blink-cmp-menu",
			},
		},
	},
	keys = {
		{
			"R",
			mode = { "o" },
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
	},
}

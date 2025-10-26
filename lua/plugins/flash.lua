return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = true,
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

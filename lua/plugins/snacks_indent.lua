return {
	{
		"folke/snacks.nvim",
		event = { "Bufadd" },
		---@type snacks.Config
		opts = {
			indent = {},
		},
		keys = {
			{
				"<leader>q",
				function()
					Snacks.bufdelete()
				end,
				desc = "Close Buffer",
			},
			{
				"<leader>Q",
				function()
					Snacks.bufdelete.all()
				end,
				desc = "Close All Buffers",
			},
		},
	},
}

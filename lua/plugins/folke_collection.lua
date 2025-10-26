return {
	{
		"folke/snacks.nvim",
		event = { "Bufadd" },
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
	{
		"folke/snacks.nvim",
		event = { "Bufadd" },
		opts = {
			bigfile = {},
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			lazygit = {
				-- your lazygit configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
		keys = {
			{
				"<leader>gg",
				function()
					Snacks.lazygit.open()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gG",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Git logs for the current repo",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Git log for the current file",
			},
			{
				"<leader>gb",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git repo upstream website",
			},
			{
				"<leader>gl",
				function()
					Snacks.blame_line()
				end,
				desc = "Git blame of the current file",
			},
		},
	},
	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			quickfile = {
				-- your quickfile configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			image = {
				-- your image configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
	},
}

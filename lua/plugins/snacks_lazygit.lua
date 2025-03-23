return {
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
}

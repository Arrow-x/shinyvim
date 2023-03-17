return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>sa",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add File To Harpoon",
		},

		{
			"<leader>sm",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Show Harpoon menu",
		},

		{
			"<leader>sj",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "go to first file",
		},

		{
			"<leader>sk",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "go to second file",
		},

		{
			"<leader>sl",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "go to theird file",
		},

		{
			"<leader>s;",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "go to forth file",
		},

		{
			'<leader>s"',
			function()
				require("harpoon.ui").nav_file(5)
			end,
			desc = "go to fifth file",
		},

		{
			"<leader>sn",
			function()
				require("harpoon.ui").nav_next()
			end,
			desc = "go to next file",
		},

		{
			"<leader>sp",
			function()
				require("harpoon.ui").nav_prev()
			end,
			desc = "go to prev file",
		},
	},
}

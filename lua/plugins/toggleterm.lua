return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<leader>gg",
			function()
				require("toggleterm.terminal").Terminal
					:new({ direction = "float", cmd = "lazygit", hidden = true })
					:toggle()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>`t",
			function()
				require("toggleterm.terminal").Terminal
					:new({ direction = "float", cmd = "btop", hidden = true })
					:toggle()
			end,
			desc = "Btop",
		},
		{
			"<leader>`p",
			function()
				require("toggleterm.terminal").Terminal
					:new({ direction = "horizontal", cmd = "pyrhon", hidden = true })
					:toggle()
			end,
			desc = "Python",
		},
		{
			"<leader>``",
			function()
				require("toggleterm.terminal").Terminal:new({ direction = "float", hidden = true }):toggle()
			end,
			desc = "Float",
		},
		{
			"<leader>`h",
			function()
				require("toggleterm.terminal").Terminal:new({ direction = "horizontal", hidden = true }):toggle()
			end,
			desc = "Horizontal",
		},
	},
}

return {
	"akinsho/toggleterm.nvim",
	opts = {
		size = 20,
		-- open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
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

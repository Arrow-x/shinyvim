return {
	"romgrk/barbar.nvim",
	event = { "VeryLazy" },
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		local map = vim.keymap.set
		map("n", "<C-h>", "<Cmd>BufferPrevious<CR>")
		map("n", "<C-l>", "<Cmd>BufferNext<CR>")
		-- Move buffer
		map("n", "<C-A-h>", "<Cmd>BufferMovePrevious<CR>")
		map("n", "<C-A-l>", "<Cmd>BufferMoveNext<CR>")
	end,
}

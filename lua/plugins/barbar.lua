return {
	"romgrk/barbar.nvim",
	-- event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		local map = vim.keymap.set
		map("n", "<C-h>", "<Cmd>BufferPrevious<CR>")
		map("n", "<C-l>", "<Cmd>BufferNext<CR>")
		-- Move buffer
		map("n", "<C-A-h>", "<Cmd>BufferMovePrevious<CR>")
		map("n", "<C-A-l>", "<Cmd>BufferMoveNext<CR>")
		-- Close buffer
		map("n", "<leader>q", "<Cmd>BufferClose<CR>")
	end,
}

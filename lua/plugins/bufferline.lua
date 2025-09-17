return {
	"akinsho/bufferline.nvim",
	event = "BufAdd",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
		},
	},
	keys = {
		{
			"<C-A-l>",
			function()
				vim.cmd("BufferLineMoveNext")
			end,
			desc = "Move buffer line to the right",
		},
		{
			"<C-A-h>",
			function()
				vim.cmd("BufferLineMovePrev")
			end,
			desc = "Move buffer line to the left",
		},
		{
			"<C-l>",
			function()
				vim.cmd("BufferLineCycleNext")
			end,
			desc = "Cycle to Next buffer",
		},
		{
			"<C-h>",
			function()
				vim.cmd("BufferLineCyclePrev")
			end,
			desc = "Cycle to Previous buffer",
		},
		{
			"<leader>tp",
			function()
				vim.cmd("BufferLinePick")
			end,
			desc = "Interactive Pick",
		},
		{
			"<leader>tP",
			function()
				vim.cmd("BufferLineTogglePin")
			end,
			desc = "Toggle Pinning a tab",
		},
	},
}

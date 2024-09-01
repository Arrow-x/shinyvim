return {
	"echasnovski/mini.files",
	version = false,
	lazy = false,
	opts = {
		options = {
			use_as_default_explorer = true,
		}
	},
	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,
	keys = {
		{ "<leader>e",function() MiniFiles.open() end, desc = "Open Oil File Manager" },
	},
}

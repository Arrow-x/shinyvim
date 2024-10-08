return {
	"echasnovski/mini.files",
	lazy = false,
	opts = {
		options = {
			use_as_default_explorer = true,
		},
	},
	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,
	keys = {
		{
			"<leader>e",
			function()
				if not MiniFiles.close() then
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end
			end,
			desc = "Opens Mini.Files",
		},
	},
}

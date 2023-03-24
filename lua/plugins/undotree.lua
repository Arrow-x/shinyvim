return {
	"mbbill/undotree",
	keys = {
		{
			"<leader>uu",
			function()
				vim.cmd("UndotreeToggle")
				vim.cmd("UndotreeFocus")
			end,
			desc = "Toggle UndoTree",
		},
	},
}

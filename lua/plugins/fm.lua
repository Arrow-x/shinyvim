return {
	"is0n/fm-nvim",
	cmd = { "Lf", "Fzf" },
	keys = {
		{
			"<leader>e",
			function()
				local current_file = vim.api.nvim_buf_get_name(0)
				if current_file == nil or current_file == "" or string.match(current_file, "^" .. "oil") then
					vim.cmd("Lf")
				else
					vim.cmd("Lf %")
				end
			end,
			desc = "Open Lf File Manager",
		},
	},
}

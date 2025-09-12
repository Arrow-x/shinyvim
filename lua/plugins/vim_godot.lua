return {
	"habamax/vim-godot",
	ft = { "gdscript" },
	init = function()
		vim.g.godot_executable = "~/.local/bin/godot"
	end,
	dependencies = {
		"tpope/vim-dispatch",
		"junegunn/fzf",
		"junegunn/fzf.vim",
	},
	keys = {
		{
			"<leader>rr",
			function()
				vim.cmd("GodotRun")
			end,
			desc = "Run the initial Godot Scene",
		},
		{
			"<leader>rf",
			function()
				vim.cmd("GodotRunFZF")
			end,
			desc = "Run the initial Godot Scene",
		},
		{
			"<leader>rc",
			function()
				vim.cmd("GodotRunCurrent")
			end,
			desc = "Run the Current Godot Scene",
		},
		{
			"<leader>rl",
			function()
				vim.cmd("GodotRunLast")
			end,
			desc = "Run the Last Godot Scene",
		},
	},
}

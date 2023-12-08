return {
	"habamax/vim-godot",
	ft = { "gdscript" },
	init = function()
		vim.cmd("let g:godot_executable = '~/.local/bin/godot'")
	end,
}

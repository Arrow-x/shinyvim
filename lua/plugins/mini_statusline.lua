return {
	"echasnovski/mini.statusline",
	dependencies = { "echasnovski/mini-git" },
	version = false,
	config = function()
		require("mini.statusline").setup()
	end,
}

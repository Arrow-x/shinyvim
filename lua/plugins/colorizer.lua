return {
	"norcalli/nvim-colorizer.lua",
	keys = { {
		"<leader>mc",
		"<cmd>ColorizerToggle<cr>",
		desc = "Toggle colorizer",
	} },
	cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
	config = true,
}

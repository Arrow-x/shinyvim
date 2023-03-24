return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
			},
		},
	},
	config = true,
}

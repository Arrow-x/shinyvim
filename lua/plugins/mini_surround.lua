return {
	"echasnovski/mini.surround",
	config = function()
		require("mini.surround").setup()
	end,
	keys = {
		{ "sa", desc = "Add surrounding (in visual mode or on motion)" },
		{ "sd", desc = "Delete surrounding" },
		{ "sr", desc = "Replace surrounding" },
		{ "sf", desc = "Find surrounding" },
		{ "sF", desc = "Find surrounding back" },
		{ "sh", desc = "Highlight surrounding" },
		{ "sn", desc = "Change number of neighbor lines" },
	},
}

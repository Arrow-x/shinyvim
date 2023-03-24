return {
	"Darazaki/indent-o-matic",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		max_lines = 2048,
		standard_widths = { 2, 4, 8 },
	},
}

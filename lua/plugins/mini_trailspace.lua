return {
	'echasnovski/mini.trailspace',
	version = false,
	config =
		function()
			require("mini.trailspace").setup()
		end,
	keys = {
		{
			"<leader>t",
			function()
				MiniTrailspace.trim()
			end,
			desc = "Trim trailspaces"
		}
	}
}

return {
	"echasnovski/mini.pairs",
	config = function()
		require("mini.pairs").setup()
	end,
	keys = {
		{ '"', mode = "i" },
		{ "'", mode = "i" },
		{ "`", mode = "i" },
		{ "{", mode = "i" },
		{ "}", mode = "i" },
		{ "(", mode = "i" },
		{ ")", mode = "i" },
		{ "[", mode = "i" },
		{ "]", mode = "i" },
		{
			"<leader>mp",
			function()
				local Util = require("lazy.core.util")
				vim.g.minipairs_disable = not vim.g.minipairs_disable
				if vim.g.minipairs_disable then
					Util.warn("Disabled auto pairs", { title = "Option" })
				else
					Util.info("Enabled auto pairs", { title = "Option" })
				end
			end,
			desc = "Toggle auto pairs",
		},
	},
}

return {
	-- {
	-- 	"echasnovski/mini.icons",
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.icons").setup()
	-- 	end,
	-- },
	{
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
	},
	{
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
	},
	-- {
	-- 	"echasnovski/mini.tabline",
	-- 	version = false,
	--
	-- 	config = function()
	-- 		require("mini.tabline").setup()
	-- 	end,
	-- },
	{
		"echasnovski/mini.trailspace",
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
		keys = {
			{
				"<leader>t",
				function()
					MiniTrailspace.trim()
				end,
				desc = "Trim trailspaces",
			},
		},
	},
}

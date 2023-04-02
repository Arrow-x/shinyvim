return {
	"folke/which-key.nvim",
	config = function()
		local pluging_keymaps = {
			{ plugin = "nvim-dap", prefix = "d", desc = "Debuging" },
			{ plugin = "telescope.nvim", prefix = "f", desc = "Search" },
			{ plugin = "gitsigns.nvim", prefix = "g", desc = "Git integration" },
			{ plugin = "vimwiki", prefix = "w", desc = "VimWiki Notes" },
			{ plugin = "taskwiki", prefix = "t", desc = "TaskWarrior for VimWiki" },
			{ plugin = "toggleterm.nvim", prefix = "`", desc = "A Terminal in your Terminal" },
			{ plugin = "nvim-lspconfig", prefix = "l", desc = "LSP" },
			{ plugin = "harpoon", prefix = "s", desc = "Harpoon" },
			{ plugin = "trouble.nvim", prefix = "x", desc = "Trouble" },
			{ plugin = "notify.nvim", prefix = "u", desc = "Norify" },
			{ plugin = "true-zen", prefix = "z", desc = "TrueZen modes" },
		}

		local mappings = {
			p = { name = "Paste to system clipboard" },
			y = { name = "Copy to System clipboard" },
			m = { name = "Manipulate current file permissions" },
		}

		local opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}
		local function check()
			for _, p in pairs(pluging_keymaps) do
				if shinyvim.has(p.plugin) then
					if not mappings[p.prefix] then
						mappings[p.prefix] = { name = p.desc }
					end
				end
			end
		end
		check()
		require("which-key").register(mappings, opts)
		require("which-key").setup({
			plugins = {
				spelling = { enabled = true },
				presets = { operators = false },
			},
			window = {
				border = "double",
				padding = { 2, 2, 2, 2 },
			},
		})
	end,
	keys = {
		"<leader>",
		"z=",
		"'",
		'"',
	},
}

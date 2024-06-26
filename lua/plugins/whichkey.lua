return {
	"folke/which-key.nvim",
	config = function()
		local pluging_keymaps = {
			{ plugin = "nvim-dap", prefix = "b", desc = "Debuging" },
			{ plugin = "telescope.nvim", prefix = "f", desc = "Search" },
			{ plugin = "gitsigns.nvim", prefix = "g", desc = "Git integration" },
			{ plugin = "toggleterm.nvim", prefix = "`", desc = "A Terminal in your Terminal" },
			{ plugin = "nvim-lspconfig", prefix = "l", desc = "LSP" },
			{ plugin = "harpoon", prefix = "s", desc = "Harpoon" },
			{ plugin = "true-zen.nvim", prefix = "z", desc = "TrueZen modes" },
			{ plugin = "git-worktree.nvim", prefix = "gw", desc = "Worktrees" },
			{ plugin = "trouble.nvim", prefix = "x", desc = "Trouble" },
			{ plugin = "obsidian.nvim", prefix = "o", desc = "Obsidian" },
			{ plugin = "aerial.nvim", prefix = "a", desc = "Aerial Toggle" },
			{ plugin = "undotree", prefix = "u", desc = "UndoTree" },
			{ plugin = "lazy.nvim", prefix = "z", desc = "Toggle Lazy" },
			{ plugin = "hop.nvim", prefix = "j", desc = "Toggle Hop" },
			{ plugin = "hover.nvim", prefix = "k", desc = "Toggle Hover" },
		}

		local mappings = {
			p = { name = "Paste from primary system clipboard" },
			P = { name = "Paste from scondary system clipboard" },
			y = { name = "Copy to System clipboard" },
			m = { name = "Misc" },
		}

		local opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		local function has(plugin)
			return require("lazy.core.config").plugins[plugin] ~= nil
		end

		local function check()
			for _, p in pairs(pluging_keymaps) do
				if has(p.plugin) then
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

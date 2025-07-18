return {
	"folke/which-key.nvim",
	config = function()
		local pluging_keymaps = {
			{ plugin = "nvim-dap", prefix = "<leader>b", group = "Debuging" },
			{ plugin = "telescope.nvim", prefix = "<leader>f", group = "Search" },
			{ plugin = "gitsigns.nvim", prefix = "<leader>g", group = "Git" },
			{ plugin = "toggleterm.nvim", prefix = "<leader>`", group = "Terminal" },
			{ plugin = "nvim-lspconfig", prefix = "<leader>l", group = "LSP" },
			{ plugin = "harpoon", prefix = "<leader>s", group = "Harpoon" },
			{ plugin = "true-zen.nvim", prefix = "<leader>z", group = "TrueZen" },
			{ plugin = "git-worktree.nvim", prefix = "gw", group = "Worktrees" },
			{ plugin = "trouble.nvim", prefix = "<leader>x", group = "Trouble" },
			{ plugin = "obsidian.nvim", prefix = "<leader>o", group = "Obsidian" },
			{ plugin = "undotree", prefix = "<leader>u", group = "UndoTree" },
			{ plugin = "lazy.nvim", prefix = "<leader>z", group = "Lazy" },
			{ plugin = "hop.nvim", prefix = "<leader>j", group = "Hop" },
			{ plugin = "hover.nvim", prefix = "<leader>k", group = "Hover" },
			{ plugin = "vim-godot", prefix = "<leader>r", group = "Vim-Godot" },
			{ plugin = "vim-dispatch", prefix = "<leader>d", group = "Vim-Dispatch" },
		}

		local mappings = {
			{ "<leader>P", desc = "Paste from scondary system clipboard", nowait = true, remap = false, hidden = true },
			{ "<leader>p", desc = "Paste from primary system clipboard", nowait = true, remap = false, hidden = true },
			{ "<leader>y", desc = "Copy to System clipboard", nowait = true, remap = false, hidden = true },
			{ "<leader>Y", hidden = true },
			{ "<leader>d", hidden = true },
			{ "<leader>D", hidden = true },
			{ "<leader>m", group = "Misc", nowait = true, remap = false },
		}

		local opts = {
			mode = "n",
			silent = true,
			remap = false,
			nowait = true,
		}

		local function has(plugin)
			return require("lazy.core.config").plugins[plugin] ~= nil
		end

		local function check()
			for _, p in pairs(pluging_keymaps) do
				if has(p.plugin) then
					table.insert(mappings, {
						p.prefix,
						group = p.group,
						mode = opts.mode,
						nowait = opts.nowait,
						remap = opts.remap,
						silent = opts.silent,
					})
				end
			end
		end
		check()
		local wk = require("which-key")
		wk.setup({
			---@type false | "classic" | "modern" | "helix"
			preset = "modern",
		})
		wk.add(mappings)
	end,
	keys = {
		"<leader>",
		"z=",
		"'",
		'"',
	},
}

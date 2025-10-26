return {
	"stevearc/oil.nvim",
	lazy = false,
	-- Optional dependencies
	-- dependencies = { "echasnovski/mini.icons" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,
	opts = {
		-- Id is automatically added at the beginning, and name at the end
		-- See :help oil-columns
		columns = {
			"permissions",
			"size",
			"mtime",
			"icon",
		},
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = true,
		watch_for_changes = true,
		keymaps = {
			["<C-r>"] = "actions.refresh",
			["L"] = "actions.select",
			["H"] = "actions.parent",
			["gx"] = "actions.open_external",
			["gX"] = "actions.open_cmdline",
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
			-- This function defines what is considered a "hidden" file
			---@diagnostic disable-next-line: unused-local
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".") or vim.endswith(name, ".uid") or vim.endswith(name, ".os")
			end,
			-- This function defines what will never be shown, even when `show_hidden` is set
			---@diagnostic disable-next-line: unused-local
			is_always_hidden = function(name, bufnr)
				return false
			end,
		},
	},
	keys = {
		{ "<leader>e", "<CMD>Oil<CR>", desc = "Open Oil File Manager" },
	},
}

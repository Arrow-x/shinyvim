return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,
	opts = {
		-- close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		filesystem = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				visible = true,
				never_show = {
					".git",
				},
			},
		},
		default_component_configs = {
			diagnostics = {
				symbols = {
					hint = "󰌵",
					info = "",
					warn = "",
					error = "",
				},
			},
			indent = { padding = 1, indent_size = 2 },
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				default = "󰈙",
			},
			modified = { symbol = "" },
			git_status = {
				symbols = {
					added = "",
					deleted = "",
					modified = "",
					renamed = "➜",
					untracked = "★",
					ignored = "◌",
					unstaged = "✗",
					staged = "✓",
					conflict = "",
				},
			},
		},
		commands = {
			copy_selector = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local vals = {
					["BASENAME"] = modify(filename, ":r"),
					["EXTENSION"] = modify(filename, ":e"),
					["FILENAME"] = filename,
					["PATH (CWD)"] = modify(filepath, ":."),
					["PATH (HOME)"] = modify(filepath, ":~"),
					["PATH"] = filepath,
					["URI"] = vim.uri_from_fname(filepath),
				}

				local options = vim.tbl_filter(function(val)
					return vals[val] ~= ""
				end, vim.tbl_keys(vals))
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
				table.sort(options)
				vim.ui.select(options, {
					prompt = "Choose to copy to clipboard:",
					format_item = function(item)
						return ("%s: %s"):format(item, vals[item])
					end,
				}, function(choice)
					local result = vals[choice]
					if result then
						vim.notify(("Copied: `%s`"):format(result))
						vim.fn.setreg("+", result)
					end
				end)
			end,
		},
		window = {
			-- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
			-- possible options. These can also be functions that return these options.
			width = 30, -- applies to left and right positions
			mappings = {
				["l"] = "open",
				["c"] = {
					"copy",
					config = {
						show_path = "absolute", -- "none", "relative", "absolute"
					},
				},
				Y = "copy_selector",
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
			{
				event = "neo_tree_buffer_enter",
				handler = function(arg)
					vim.cmd([[setlocal rnu]])
				end,
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Open Neotree" },
	},
}

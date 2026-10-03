return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			init = function()
				-- Disable entire built-in ftplugin mappings to avoid conflicts.
				-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
				vim.g.no_plugin_maps = true

				-- Or, disable per filetype (add as you like)
				-- vim.g.no_python_maps = true
				-- vim.g.no_ruby_maps = true
				-- vim.g.no_rust_maps = true
				-- vim.g.no_go_maps = true
			end,
			config = function()
				-- put your config here
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter-context",
			lazy = false,
			opts = {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			},
			keys = {
				{
					"<leader>mt",
					function()
						local tsc = require("treesitter-context")
						tsc.toggle()
						shinyvim.ts_context_toggle = not shinyvim.ts_context_toggle
						if shinyvim.ts_context_toggle == true then
							vim.notify("Treesitter Context is Turned On")
						else
							vim.notify("Treesitter Context is Turned Off")
						end
					end,
					desc = "Toggle Treesitter Context",
				},
			},
		},
	},
	lazy = false,
	config = function()
		local parsers = {
			"vim",
			"vimdoc",
			"gdscript",
			"python",
			"bash",
			"markdown",
			"markdown_inline",
			"rust",
			"lua",
			"c",
			"cpp",
			"c_sharp",
			"diff",
			"gitcommit",
			"cmake",
			"godot_resource",
			"gdshader",
			"hyprlang",
		}
		require("nvim-treesitter").install(parsers)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function(ev)
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
				vim.wo.foldmethod = "expr"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
				vim.treesitter.start(ev.buf) -- highlighting
			end,
		})
	end,
}

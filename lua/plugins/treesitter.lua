return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	dependencies = {
		{ "p00f/nvim-ts-rainbow" },
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = {
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
					"<leader>ut",
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
	opts = {
		ensure_installed = {
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
		}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = function(_, bufnr)
				return vim.api.nvim_buf_line_count(bufnr) > 10000
			end,
			additional_vim_regex_highlighting = { "markdown" },
		},
		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = 10000, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
		incremental_selection = { enable = true },
		indent = { enable = true, disable = { "gdscript" } },
		autotag = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
	},
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)
	end,
}

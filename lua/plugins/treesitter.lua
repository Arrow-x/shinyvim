return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"p00f/nvim-ts-rainbow",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
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
				additional_vim_regex_highlighting = false,
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
			indent = { enable = true },
			autotag = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
		})
	end,
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
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
			"diff",
			"gitcommit",
		}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = function(_, bufnr)
				return vim.api.nvim_buf_line_count(bufnr) > 10000
			end,
			additional_vim_regex_highlighting = { "markdown", "ruby" },
		},

		auto_install = true,
		incremental_selection = { enable = true },
		indent = { enable = true, disable = { "gdscript", "ruby" } },
		autotag = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
	},
}

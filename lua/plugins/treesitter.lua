return {
	"nvim-treesitter/nvim-treesitter",
	config = vim.defer_fn(function()
		local opts = {
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
					return vim.api.nvim_buf_line_count(bufnr) > 1000
				end,
				additional_vim_regex_highlighting = { "markdown" },
			},
			incremental_selection = { enable = true },
			indent = { enable = true, disable = { "gdscript" } },
			autotag = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
		}
		require("nvim-treesitter.configs").setup(opts)
	end, 0),
}

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
				"gitcommit",
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
			incremental_selection = { enable = true },
			indent = { enable = true, disable = { "gdscript" } },
			autotag = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
		}

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

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.haxe = {
			install_info = {
				url = "https://github.com/vantreeseba/tree-sitter-haxe",
				files = { "src/parser.c" },
				-- optional entries:
				branch = "main",
			},
			filetype = "haxe",
		}
	end, 0),
}

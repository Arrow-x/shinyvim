return {
	"neovim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
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

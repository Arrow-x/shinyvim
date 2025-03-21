return {
	"nvimtools/none-ls.nvim",
	ft = { "lua", "gdscript", "sh", "bash", "python", "cpp", "cs", "markdown" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			sources = {
				formatting.clang_format,
				formatting.gdformat.with({
					extra_args = {"--fast"}
				}),
				formatting.stylua,
				formatting.shfmt.with({ extra_args = { "-ci" } }),
				-- formatting.markdownlint,
				-- diagnostics.markdownlint.with({
				-- 	extra_args = { "--config", "/home/arrowx/.config/nvim/lua/config/lsp/markdownlint.json" },
				-- }),

				-- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
				-- formatting.black.with({ extra_args = { "--fast" } }),
				-- diagnostics.gdlint,
				-- diagnostics.alex,
				-- diagnostics.flake8,
			},
		})
	end,
}

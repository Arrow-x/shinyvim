return {
	"nvimtools/none-ls.nvim",
	ft = { "lua", "gdscript", "sh" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			debug = false,
			sources = {
				-- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
				-- formatting.black.with({ extra_args = { "--fast" } }),
				formatting.gdformat.with({ extra_args = { "--fast" } }),
				formatting.stylua,
				formatting.beautysh.with({ extra_args = { "-s", "paronly", "-t" } }),
				-- diagnostics.gdlint,
				-- diagnostics.alex,
				-- diagnostics.flake8,
			},
		})
	end,
}

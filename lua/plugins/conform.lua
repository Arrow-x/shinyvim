return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {}, cmd = { "Mason" } },
	},
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "never" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
		{
			"<leader>lF",
			function()
				shinyvim.autoformat = not shinyvim.autoformat
				vim.notify(string.format("autoformat is %s", tostring(shinyvim.autoformat)))
			end,
			mode = "",
			desc = "Toggle Auto[F]ormat on save",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			if shinyvim.autoformat ~= true then
				return nil
			end

			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = {}
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
					-- lsp_format = "never",
				}
			end
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			cs = { "clang-format" },
			gdscript = { "gdformat" },
			sh = { "shfmt" },
			toml = { "taplo" },
			["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "fallback" },

			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}

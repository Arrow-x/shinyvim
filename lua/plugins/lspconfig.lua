return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
				cmd = { "Mason" },
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig")
				end,
			},
			{
				"hrsh7th/cmp-nvim-lsp",
			},
			{
				"Hoffs/omnisharp-extended-lsp.nvim",
			},
			{
				"RRethy/vim-illuminate",
				event = { "BufReadPost", "BufNewFile" },
				config = function()
					local illuminate = require("illuminate")
					vim.keymap.set("n", "<Tab>", function()
						illuminate.next_reference({ wrap = true })
					end, { noremap = true, desc = "illuminate go to next reference" })
					vim.keymap.set("n", "<S-Tab>", function()
						illuminate.next_reference({ reverse = true, wrap = true })
					end, { noremap = true, desc = "illuminate go to previous reference" })

					illuminate.configure({
						delay = 0,
						filetypes_denylist = {
							"alpha",
							"NvimTree",
							"TelescopePrompt",
						},
						modes_denylist = { "i" },
					})
				end,
			},
			{
				event = { "BufReadPre", "BufNewFile" },
				"j-hui/fidget.nvim",
				tag = "legacy",
				config = function()
					require("fidget").setup({
						window = {
							blend = 0,
						},
					})
				end,
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "󰌵" },
				{ name = "DiagnosticSignInfo", text = "" },
			}

			for _, sign in pairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			local config = {
				virtual_text = true,
				signs = {
					active = signs,
				},
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}

			vim.diagnostic.config(config)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			local on_attach = function(client, bufnr)
				local servers_to_disable_formating_for = { "tsserver", "lua_ls" }

				for _, server in pairs(servers_to_disable_formating_for) do
					if client.name == server then
						client.server_capabilities.document_formatting = false
					end
				end

				if client.name ~= "gdscript" then
					require("illuminate").on_attach(client)
				end

				require("nvim-navic").attach(client, bufnr)

				local keymap = vim.keymap.set
				keymap("n", "<leader>ld", vim.lsp.buf.definition, { desc = "go to Definition" })
				keymap("n", "<leader>lc", vim.lsp.buf.declaration, { desc = "go to Declaration" })
				keymap("n", "<leader>li", vim.lsp.buf.implementation, { desc = "go to Implementation" })
				keymap("n", "<leader>lR", vim.lsp.buf.references, { desc = "go to references" })
				keymap("n", "<leader>lH", vim.lsp.buf.signature_help, { desc = "Signature Help" })
				keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
				keymap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
				keymap("n", "<leader>ln", vim.diagnostic.goto_next, {
					desc = "Go to next Diagnostics",
				})
				keymap("n", "<leader>lp", vim.diagnostic.goto_prev, {
					desc = "Go to prev Diagnostics",
				})
				keymap("n", "<leader>lh", vim.diagnostic.open_float, { desc = "Hover Diagnostics" })
				keymap("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix list" })
				keymap("n", "<leader>lI", function()
					vim.cmd("LspInfo")
				end, { desc = "Info" })
				keymap("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
				keymap("n", "<space>lD", vim.lsp.buf.type_definition, { desc = "Type definition" })
			end

			-- Lsp servers that are not installed by mason
			local servers = {
				"gdscript",
				-- "ltex",
			}

			local mason_lspconfig = require("mason-lspconfig")
			for _, server in pairs(mason_lspconfig.get_installed_servers()) do
				table.insert(servers, server)
			end

			for _, server in pairs(servers) do
				local opts = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
					end,
					capabilities = vim.tbl_deep_extend("force", capabilities, lspconfig[server].capabilities or {}),
				}

				local present, custom_settings = pcall(require, "config.lsp.settings." .. server)
				if present then
					opts = vim.tbl_deep_extend("force", custom_settings, opts)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
}

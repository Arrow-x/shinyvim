return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig")
				end,
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return shinyvim.has("nvim-cmp")
				end,
			},
			{
				"RRethy/vim-illuminate",
				event = { "BufReadPost", "BufNewFile" },
				config = function()
					local illuminate = require("illuminate")
					vim.keymap.set("n", "<a-n>", function()
						illuminate.next_reference({ wrap = true })
					end, { noremap = true })
					vim.keymap.set("n", "<a-p>", function()
						illuminate.next_reference({ reverse = true, wrap = true })
					end, { noremap = true })

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
		},
		-- BUG the options are not working
		config = function()
			local lspconfig = require("lspconfig")

			local insert = table.insert
			local tbl_deep_extend = vim.tbl_deep_extend
			local handlers = {}
			handlers.capabilities = require("cmp_nvim_lsp").default_capabilities()

			handlers.setup = function()
				local signs = {
					{ name = "DiagnosticSignError", text = "" },
					{ name = "DiagnosticSignWarn", text = "" },
					{ name = "DiagnosticSignHint", text = "" },
					{ name = "DiagnosticSignInfo", text = "" },
				}

				for _, sign in ipairs(signs) do
					vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
				end

				local config = {
					virtual_text = false,
					signs = {
						active = signs,
					},
					update_in_insert = true,
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
			end

			handlers.on_attach = function(client, bufnr)
				local servers_to_disable_formating_for = { "tsserver", "lua_ls" }

				for _, server in pairs(servers_to_disable_formating_for) do
					if client.name == server then
						client.server_capabilities.document_formatting = false
					end
				end

				require("illuminate").on_attach(client)
				require("nvim-navic").attach(client, bufnr)
			end

			-- Lsp servers that are not installed by mason
			local servers = {
				"gdscript",
				-- "ltex",
			}

			local mason_lspconfig = require("mason-lspconfig")
			for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
				insert(servers, server)
			end

			for _, server in ipairs(servers) do
				local opts = {
					on_attach = function(client, bufnr)
						handlers.on_attach(client, bufnr)
					end,
					capabilities = tbl_deep_extend(
						"force",
						handlers.capabilities,
						lspconfig[server].capabilities or {}
					),
				}

				local present, custom_settings = pcall(require, "config.lsp.settings." .. server)
				if present then
					opts = tbl_deep_extend("force", custom_settings, opts)
				end
				lspconfig[server].setup(opts)
			end

			handlers.setup()
			local keymap = vim.keymap.set
			keymap("n", "<leader>ld", function()
				vim.lsp.buf.definition()
			end, { desc = "go to Definition" })
			keymap("n", "<leader>lc", function()
				vim.lsp.buf.declaration()
			end, { desc = "go to Declaration" })
			keymap("n", "<leader>li", function()
				vim.lsp.buf.implementation()
			end, { desc = "go to Implementation" })
			keymap("n", "<leader>lR", function()
				vim.lsp.buf.references()
			end, { desc = "go to references" })
			keymap("n", "<leader>lH", function()
				vim.lsp.buf.signature_help()
			end, { desc = "Signature Help" })
			keymap("n", "<leader>lr", function()
				vim.lsp.buf.rename()
			end, { desc = "Rename" })
			keymap("n", "<leader>la", function()
				vim.lsp.buf.code_action()
			end, { desc = "Code Actions" })
			keymap("n", "<leader>ln", function()
				vim.diagnostic.goto_next({ border = "rounded" })
			end, { desc = "Go to next Diagnostics" })
			keymap("n", "<leader>lp", function()
				vim.diagnostic.goto_prev({ border = "rounded" })
			end, { desc = "Go to prev Diagnostics" })
			keymap("n", "<leader>lh", function()
				vim.diagnostic.open_float()
			end, { desc = "Hover Diagnostics" })
			keymap("n", "<leader>lq", function()
				vim.diagnostic.setloclist()
			end, { desc = "Diagnostics to loacal list" })
			keymap("n", "<leader>lI", function()
				vim.cmd("LspInfo")
			end, { desc = "Info" })
			keymap("n", "<leader>lf", function()
				vim.lsp.buf.format()
			end, { desc = "Format" })
		end,
	},
}

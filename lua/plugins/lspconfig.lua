return {
	{
		"neovim/nvim-lspconfig",
		ft = { "lua", "gdscript", "markdown", "sh", "bash", "haxe", "python", "cs" },
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
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim", config = true },
			{ "Hoffs/omnisharp-extended-lsp.nvim" },
			{
				"folke/trouble.nvim",
				dependencies = { "nvim-tree/nvim-web-devicons" },
				-- Lua
				keys = {
					{
						"<leader>xx",
						function()
							require("trouble").toggle()
						end,
						desc = "Trouble Toggle",
					},
					{
						"<leader>xw",
						function()
							require("trouble").toggle("workspace_diagnostics")
						end,
						desc = "Workspace Diagnostics",
					},
					{
						"<leader>xd",
						function()
							require("trouble").toggle("document_diagnostics")
						end,
						desc = "Document Diagnostics",
					},
					{
						"<leader>xq",
						function()
							require("trouble").toggle("quickfix")
						end,
						desc = "Trouble Quickfix",
					},
					{
						"<leader>xl",
						function()
							require("trouble").toggle("loclist")
						end,
						desc = "Trouble Locallist",
					},
					{
						"<leader>lR",
						function()
							require("trouble").toggle("lsp_references")
						end,
						desc = "Lsp Refernces",
					},
				},
			},
			{
				"smjonas/inc-rename.nvim",
				config = function()
					require("inc_rename").setup({
						cmd_name = "IncRename", -- the name of the command
						hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
						preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
						show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
						input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
						post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
					})
					vim.keymap.set("n", "<leader>lr", function()
						return ":IncRename " .. vim.fn.expand("<cword>")
					end, { expr = true, desc = "inc-rename" })
					vim.keymap.set("n", "<leader>lqr", function()
						return "q:IncRename " .. vim.fn.expand("<cword>")
					end, { expr = true, desc = "inc-rename-buffer-cmd" })
				end,
			},
			{
				"RRethy/vim-illuminate",
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
				"nvim-telescope/telescope-ui-select.nvim",
				dependencies = {
					"nvim-telescope/telescope.nvim",
				},
				config = function()
					require("telescope").setup({
						extensions = {
							["ui-select"] = {
								require("telescope.themes").get_dropdown({}),
							},
						},
					})
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup({
						notification = {
							window = {
								winblend = 0,
							},
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
					text = {
						["INFO"] = "",
						["ERROR"] = "",
						["WARN"] = "",
						["HINT"] = "󰌵",
					},
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

			---@diagnostic disable-next-line: unused-local
			local on_attach = function(client, bufnr)
				local servers_to_disable_formating_for = { "tsserver", "lua_ls", "omnisharp", "csharp-ls" }

				for _, server in pairs(servers_to_disable_formating_for) do
					if client.name == server then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end

				if client.name ~= "gdscript" then
					require("illuminate").on_attach(client)
				end

				local toggle_autoforamt = function()
					shinyvim.autoformat = not shinyvim.autoformat
					vim.notify("Autoformating is " .. tostring(shinyvim.autoformat))
				end

				local keymap = vim.keymap.set
				keymap("n", "<leader>ld", vim.lsp.buf.definition, { desc = "go to Definition" })
				keymap("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "Type definition" })
				keymap("n", "<leader>lc", vim.lsp.buf.declaration, { desc = "go to Declaration" })
				keymap("n", "<leader>li", vim.lsp.buf.implementation, { desc = "go to Implementation" })
				keymap("n", "<leader>lH", vim.lsp.buf.signature_help, { desc = "Signature Help" })
				keymap("n", "K", vim.lsp.buf.hover, { desc = "hover" })
				-- keymap("n", "<leader>lR", vim.lsp.buf.references, { desc = "go to references" })
				-- keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
				keymap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
				keymap("n", "<leader>lF", toggle_autoforamt, { desc = "toggle format on save" })
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
				keymap("n", "<leader>lf", function()
					vim.lsp.buf.format({ timeout_ms = 90000, async = true })
				end, { desc = "Format" })
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

				local present, custom_settings = pcall(require, "config.lsp." .. server)
				if present then
					opts = vim.tbl_deep_extend("force", custom_settings, opts)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
}

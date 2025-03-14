return {
	{
		"neovim/nvim-lspconfig",
		ft = { "lua", "gdscript", "sh", "bash", "python", "cs" },
		cmd = {"LspStart"},
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = {
					ensure_installed = { "lua_ls", "bashls", "pylsp", "clangd"},
				},
			},
			{ "saghen/blink.cmp" },
			{ "Hoffs/omnisharp-extended-lsp.nvim" },
			{
				"williamboman/mason.nvim",
				config = true,
				cmd = { "Mason" },
			},
			{
				"folke/trouble.nvim",
				opts = {}, -- for default options, refer to the configuration section for custom setup.
				cmd = "Trouble",
				keys = {
					{
						"<leader>xx",
						"<cmd>Trouble diagnostics toggle<cr>",
						desc = "Diagnostics (Trouble)",
					},
					{
						"<leader>xX",
						"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
						desc = "Buffer Diagnostics (Trouble)",
					},
					{
						"<leader>xs",
						"<cmd>Trouble symbols toggle focus=false<cr>",
						desc = "Symbols (Trouble)",
					},
					{
						"<leader>xl",
						"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
						desc = "LSP Definitions / references / ... (Trouble)",
					},
					{
						"<leader>xL",
						"<cmd>Trouble loclist toggle<cr>",
						desc = "Location List (Trouble)",
					},
					{
						"<leader>xQ",
						"<cmd>Trouble qflist toggle<cr>",
						desc = "Quickfix List (Trouble)",
					},
					{
						"<leader>xr",
						"<cmd>Trouble lsp_references toggle<cr>",
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
			local capabilities = require("blink.cmp").get_lsp_capabilities()

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
				-- virtual_lines = true,
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

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local function lsp_formatting(bufnr, async)
				vim.lsp.buf.format({
					filter = function(client)
						for _, server in pairs({ "tsserver", "lua_ls", "omnisharp", "csharp_ls" }) do
							if client.name == server then
								return false
							end
						end
						return true
					end,
					bufnr = bufnr,
					timeout_ms = 90000,
					async = async,
				})
			end
			---@diagnostic disable-next-line: unused-local
			local on_attach = function(client, bufnr)
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						if shinyvim.autoformat == true then
							lsp_formatting(bufnr, false)
						end
					end,
				})

				if client.name ~= "gdscript" then
					require("illuminate").on_attach(client)
				end

				local _hover = vim.lsp.buf.hover

				vim.lsp.buf.hover = function(opts)
					opts = opts or {}
					opts.border = opts.border or "single"
					return _hover(opts)
				end

				local keymap = vim.keymap.set
				keymap("n", "<leader>ld", vim.lsp.buf.definition, { desc = "go to Definition" })
				keymap("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "Type definition" })
				keymap("n", "<leader>lc", vim.lsp.buf.declaration, { desc = "go to Declaration" })
				keymap("n", "<leader>li", vim.lsp.buf.implementation, { desc = "go to Implementation" })
				keymap("n", "<leader>lR", vim.lsp.buf.references, { desc = "get references" })
				keymap("n", "<leader>lH", function()
					vim.lsp.buf.signature_help({ border = "single" })
				end, { desc = "Signature Help" })
				keymap("n", "K", vim.lsp.buf.hover, { desc = "hover" })
				-- keymap("n", "<leader>lR", vim.lsp.buf.references, { desc = "go to references" })
				-- keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
				keymap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
				keymap("n", "<leader>lF", function()
					shinyvim.autoformat = not shinyvim.autoformat
					vim.notify("Autoformating is " .. tostring(shinyvim.autoformat))
				end, { desc = "toggle format on save" })
				keymap("n", "<leader>ln", function()
					vim.diagnostic.jump({ count = 1 })
				end, { desc = "Go to next Diagnostics" })
				keymap("n", "<leader>lp", function()
					vim.diagnostic.jump({ count = -1 })
				end, { desc = "Go to prev Diagnostics" })
				keymap("n", "<leader>lh", vim.diagnostic.open_float, { desc = "Hover Diagnostics" })
				keymap("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix list" })
				keymap("n", "<leader>lI", function()
					vim.cmd("LspInfo")
				end, { desc = "Info" })
				keymap("n", "<leader>lf", function()
					lsp_formatting(bufnr, true)
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

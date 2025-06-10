return {
	"neovim/nvim-lspconfig",
	ft = { "lua", "gdscript", "sh", "bash", "python", "cs" },
	cmd = { "LspStart" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
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
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local _hover = vim.lsp.buf.hover

				---@diagnostic disable-next-line: duplicate-set-field
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

				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					keymap("n", "<leader>mi", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, { desc = "[M]is Toggle [i]nlay hints" })
				end
			end,
		})

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			clangd = {},
			csharp_ls = {},
			lua_ls = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths
								-- here.
								-- '${3rd}/luv/library'
								-- '${3rd}/busted/library'
								-- "/home/arrowx/.local/share/nvim/lazy/snacks.nvim"
							},
							-- Or pull in all of 'runtimepath'.
							-- NOTE: this is a lot slower and will cause issues when working on
							-- your own configuration.
							-- See https://github.com/neovim/nvim-lspconfig/issues/3189
							-- library = {
							--   vim.api.nvim_get_runtime_file('', true),
							-- }
						},
					})
				end,
				settings = {
					Lua = {
						telemetry = {
							enable = false,
						},
						diagnostics = {
							globals = {
								"Snacks",
							},
						},
					},
				},
			},
			bashls = {
				settings = {
					bashIde = {
						shfmt = {
							path = "",
						},
					},
				},
			},
			pylsp = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"gdtoolkit",
			"clang-format",
			"codelldb",
			"shellcheck",
			"shfmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- none Mason lsp servers
		servers.gdscript = {}

		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local opts = {}

		for _, server in pairs(vim.tbl_keys(servers)) do
			local custom_settings = servers[server] or {}
			opts.capabilities = vim.tbl_deep_extend("force", capabilities, lspconfig[server].capabilities or {})
			opts = vim.tbl_deep_extend("force", custom_settings, opts)
			vim.lsp.config(server, opts)
		end
		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}

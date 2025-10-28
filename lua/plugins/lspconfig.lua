return {
	"neovim/nvim-lspconfig",
	ft = { "lua", "gdscript", "sh", "bash", "python", "toml" },
	cmd = { "LspStart" },
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			},
			cmd = { "Mason" },
		},
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
				vim.keymap.set("n", "grn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { expr = true, desc = "inc-rename" })
				vim.keymap.set("n", "grN", function()
					return "q:IIncRename " .. vim.fn.expand("<cword>")
				end, { expr = true, desc = "inc-rename-buffer-cmd" })
			end,
		},
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local keymap = vim.keymap.set

				keymap("n", "grd", vim.lsp.buf.definition, { desc = "go to Definition" })
				keymap("n", "grD", vim.lsp.buf.type_definition, { desc = "Type definition" })
				keymap("n", "grq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix list" })
				keymap("n", "grc", vim.lsp.buf.declaration, { desc = "go to Declaration" })
				keymap("n", "K", vim.lsp.buf.hover, { desc = "hover" })

				keymap("n", "grF", function()
					shinyvim.autoformat = not shinyvim.autoformat
					vim.notify("Autoformating is " .. tostring(shinyvim.autoformat))
				end, { desc = "toggle format on save" })

				if client ~= nil then
					if client.name == "clangd" then
						keymap("n", "grh", function()
							vim.cmd("LspClangdSwitchSourceHeader")
						end, { desc = "use clangd to switch between header and implemntation" })
					end
				end

				local function client_supports_method(_client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return _client:supports_method(method, bufnr)
					else
						return _client.supports_method(method, { bufnr = bufnr })
					end
				end

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
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
					keymap("n", "grI", function()
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
			virtual_lines = {
				current_line = true,
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
		-- Breadcrumbs:
		local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
		local folder_icon = "%#Conditional#" .. "󰉋" .. "%#Normal#"
		local file_icon = "󰈙"

		local kind_icons = {
			"%#File#" .. "󰈙" .. "%#Normal#", -- file
			"%#Module#" .. "" .. "%#Normal#", -- module
			"%#Structure#" .. "" .. "%#Normal#", -- namespace
			"%#Keyword#" .. "󰌋" .. "%#Normal#", -- keyword
			"%#Class#" .. "󰠱" .. "%#Normal#", -- class
			"%#Method#" .. "󰆧" .. "%#Normal#", -- method
			"%#Property#" .. "󰜢" .. "%#Normal#", -- property
			"%#Field#" .. "󰇽" .. "%#Normal#", -- field
			"%#Function#" .. "" .. "%#Normal#", -- constructor
			"%#Enum#" .. "" .. "%#Normal#", -- enum
			"%#Type#" .. "" .. "%#Normal#", -- interface
			"%#Function#" .. "󰊕" .. "%#Normal#", -- function
			"%#None#" .. "󰂡" .. "%#Normal#", -- variable
			"%#Constant#" .. "󰏿" .. "%#Normal#", -- constant
			"%#String#" .. "" .. "%#Normal#", -- string
			"%#Number#" .. "" .. "%#Normal#", -- number
			"%#Boolean#" .. "" .. "%#Normal#", -- boolean
			"%#Array#" .. "" .. "%#Normal#", -- array
			"%#Class#" .. "" .. "%#Normal#", -- object
			"", -- package
			"󰟢", -- null
			"", -- enum-member
			"%#Struct#" .. "" .. "%#Normal#", -- struct
			"", -- event
			"", -- operator
			"󰅲", -- type-parameter
			"",
			"",
			"󰎠",
			"",
			"󰏘",
			"",
			"󰉋",
		}

		local function range_contains_pos(range, line, char)
			local start = range.start
			local stop = range["end"]

			if line < start.line or line > stop.line then
				return false
			end

			if line == start.line and char < start.character then
				return false
			end

			if line == stop.line and char > stop.character then
				return false
			end

			return true
		end

		local function find_symbol_path(symbol_list, line, char, path)
			if not symbol_list or #symbol_list == 0 then
				return false
			end

			for _, symbol in ipairs(symbol_list) do
				if range_contains_pos(symbol.range, line, char) then
					local icon = kind_icons[symbol.kind] or ""
					table.insert(path, icon .. " " .. symbol.name)
					find_symbol_path(symbol.children, line, char, path)
					return true
				end
			end
			return false
		end

		local function lsp_callback(err, symbols, ctx, config)
			if err or not symbols then
				vim.o.winbar = ""
				return
			end

			local winnr = vim.api.nvim_get_current_win()
			local pos = vim.api.nvim_win_get_cursor(0)
			local cursor_line = pos[1] - 1
			local cursor_char = pos[2]

			local file_path = vim.fn.bufname(ctx.bufnr)
			if not file_path or file_path == "" then
				vim.o.winbar = "[No Name]"
				return
			end

			local relative_path

			local clients = vim.lsp.get_clients({ bufnr = ctx.bufnr })

			if #clients > 0 and clients[1].root_dir then
				local root_dir = clients[1].root_dir
				if root_dir == nil then
					relative_path = file_path
				else
					relative_path = vim.fs.relpath(root_dir, file_path)
				end
			else
				local root_dir = vim.fn.getcwd(0)
				relative_path = vim.fs.relpath(root_dir, file_path)
			end

			local breadcrumbs = {}

			local path_components = vim.split(relative_path, "[/\\]", { trimempty = true })
			local num_components = #path_components

			for i, component in ipairs(path_components) do
				if i == num_components then
					local icon
					local icon_hl

					if devicons_ok then
						icon, icon_hl = devicons.get_icon(component)
					end
					table.insert(
						breadcrumbs,
						"%#" .. icon_hl .. "#" .. (icon or file_icon) .. "%#Normal#" .. " " .. component
					)
				else
					table.insert(breadcrumbs, folder_icon .. " " .. component)
				end
			end
			find_symbol_path(symbols, cursor_line, cursor_char, breadcrumbs)

			local breadcrumb_string = table.concat(breadcrumbs, " > ")

			if breadcrumb_string ~= "" then
				vim.api.nvim_set_option_value("winbar", breadcrumb_string, { win = winnr })
			else
				vim.api.nvim_set_option_value("winbar", " ", { win = winnr })
			end
		end

		local function breadcrumbs_set()
			local bufnr = vim.api.nvim_get_current_buf()
			local winnr = vim.api.nvim_get_current_buf()
			---@type string
			local uri = vim.lsp.util.make_text_document_params(bufnr)["uri"]
			if not uri then
				vim.print("Error: Could not get URI for buffer. Is it saved?")
				return
			end

			local params = {
				textDocument = {
					uri = uri,
				},
			}

			local buf_src = uri:sub(1, uri:find(":") - 1)
			if buf_src ~= "file" then
				vim.o.winbar = ""
				return
			end

			vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, lsp_callback)
		end

		local breadcrumbs_augroup = vim.api.nvim_create_augroup("Breadcrumbs", { clear = true })

		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			group = breadcrumbs_augroup,
			callback = breadcrumbs_set,
			desc = "Set breadcrumbs.",
		})

		vim.api.nvim_create_autocmd({ "WinLeave" }, {
			group = breadcrumbs_augroup,
			callback = function()
				vim.o.winbar = ""
			end,
			desc = "Clear breadcrumbs when leaving window.",
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
								-- "~/.local/share/nvim/lazy/snacks.nvim"
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

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local opts = {}

		for _, server in pairs(vim.tbl_keys(servers)) do
			local custom_settings = servers[server] or {}
			opts.capabilities = vim.tbl_deep_extend("force", capabilities, vim.lsp.config[server].capabilities or {})
			opts = vim.tbl_deep_extend("force", custom_settings, opts)
			vim.lsp.config(server, opts)
		end
		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}

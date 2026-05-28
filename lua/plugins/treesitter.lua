return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter", -- Sets main module to use for opts
		event = { "BufRead" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
					min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
					line_numbers = true,
					multiline_threshold = 20, -- Maximum number of lines to show for a single context
					trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
					-- Separator between context and content. Should be a single character string, like '-'.
					-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
					separator = nil,
					zindex = 20, -- The Z-index of the context window
					on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
				},
				keys = {
					{
						"<leader>mt",
						function()
							local tsc = require("treesitter-context")
							tsc.toggle()
							shinyvim.ts_context_toggle = not shinyvim.ts_context_toggle
							if shinyvim.ts_context_toggle == true then
								vim.notify("Treesitter Context is Turned On")
							else
								vim.notify("Treesitter Context is Turned Off")
							end
						end,
						desc = "Toggle Treesitter Context",
					},
				},
			},
		},
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
				-- ... your parsers
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(parsers)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)

			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- check if parser exists and load it
				if not vim.treesitter.language.add(language) then
					return
				end
				-- enables syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- enables treesitter based folds
				-- for more info on folds see `:help folds`
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'

				-- enables treesitter based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						-- enable the parser if it is installed
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						-- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						-- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
		-- 	opts = {
		-- 		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		-- 		ignore_install = { "" }, -- List of parsers to ignore installing
		-- 		highlight = {
		-- 			enable = true, -- false will disable the whole extension
		-- 			-- disable = function(_, bufnr)
		-- 			-- 	return vim.api.nvim_buf_line_count(bufnr) > 10000
		-- 			-- end,
		-- 			additional_vim_regex_highlighting = { "markdown", "ruby" },
		-- 		},
		--
		-- 		auto_install = true,
		-- 		incremental_selection = { enable = true },
		-- 		indent = { enable = true, disable = { "gdscript", "ruby" } },
		-- 		autotag = { enable = true },
		-- 		context_commentstring = { enable = true, enable_autocmd = false },
		-- 	},
		-- 	init = function()
		-- 		local ensureInstalled = {
		-- 			"vim",
		-- 			"vimdoc",
		-- 			"gdscript",
		-- 			"python",
		-- 			"bash",
		-- 			"markdown",
		-- 			"markdown_inline",
		-- 			"rust",
		-- 			"lua",
		-- 			"c",
		-- 			"cpp",
		-- 			"c_sharp",
		-- 			"diff",
		-- 			"gitcommit",
		-- 			-- ... your parsers
		-- 		}
		-- 		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		-- 		local parsersToInstall = vim.iter(ensureInstalled)
		-- 			:filter(function(parser)
		-- 				return not vim.tbl_contains(alreadyInstalled, parser)
		-- 			end)
		-- 			:totable()
		-- 		require("nvim-treesitter").install(parsersToInstall)
		-- 	end,
	},
}

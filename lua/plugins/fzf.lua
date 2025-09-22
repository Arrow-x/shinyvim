return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		require("fzf-lua").setup({
			file_ignore_patterns = { "%.uid$" },
			winopts = {
				split = "belowright new",
			},
			keymap = {
				fzf = {
					true,
					-- Use <c-q> to select all items and add them to the quickfix list
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
		require("fzf-lua").register_ui_select(function(_, items)
			local min_h, max_h = 0.15, 0.70
			local h = (#items + 4) / vim.o.lines
			if h < min_h then
				h = min_h
			elseif h > max_h then
				h = max_h
			end
			return { winopts = { height = h, width = 0.60, row = 0.40 } }
		end)
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fF",
			function()
				require("fzf-lua").files({ cmd = "fd --type f --no-ignore-vcs" })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fG",
			function()
				require("fzf-lua").live_grep({ cmd = "rg --no-ignore --line-number --column" })
			end,
			desc = "Grep",
		},
		{
			"<leader>f:",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>mH",
			function()
				require("fzf-lua").notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>f*",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- 	-- search
		{
			'<leader>f"',
			function()
				require("fzf-lua").registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>f?",
			function()
				require("fzf-lua").search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>fm",
			function()
				require("fzf-lua").marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fM",
			function()
				require("fzf-lua").manpages()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fl",
			function()
				require("fzf-lua").lsp_document_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fL",
			function()
				require("fzf-lua").lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>fql",
			function()
				require("fzf-lua").quickfix()
			end,
			desc = "quickfix list",
		},
		{
			"<leader>fqs",
			function()
				require("fzf-lua").quickfix_stack()
			end,
			desc = "quickfix list",
		},

		{
			"<leader>fqg",
			function()
				require("fzf-lua").grep_quickfix()
			end,
			desc = "grep the quickfix list",
		},
		-- 	-- git
		-- 	{
		-- 		"<leader>gb",
		-- 		function()
		-- 			require("fzf-lua").git_branches()
		-- 		end,
		-- 		desc = "Git Branches",
		-- 	},
		-- 	{
		-- 		"<leader>gl",
		-- 		function()
		-- 			require("fzf-lua").git_log()
		-- 		end,
		-- 		desc = "Git Log",
		-- 	},
		-- 	{
		-- 		"<leader>gL",
		-- 		function()
		-- 			require("fzf-lua").git_log_line()
		-- 		end,
		-- 		desc = "Git Log Line",
		-- 	},
		-- 	{
		-- 		"<leader>gS",
		-- 		function()
		-- 			require("fzf-lua").git_stash()
		-- 		end,
		-- 		desc = "Git Stash",
		-- 	},
		-- 	{
		-- 		"<leader>gd",
		-- 		function()
		-- 			require("fzf-lua").git_diff()
		-- 		end,
		-- 		desc = "Git Diff (Hunks)",
		-- 	},
		-- 	{
		-- 		"<leader>gf",
		-- 		function()
		-- 			require("fzf-lua").git_log_file()
		-- 		end,
		-- 		desc = "Git Log File",
		-- 	},
		-- 	-- Grep
		-- 	{
		-- 		"<leader>sb",
		-- 		function()
		-- 			require("fzf-lua").lines()
		-- 		end,
		-- 		desc = "Buffer Lines",
		-- 	},
		-- 	{
		-- 		"<leader>sB",
		-- 		function()
		-- 			require("fzf-lua").grep_buffers()
		-- 		end,
		-- 		desc = "Grep Open Buffers",
		-- 	},
		-- 	{
		-- 		"<leader>sa",
		-- 		function()
		-- 			require("fzf-lua").autocmds()
		-- 		end,
		-- 		desc = "Autocmds",
		-- 	},
		-- 	{
		-- 		"<leader>sb",
		-- 		function()
		-- 			require("fzf-lua").lines()
		-- 		end,
		-- 		desc = "Buffer Lines",
		-- 	},
		-- 	{
		-- 		"<leader>sc",
		-- 		function()
		-- 			require("fzf-lua").command_history()
		-- 		end,
		-- 		desc = "Command History",
		-- 	},
		-- 	{
		-- 		"<leader>sC",
		-- 		function()
		-- 			require("fzf-lua").commands()
		-- 		end,
		-- 		desc = "Commands",
		-- 	},
		-- 	{
		-- 		"<leader>sd",
		-- 		function()
		-- 			require("fzf-lua").diagnostics()
		-- 		end,
		-- 		desc = "Diagnostics",
		-- 	},
		-- 	{
		-- 		"<leader>sD",
		-- 		function()
		-- 			require("fzf-lua").diagnostics_buffer()
		-- 		end,
		-- 		desc = "Buffer Diagnostics",
		-- 	},
		-- 	{
		-- 		"<leader>sH",
		-- 		function()
		-- 			require("fzf-lua").highlights()
		-- 		end,
		-- 		desc = "Highlights",
		-- 	},
		-- 	{
		-- 		"<leader>si",
		-- 		function()
		-- 			require("fzf-lua").icons()
		-- 		end,
		-- 		desc = "Icons",
		-- 	},
		-- 	{
		-- 		"<leader>sj",
		-- 		function()
		-- 			require("fzf-lua").jumps()
		-- 		end,
		-- 		desc = "Jumps",
		-- 	},
		-- 	{
		-- 		"<leader>sl",
		-- 		function()
		-- 			require("fzf-lua").loclist()
		-- 		end,
		-- 		desc = "Location List",
		-- 	},
		-- 	{
		-- 		"<leader>sp",
		-- 		function()
		-- 			require("fzf-lua").lazy()
		-- 		end,
		-- 		desc = "Search for Plugin Spec",
		-- 	},
		-- 	{
		-- 		"<leader>sq",
		-- 		function()
		-- 			require("fzf-lua").qflist()
		-- 		end,
		-- 		desc = "Quickfix List",
		-- 	},
		-- 	{
		-- 		"<leader>sR",
		-- 		function()
		-- 			require("fzf-lua").resume()
		-- 		end,
		-- 		desc = "Resume",
		-- 	},
		-- 	{
		-- 		"<leader>su",
		-- 		function()
		-- 			require("fzf-lua").undo()
		-- 		end,
		-- 		desc = "Undo History",
		-- 	},
		-- 	-- LSP
		-- 	{
		-- 		"gd",
		-- 		function()
		-- 			require("fzf-lua").lsp_definitions()
		-- 		end,
		-- 		desc = "Goto Definition",
		-- 	},
		-- 	{
		-- 		"gD",
		-- 		function()
		-- 			require("fzf-lua").lsp_declarations()
		-- 		end,
		-- 		desc = "Goto Declaration",
		-- 	},
		-- 	{
		-- 		"gr",
		-- 		function()
		-- 			require("fzf-lua").lsp_references()
		-- 		end,
		-- 		nowait = true,
		-- 		desc = "References",
		-- 	},
		-- 	{
		-- 		"gI",
		-- 		function()
		-- 			require("fzf-lua").lsp_implementations()
		-- 		end,
		-- 		desc = "Goto Implementation",
		-- 	},
		-- 	{
		-- 		"gy",
		-- 		function()
		-- 			require("fzf-lua").lsp_type_definitions()
		-- 		end,
		-- 		desc = "Goto T[y]pe Definition",
		-- 	},
	},
}

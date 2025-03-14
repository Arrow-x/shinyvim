return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			layout = "ivy",
		},
	},
	keys = {
		{
			"<leader>fF",
			function()
				Snacks.picker.files({ exclude = { "^.git", "^.godot", "*.uid" }, hidden = true, ignored = false })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers({
					layout = {
						preset = "vscode",
					},
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep({ exclude = { "^.git", "^.godot", "*.uid" } })
			end,
			desc = "Grep",
		},
		{
			"<leader>f:",
			function()
				Snacks.picker.command_history({
					layout = {
						preset = "vscode",
					},
				})
			end,
			desc = "Command History",
		},
		{
			"<leader>mH",
			function()
				Snacks.picker.notifications({
					layout = {
						preset = "vscode",
					},
				})
			end,
			desc = "Notification History",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.git_files({ exclude = { "^.git", "^.godot", "*.uid" } })
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>f*",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- 	-- search
		{
			'<leader>f"',
			function()
				Snacks.picker.registers({
					layout = {
						preset = "select",
					},
				})
			end,
			desc = "Registers",
		},
		{
			"<leader>f?",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.colorschemes({
					layout = {
						preset = "select",
					},
				})
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fM",
			function()
				Snacks.picker.man({
					layout = {
						preset = "select",
					},
				})
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fL",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- 	{
		-- 		"<leader>e",
		-- 		function()
		-- 			Snacks.explorer()
		-- 		end,
		-- 		desc = "File Explorer",
		-- 	},
		-- 	-- find
		-- 	{
		-- 		"<leader>fb",
		-- 		function()
		-- 			Snacks.picker.buffers()
		-- 		end,
		-- 		desc = "Buffers",
		-- 	},
		-- 	{
		-- 		"<leader>fc",
		-- 		function()
		-- 			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		-- 		end,
		-- 		desc = "Find Config File",
		-- 	},
		-- {
		-- 	"<leader>fp",
		-- 	function()
		-- 		Snacks.picker.projects()
		-- 	end,
		-- 	desc = "Projects",
		-- },
		-- 	-- git
		-- 	{
		-- 		"<leader>gb",
		-- 		function()
		-- 			Snacks.picker.git_branches()
		-- 		end,
		-- 		desc = "Git Branches",
		-- 	},
		-- 	{
		-- 		"<leader>gl",
		-- 		function()
		-- 			Snacks.picker.git_log()
		-- 		end,
		-- 		desc = "Git Log",
		-- 	},
		-- 	{
		-- 		"<leader>gL",
		-- 		function()
		-- 			Snacks.picker.git_log_line()
		-- 		end,
		-- 		desc = "Git Log Line",
		-- 	},
		-- 	{
		-- 		"<leader>gS",
		-- 		function()
		-- 			Snacks.picker.git_stash()
		-- 		end,
		-- 		desc = "Git Stash",
		-- 	},
		-- 	{
		-- 		"<leader>gd",
		-- 		function()
		-- 			Snacks.picker.git_diff()
		-- 		end,
		-- 		desc = "Git Diff (Hunks)",
		-- 	},
		-- 	{
		-- 		"<leader>gf",
		-- 		function()
		-- 			Snacks.picker.git_log_file()
		-- 		end,
		-- 		desc = "Git Log File",
		-- 	},
		-- 	-- Grep
		-- 	{
		-- 		"<leader>sb",
		-- 		function()
		-- 			Snacks.picker.lines()
		-- 		end,
		-- 		desc = "Buffer Lines",
		-- 	},
		-- 	{
		-- 		"<leader>sB",
		-- 		function()
		-- 			Snacks.picker.grep_buffers()
		-- 		end,
		-- 		desc = "Grep Open Buffers",
		-- 	},
		-- 	{
		-- 		"<leader>sg",
		-- 		function()
		-- 			Snacks.picker.grep()
		-- 		end,
		-- 		desc = "Grep",
		-- 	},
		-- 	{
		-- 		"<leader>sa",
		-- 		function()
		-- 			Snacks.picker.autocmds()
		-- 		end,
		-- 		desc = "Autocmds",
		-- 	},
		-- 	{
		-- 		"<leader>sb",
		-- 		function()
		-- 			Snacks.picker.lines()
		-- 		end,
		-- 		desc = "Buffer Lines",
		-- 	},
		-- 	{
		-- 		"<leader>sc",
		-- 		function()
		-- 			Snacks.picker.command_history()
		-- 		end,
		-- 		desc = "Command History",
		-- 	},
		-- 	{
		-- 		"<leader>sC",
		-- 		function()
		-- 			Snacks.picker.commands()
		-- 		end,
		-- 		desc = "Commands",
		-- 	},
		-- 	{
		-- 		"<leader>sd",
		-- 		function()
		-- 			Snacks.picker.diagnostics()
		-- 		end,
		-- 		desc = "Diagnostics",
		-- 	},
		-- 	{
		-- 		"<leader>sD",
		-- 		function()
		-- 			Snacks.picker.diagnostics_buffer()
		-- 		end,
		-- 		desc = "Buffer Diagnostics",
		-- 	},
		-- 	{
		-- 		"<leader>sH",
		-- 		function()
		-- 			Snacks.picker.highlights()
		-- 		end,
		-- 		desc = "Highlights",
		-- 	},
		-- 	{
		-- 		"<leader>si",
		-- 		function()
		-- 			Snacks.picker.icons()
		-- 		end,
		-- 		desc = "Icons",
		-- 	},
		-- 	{
		-- 		"<leader>sj",
		-- 		function()
		-- 			Snacks.picker.jumps()
		-- 		end,
		-- 		desc = "Jumps",
		-- 	},
		-- 	{
		-- 		"<leader>sl",
		-- 		function()
		-- 			Snacks.picker.loclist()
		-- 		end,
		-- 		desc = "Location List",
		-- 	},
		-- 	{
		-- 		"<leader>sp",
		-- 		function()
		-- 			Snacks.picker.lazy()
		-- 		end,
		-- 		desc = "Search for Plugin Spec",
		-- 	},
		-- 	{
		-- 		"<leader>sq",
		-- 		function()
		-- 			Snacks.picker.qflist()
		-- 		end,
		-- 		desc = "Quickfix List",
		-- 	},
		-- 	{
		-- 		"<leader>sR",
		-- 		function()
		-- 			Snacks.picker.resume()
		-- 		end,
		-- 		desc = "Resume",
		-- 	},
		-- 	{
		-- 		"<leader>su",
		-- 		function()
		-- 			Snacks.picker.undo()
		-- 		end,
		-- 		desc = "Undo History",
		-- 	},
		-- 	-- LSP
		-- 	{
		-- 		"gd",
		-- 		function()
		-- 			Snacks.picker.lsp_definitions()
		-- 		end,
		-- 		desc = "Goto Definition",
		-- 	},
		-- 	{
		-- 		"gD",
		-- 		function()
		-- 			Snacks.picker.lsp_declarations()
		-- 		end,
		-- 		desc = "Goto Declaration",
		-- 	},
		-- 	{
		-- 		"gr",
		-- 		function()
		-- 			Snacks.picker.lsp_references()
		-- 		end,
		-- 		nowait = true,
		-- 		desc = "References",
		-- 	},
		-- 	{
		-- 		"gI",
		-- 		function()
		-- 			Snacks.picker.lsp_implementations()
		-- 		end,
		-- 		desc = "Goto Implementation",
		-- 	},
		-- 	{
		-- 		"gy",
		-- 		function()
		-- 			Snacks.picker.lsp_type_definitions()
		-- 		end,
		-- 		desc = "Goto T[y]pe Definition",
		-- 	},
	},
}

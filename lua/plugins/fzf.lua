return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
		},
		{
			"elanmed/fzf-lua-frecency.nvim",
			opts = {
				cwd_only = true,
			},
		},
	},
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	config = function()
		require("fzf-lua").setup({
			file_ignore_patterns = { "%.uid$" },
			-- winopts = {
			-- 	split = "belowright new",
			-- },
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
			"<leader>fF",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>ff",
			function()
				require("fzf-lua-frecency").frecency()
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
				require("fzf-lua").live_grep({ cmd = "rg --no-ignore --line-number --column --hidden" })
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
		{
			"<leader>gb",
			function()
				require("fzf-lua").git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				require("fzf-lua").git_reflog()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gS",
			function()
				require("fzf-lua").git_stash()
			end,
			desc = "Git Stash",
		},
	},
}

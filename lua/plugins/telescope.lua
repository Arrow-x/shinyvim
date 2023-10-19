return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	tag = "0.1.4",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				file_ignore_patterns = { "^.git" },
				prompt_prefix = string.format("%s ", ""),
				selection_caret = string.format("%s ", "❯"),
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
					},
					n = { ["q"] = actions.close },
				},
			},
			pickers = {
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				local fopts = { hidden = true } -- define here if you want to define something
				local ok = pcall(require("telescope.builtin").git_files)
				if not ok then
					require("telescope.builtin").find_files(fopts)
				end
			end,
			desc = "Find Files Git",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Show Buffers",
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").colorscheme()
			end,
			desc = "Colorscheme",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Find Help",
		},
		{
			"<leader>fM",
			function()
				require("telescope.builtin").man_pages()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Open Recent File",
		},
		{
			"<leader>fR",
			function()
				require("telescope.builtin").registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>fk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fC",
			function()
				require("telescope.builtin").commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Find word",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))
			end,
			desc = "Buffers",
		},
		{
			"<leader>f*",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Search for word under cursor",
		},
	},
}

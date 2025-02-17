return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			require("telescope").load_extension("fzf")
			telescope.setup({
				defaults = {
					file_ignore_patterns = { "^.git", ".*.uid$" },
					prompt_prefix = string.format("%s ", ""),
					selection_caret = string.format("%s ", "❯"),
					path_display = { "truncate" },
					mappings = {
						i = {
							["<C-j>"] = actions.cycle_history_next,
							["<C-k>"] = actions.cycle_history_prev,
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-h>"] = "which_key",
						},
						n = { ["q"] = actions.close },
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob", -- this flag allows you to hide exclude these files and folders from your search 👇
						"!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,**/.godot/**,**/.import/**}",
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
			{
				"nvim-telescope/telescope-frecency.nvim",
				config = function()
					require("telescope").setup({
						extensions = {
							frecency = {
								show_filter_column = false,
							},
							auto_validate = true,
						},
						require("telescope").load_extension("frecency"),
					})
				end,
			},
		},
		-- keys = {
		-- 	{
		-- 		"<leader>ff",
		-- 		function()
		-- 			require("telescope").extensions.frecency.frecency({
		-- 				workspace = "CWD",
		-- 				path_display = { "shorten" },
		-- 				theme = "ivy",
		-- 				hide_current_buffer = true,
		-- 			})
		-- 		end,
		-- 		desc = "Telescope frecency",
		-- 	},
		-- 	-- {
		-- 	-- 	"<leader>ff",
		-- 	-- 	function()
		-- 	-- 		local fopts = { hidden = true } -- define here if you want to define something
		-- 	-- 		local ok = pcall(require("telescope.builtin").git_files)
		-- 	-- 		if not ok then
		-- 	-- 			require("telescope.builtin").find_files(fopts)
		-- 	-- 		end
		-- 	-- 	end,
		-- 	-- 	desc = "Find Files Git",
		-- 	-- },
		-- 	{
		-- 		"<leader>fb",
		-- 		function()
		-- 			require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
		-- 				previewer = true,
		-- 				sort_mru = true,
		-- 				ignore_current_buffer = true,
		-- 			}))
		-- 		end,
		-- 		desc = "Find Buffers",
		-- 	},
		-- 	{
		-- 		"<leader>fF",
		-- 		function()
		-- 			require("telescope.builtin").find_files({ hidden = true })
		-- 		end,
		-- 		desc = "Find Files",
		-- 	},
		-- 	{
		-- 		"<leader>fc",
		-- 		function()
		-- 			require("telescope.builtin").colorscheme(
		-- 				require("telescope.themes").get_dropdown({ enable_preview = true })
		-- 			)
		-- 		end,
		-- 		desc = "Find Colorscheme",
		-- 	},
		-- 	{
		-- 		"<leader>fh",
		-- 		function()
		-- 			require("telescope.builtin").help_tags(
		-- 				require("telescope.themes").get_dropdown({ previewer = false })
		-- 			)
		-- 		end,
		-- 		desc = "Find in Help",
		-- 	},
		-- 	{
		-- 		"<leader>fM",
		-- 		function()
		-- 			require("telescope.builtin").man_pages(
		-- 				require("telescope.themes").get_dropdown({ previewer = false })
		-- 			)
		-- 		end,
		-- 		desc = "Find in Man Pages",
		-- 	},
		-- 	-- {
		-- 	-- 	"<leader>fr",
		-- 	-- 	function()
		-- 	-- 		require("telescope.builtin").oldfiles()
		-- 	-- 	end,
		-- 	-- 	desc = "Find Recent File",
		-- 	-- },
		-- 	{
		-- 		"<leader>fR",
		-- 		function()
		-- 			require("telescope.builtin").registers()
		-- 		end,
		-- 		desc = "Find in Registers",
		-- 	},
		-- 	{
		-- 		"<leader>fk",
		-- 		function()
		-- 			require("telescope.builtin").keymaps()
		-- 		end,
		-- 		desc = "Find in Keymaps",
		-- 	},
		-- 	{
		-- 		"<leader>fC",
		-- 		function()
		-- 			require("telescope.builtin").commands(
		-- 				require("telescope.themes").get_dropdown({ previewer = false })
		-- 			)
		-- 		end,
		-- 		desc = "Find in Commands",
		-- 	},
		-- 	{
		-- 		"<leader>fg",
		-- 		function()
		-- 			require("telescope.builtin").live_grep()
		-- 		end,
		-- 		desc = "Find word",
		-- 	},
		-- 	{
		-- 		"<leader>f*",
		-- 		function()
		-- 			require("telescope.builtin").grep_string()
		-- 		end,
		-- 		desc = "Find in for word under cursor",
		-- 	},
		-- 	{
		-- 		"<leader>fs",
		-- 		function()
		-- 			require("telescope.builtin").git_status()
		-- 		end,
		-- 		desc = "Find in currently modified files",
		-- 	},
		-- 	{
		-- 		"<leader>f'",
		-- 		function()
		-- 			require("telescope.builtin").marks(require("telescope.themes").get_dropdown({ previewer = true }))
		-- 		end,
		-- 		desc = "Find in current marks",
		-- 	},
		-- 	{
		-- 		"<leader>f/",
		-- 		function()
		-- 			require("telescope.builtin").live_grep({
		-- 				grep_open_files = true,
		-- 				prompt_title = "Live Grep in Open Files",
		-- 			})
		-- 		end,
		-- 		desc = "Find Grep in Open Files",
		-- 	},
		-- 	{
		-- 		"<leader>fp",
		-- 		function()
		-- 			require("telescope.builtin").resume()
		-- 		end,
		-- 		desc = "Find from the [P]revious search",
		-- 	},
		},
	-- },
}

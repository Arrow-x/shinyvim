return {
	"nvim-telescope/telescope.nvim",
	config = function()
	end,
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
			"<leader>fp",
			function()
				require("telescope.builtin").projects()
			end,
			desc = "Projects",
		},

		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))
			end,
			desc = "Buffers",
		},
	},
}

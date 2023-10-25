return {
	"Arrow-x/git-worktree.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>gww",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "List Worktrees",
		},
		{
			"<leader>gwa",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "Create git worktree",
		},
	},
}

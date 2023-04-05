return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>gw",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
		},
	},
}

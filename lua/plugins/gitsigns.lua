return {
	"lewis6991/gitsigns.nvim",
	event = { "VeryLazy" },
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function()
			local gitsigns = package.loaded.gitsigns

			local map = vim.keymap.set

			map("n", "<leader>gn", function()
				gitsigns.next_hunk()
			end, { desc = "Next Hunk" })
			map("n", "<leader>gp", function()
				gitsigns.prev_hunk()
			end, { desc = "Prev Hunk" })
			map("n", "<leader>gl", function()
				gitsigns.blame_line()
			end, { desc = "Blame" })
			map("n", "<leader>gP", function()
				gitsigns.preview_hunk()
			end, { desc = "Preview Hunk" })
			map("n", "<leader>gr", function()
				gitsigns.reset_hunk()
			end, { desc = "Reset Hunk" })
			map("n", "<leader>gR", function()
				gitsigns.reset_buffer()
			end, { desc = "Reset Buffer" })
			map("n", "<leader>gs", function()
				gitsigns.stage_hunk()
			end, { desc = "Stage Hunk" })
			map("n", "<leader>gu", function()
				gitsigns.undo_stage_hunk()
			end, { desc = "Undo Stage Hunk" })
			map("n", "<leader>gd", function()
				vim.cmd("Gitsigns diffthis HEAD end")
			end, { desc = "Show Diff" })
		end,
	},
}
-- stylua: ignore start

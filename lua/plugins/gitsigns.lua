return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = {
				hl = "GitSignsChange",
				text = "▎",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
	},
	config = function()
		local keymap = vim.keymap.set
		local gitsigns = require("gitsigns")

		keymap("n", "<leader>gn", function()
			gitsigns.next_hunk()
		end, { desc = "Next Hunk" })
		keymap("n", "<leader>gp", function()
			gitsigns.prev_hunk()
		end, { desc = "Prev Hunk" })
		keymap("n", "<leader>gl", function()
			gitsigns.blame_line()
		end, { desc = "Blame" })
		keymap("n", "<leader>gP", function()
			gitsigns.preview_hunk()
		end, { desc = "Preview Hunk" })
		keymap("n", "<leader>gr", function()
			gitsigns.reset_hunk()
		end, { desc = "Reset Hunk" })
		keymap("n", "<leader>gR", function()
			gitsigns.reset_buffer()
		end, { desc = "Reset Buffer" })
		keymap("n", "<leader>gs", function()
			gitsigns.stage_hunk()
		end, { desc = "Stage Hunk" })
		keymap("n", "<leader>gu", function()
			gitsigns.undo_stage_hunk()
		end, { desc = "Undo Stage Hunk" })
		keymap("n", "<leader>gd", function()
			vim.cmd("Gitsigns diffthis HEAD end")
		end, { desc = "Show this file's Diff" })
		gitsigns.setup()
	end,
}

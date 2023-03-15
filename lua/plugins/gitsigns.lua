return {
	-- BUG: This calls withit Toruble.nvim for some reason.
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		on_attach = function(buffer)
			local gitsigns = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

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

return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#000000",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		})
		vim.notify = require("notify")
		vim.keymap.set("n", "<leader>un", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, { desc = "Delete all Notifications" })
	end,
}

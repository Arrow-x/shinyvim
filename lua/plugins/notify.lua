return {
	"rcarriga/nvim-notify",
	event = { "VeryLazy" },
	config = function()
		require("notify").setup({
			background_colour = "#000000",
			timeout = 3000,
			-- max_height = function()
			-- 	return math.floor(vim.o.lines * 0.75)
			-- end,
			-- max_width = function()
			-- 	return math.floor(vim.o.columns * 0.75)
			-- end,
			-- render = "wrapped-compact",
			-- stages = "slide",
		})
		vim.notify = require("notify")
		vim.keymap.set("n", "<leader>mh", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, { desc = "Delete all Notifications" })

		if shinyvim.has("snacks.nvim") then
			vim.keymap.set("n", "<leader>mH", function()
				Snacks.notifier.show_history()
			end, { desc = "Show Notifications history" })
		end
	end,
}

local status_ok, _ = pcall(require, "illuminate")
if not status_ok then
	return
end

-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }

vim.keymap.set("n", "<a-n>", function()
	require("illuminate").next_reference({ wrap = true })
end, { noremap = true })
vim.keymap.set("n", "<a-p>", function()
	require("illuminate").next_reference({ reverse = true, wrap = true })
end, { noremap = true })

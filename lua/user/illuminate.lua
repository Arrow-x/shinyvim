local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end

vim.keymap.set("n", "<a-n>", function()
	illuminate.next_reference({ wrap = true })
end, { noremap = true })
vim.keymap.set("n", "<a-p>", function()
	illuminate.next_reference({ reverse = true, wrap = true })
end, { noremap = true })

illuminate.configure({
	delay = 0,
	filetypes_denylist = {
		"alpha",
		"NvimTree",
		"TelescopePrompt",
	},

	modes_denylist = { "i" },
})

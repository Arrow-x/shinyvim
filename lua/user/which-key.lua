local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local pluging_keymaps = {
	{ plugin = "nvim-dap", prefix = "d", desc = "Debuging" },
	{ plugin = "telescope.nvim", prefix = "f", desc = "Search" },
	{ plugin = "gitsigns.nvim", prefix = "g", desc = "Git integration" },
	{ plugin = "vimwiki", prefix = "w", desc = "VimWiki Notes" },
	{ plugin = "taskwiki", prefix = "t", desc = "TaskWarrior for VimWiki" },
	{ plugin = "toggleterm.nvim", prefix = "`", desc = "A Terminal in your Terminal" },
	{ plugin = "nvim-lspconfig", prefix = "l", desc = "LSP" },
}

local mappings = {
	P = { name = "Packer" },
	p = { name = "Paste to system clipboard" },
	y = { name = "Copy to System clipboard" },
}

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local which_key_cmd = vim.api.nvim_create_augroup("which_key_cmd", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	group = which_key_cmd,
	callback = function()
		for _, p in pairs(pluging_keymaps) do
			if shinyvim.is_available(p.plugin) then
				if not mappings[p.prefix] then
					mappings[p.prefix] = { name = p.desc }
				end
			end
		end

		which_key.register(mappings, opts)
	end,
})

which_key.setup({
	plugins = {
		spelling = { enabled = true },
		presets = { operators = false },
	},
	window = {
		border = "rounded",
		padding = { 2, 2, 2, 2 },
	},
})

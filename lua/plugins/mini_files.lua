return {
	"echasnovski/mini.files",
	lazy = false,

	init = function()
		vim.g.loaded_netrw = true -- disable netrw
		vim.g.loaded_netrwFileHandlers = true -- disable netrw
		vim.g.loaded_netrwPlugin = true -- disable netrw
		vim.g.loaded_netrwSettngs = true -- disable netrw
	end,

	config = function()
		local show_dotfiles = true

		local filter_show = function(fs_entry)
			return true
		end

		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end

		local function gio_open()
			local fs_entry = require("mini.files").get_fs_entry()
			vim.notify(vim.inspect(fs_entry))
			vim.fn.system(string.format("gio open '%s'", fs_entry.path))
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			require("mini.files").refresh({ content = { filter = new_filter } })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				-- Tweak left-hand side of mapping to your liking
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
				-- vim.keymap.set("n", "-", require("mini.files").close, { buffer = buf_id })
				vim.keymap.set("n", "o", gio_open, { buffer = buf_id })
			end,
		})
		require("mini.files").setup({
			options = {
				use_as_default_explorer = true,
			},
		})
	end,

	keys = {
		{
			"<leader>e",
			function()
				if not MiniFiles.close() then
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end
			end,
			desc = "Opens Mini.Files",
		},
	},
}

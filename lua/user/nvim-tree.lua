local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = { "l", "<CR>", "o" }, action = "edit" },
			},
		},
	},
	update_focused_file = {
		enable = true,
		debounce_delay = 15,
		update_root = false,
		ignore_list = {},
	},
	renderer = {
		add_trailing = false,
		group_empty = true,
		highlight_git = true,
		full_name = false,
		highlight_opened_files = "none",
		root_folder_label = ":~:s?$?/..?",
		indent_width = 2,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
	},
})

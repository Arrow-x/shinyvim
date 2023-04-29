return {
	"as-jpq/coq_nvim",
	branch = "coq",
	dependencies = {
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
	},
	build = ":COQdeps",
	event = { "BufReadPre", "BufNewFile" },
	-- event = "InsertEnter",
	init = function()
		-- vim.o.completeopt = "menuone,noselect,noinsert"
		-- vim.o.showmode = false

		local kind_icons = {
			Text = "",
			Method = "m",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		local border = {
			{ "╭", "CmpBorder" },
			{ "─", "CmpBorder" },
			{ "╮", "CmpBorder" },
			{ "│", "CmpBorder" },
			{ "╯", "CmpBorder" },
			{ "─", "CmpBorder" },
			{ "╰", "CmpBorder" },
			{ "│", "CmpBorder" },
		}

		vim.g.coq_settings = {
			auto_start = "shut-up",
			keymap = {
				recommended = true,
			},
			clients = {
				tabnine = {
					enabled = false,
				},
				tree_sitter = {
					enabled = false,
					-- weight_adjust = 1.0,
				},
				paths = {
					path_seps = {
						"/",
					},
				},
				buffers = {
					match_syms = true,
				},
			},
			display = {
				ghost_text = {
					enabled = true,
				},
				icons = {
					mappings = kind_icons,
				},
				preview = {
					border = border,
				},
			},
		}
	end,
	config = function()
		local coq = require("coq")
		coq.Now() -- Start coq
	end,
}

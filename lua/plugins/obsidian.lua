return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	event = {
		"BufReadPre /home/arrowx/Notes-And-Tasks/Obsidian/.local/share/Obsidian/**.md",
		"BufNewFile /home/arrowx/Notes-And-Tasks/Obsidian/.local/share/Obsidian/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		dir = "~/Notes-And-Tasks/Obsidian/.local/share/Obsidian", -- no need to call 'vim.fn.expand' here
		notes_subdir = "notes", -- Optional, if you keep notes in a specific subdirectory of your vault.
		daily_notes = { -- Optional, if you keep daily notes in a separate directory.
			folder = "notes/dailies",
		},
		completion = { -- Optional, completion.
			nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
		},
		-- templates = { -- Optional, for templates (see below).
		-- 	subdir = "shiny-templates/",
		-- 	date_format = "%Y-%m-%d-%a",
		-- 	time_format = "%H:%M",
		-- },
		mappings = { -- Optional, key mappings.
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			-- ["gf"] = require("obsidian.mapping").gf_passthrough(),
		},
		-- Optional, customize how names/IDs for new notes are created.
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				local suffix = ""
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
				return tostring(os.time()) .. "-" .. suffix
			end
			-- return string(os.time()) .. "-" .. suffix
		end,
		-- Optional, set to true if you don't want Obsidian to manage frontmatter.
		disable_frontmatter = true,
		-- Optional, alternatively you can customize the frontmatter data.
		-- note_frontmatter_func = function(note)
		-- 	-- This is equivalent to the default frontmatter function.
		-- 	local out = { id = note.id, aliases = note.aliases, tags = note.tags }
		-- 	-- `note.metadata` contains any manually added fields in the frontmatter.
		-- 	-- So here we just make sure those fields are kept in the frontmatter.
		-- 	if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
		-- 		for k, v in pairs(note.metadata) do
		-- 			out[k] = v
		-- 		end
		-- 	end
		-- 	return out
		-- end,
		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			-- vim.fn.jobstart({ "open", url }) -- Mac OS
			vim.fn.jobstart({ "xdg-open", url }) -- linux
		end,
		-- Optional, set to true if you use the Obsidian Advanced URI plugin.
		-- https://github.com/Vinzent03/obsidian-advanced-uri
		-- use_advanced_uri = true,
		-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
		open_app_foreground = false,

		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "assets/imgs", -- This is the default
			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
			-- The is the default implementation.
			---@param client obsidian.Client
			---@param path Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				local link_path
				local vault_relative_path = client:vault_relative_path(path)
				if vault_relative_path ~= nil then
					-- Use relative path if the image is saved in the vault dir.
					link_path = vault_relative_path
				else
					-- Otherwise use the absolute path.
					link_path = tostring(path)
				end
				local display_name = vim.fs.basename(link_path)
				return string.format("![%s](%s)", display_name, link_path)
			end,
		},
		ui = {
			enable = true,
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			-- Replace the above with this if you don't have a patched font:
			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				-- ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)

		-- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
		-- see also: 'follow_url_func' config option above.
		vim.keymap.set("n", "<cr>", function()
			if require("obsidian").util.cursor_on_markdown_link() then
				return "<cmd>ObsidianFollowLink<CR>"
			else
				return "<cr>"
			end
		end, { noremap = false, expr = true })

		vim.keymap.set("v", "<cr>", function()
			return ":'<,'>ObsidianLinkNew<cr>"
		end, { noremap = false, expr = true })

		vim.keymap.set("n", "<leader>w<leader>w", function()
			vim.cmd("ObsidianToday")
		end)
		vim.keymap.set("n", "<leader>w<leader>y", function()
			vim.cmd("ObsidianYesterday")
		end)
	end,
}

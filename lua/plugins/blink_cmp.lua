return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"ribru17/blink-cmp-spell",
	},
	event = "InsertEnter",

	-- use a release tag to download pre-built binaries
	version = "v0.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	opts = {
		keymap = { preset = "default", ["<C-l>"] = { "select_and_accept" } },
		appearance = {
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "spell" },
			-- optionally disable cmdline completions
			-- cmdline = {},
			providers = {
				spell = {
					name = "Spell",
					module = "blink-cmp-spell",
					opts = {
						max_entries = 15,
					},
				},
			},
		},
		completion = {
			list = {
				selection = "preselect",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
		},
		fuzzy = {
			sorts = {
				function(a, b)
					local sort = require("blink.cmp.fuzzy.sort")
					if a.source_id == "spell" and b.source_id == "spell" then
						return sort.label(a, b)
					end
				end,
				-- This is the normal default order, which we fall back to
				"score",
				"kind",
				"label",
			},
		},
		-- experimental signature help support
		signature = { enabled = true, window = {
			border = "single",
		} },
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}

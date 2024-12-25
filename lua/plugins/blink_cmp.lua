return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.compat",
			-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
			version = "*",
			-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
			lazy = true,
			-- make sure to set opts so that lazy.nvim calls blink.compat's setup
			opts = {},
		},
		"f3fora/cmp-spell",
	},
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},

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
					name = "spell",
					module = "blink.compat.source",
					opts = {
						-- max_entries = 15,
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
						preselect_correct_word = true,
					},
				},
			},
		},
		completion = {
			list = {
				selection = function(ctx)
					local mode = ctx.mode
					return "preselect"
				end,
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
		},
		-- experimental signature help support
		signature = {
			enabled = true,
			window = {
				border = "single",
			},
		},
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}

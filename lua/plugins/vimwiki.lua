return {
	"vimwiki/vimwiki",
	init = function()
		vim.g.vimwiki_list = {
			{
				path = "~/.local/share/vimwiki/",
				template_path = "~/.local/share/vimwiki/templates/",
				syntax = "markdown",
				path_html = "~/.local/share/vimwiki/site_html/",
				custom_wiki2html = "vimwiki_markdown",
				template_ext = ".tpl",
				links_space_char = "_",
			},
		}
		vim.g.vimwiki_global_ext = 0
	end,
	keys = {
		"<leader>w",
	},
}

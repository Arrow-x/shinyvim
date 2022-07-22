vim.cmd(
	"let g:vimwiki_list = [{ 'path': '~/.local/share/vimwiki', 'template_path': '~/.local/share/vimwiki/templates/', 'template_default': 'default', 'syntax': 'markdown', 'ext': '.md', 'path_html': '~/.local/share/vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown', 'template_ext': '.tpl', 'links_space_char': '_'}]"
)
vim.cmd("let g:vimwiki_markdown_link_ext = 1")
vim.cmd("let g:vimwiki_global_ext = 0")

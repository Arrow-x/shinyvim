return {
	"preservim/vim-markdown",
	ft = "markdown",
	init = function()
		vim.g.vim_markdown_toc_autofit = 1
		vim.g.vim_markdown_no_extensions_in_markdown = 1
		vim.g.vim_markdown_auto_insert_bullets = 0
		vim.g.vim_markdown_new_list_item_indent = 0
		vim.g.vim_markdown_folding_level = 6
	end,
}

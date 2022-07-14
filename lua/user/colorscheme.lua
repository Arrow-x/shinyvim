local colorscheme = "tokyonight"

if colorscheme == "tokyonight" then
	vim.g.tokyonight_transparent = true
	vim.g.tokyonight_colors = { bg_float = "none" }
	-- vim.g.tokyonight_dark_sidebar = true
	vim.g.tokyonight_transparent_sidebar = true
	vim.g.tokyonight_sidebars = { "packer" }
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

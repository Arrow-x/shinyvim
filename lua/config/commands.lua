vim.api.nvim_create_user_command("Autoformat", function(opts)
	if opts.bang then
		shinyvim.autoformat = false
	else
		shinyvim.autoformat = true
	end
end, { bang = true })

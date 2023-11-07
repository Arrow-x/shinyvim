vim.api.nvim_create_user_command("Autoformat", function(opts)
	if opts.bang then
		shinyvim.autoformat = false
	else
		shinyvim.autoformat = true
	end
	vim.notify("Autoformating is " .. tostring(shinyvim.autoformat))
end, { bang = true })

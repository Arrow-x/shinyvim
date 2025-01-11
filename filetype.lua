vim.filetype.add({
	extension = {
		conf = "dosini",
		hx = "haxe",
	},
	filename = {
		[".xprofile"] = "sh",
	},
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

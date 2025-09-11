local uv = vim.loop

local function find_csproj(start_path)
	local dir = vim.fn.fnamemodify(start_path, ":p:h")
	while dir ~= "/" do
		local handle = uv.fs_scandir(dir)
		if handle then
			while true do
				local name, _ = uv.fs_scandir_next(handle)
				if not name then
					break
				end
				if name:match("%.csproj$") then
					return dir .. "/" .. name
				end
			end
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil
end

-- Only configure the compiler if inside a .NET project
local csproj = find_csproj(vim.api.nvim_buf_get_name(0))
if csproj then
	-- Set the dotnet compiler options BEFORE loading the compiler
	vim.g.dotnet_errors_only = true -- show only errors in quickfix
	vim.g.dotnet_show_project_file = false -- show only source file, not project

	-- Load the dotnet compiler
	vim.cmd("compiler dotnet")
end

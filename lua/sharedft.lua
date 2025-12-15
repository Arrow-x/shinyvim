local M = {}
function M.extract_main_scene_path()
	local lines = vim.fn.readfile("project.godot")
	local pattern = 'run/main_scene="%([^%"]+)%"'

	for _, line in ipairs(lines) do
		local matched_path = line:match(pattern)
		if matched_path then
			return matched_path
		end
	end

	return nil
end

function M.get_tcsn_files()
	local result = {}
	local cmd = { "fd", "--type", "f", "--extension", "tscn", "." }
	local ok, fd = pcall(vim.fn.executable, "fd")
	if not ok or fd == 0 then
		cmd = { "find", ".", "-type", "f", "-name", "*.tscn" }
	end

	local stdout = vim.fn.systemlist(cmd)
	for _, line in ipairs(stdout) do
		local clean = line:gsub("^%./", "")
		table.insert(result, clean)
	end
	return result
end

function M.run_godot_async(filepath)
	local ctx = { qf = {} }

	vim.cmd("copen")
	local job_id = vim.fn.jobstart({ "godot", filepath }, {
		stdout_buffered = true,
		stderr_buffered = true,

		on_stdout = function(_, data, _)
			if not data then
				return
			end
			vim.schedule(function()
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(ctx.qf, {
							-- filename = filepath,
							lnum = 0,
							col = 0,
							text = line,
						})
					end
				end
			end)
		end,

		on_stderr = function(_, data, _)
			if not data then
				return
			end
			vim.schedule(function()
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(ctx.qf, {
							-- filename = filepath,
							lnum = 0,
							col = 0,
							text = line,
						})
					end
				end
			end)
		end,

		on_exit = function(_, exit_code, _)
			vim.schedule(function()
				if #ctx.qf == 0 then
					vim.notify("Godot finished (no output)", vim.log.levels.INFO)
				else
					vim.fn.setqflist(ctx.qf, "r")
					vim.cmd("ccl")
				end

				if exit_code ~= 0 then
					vim.notify(string.format("Godot exited with code %d", exit_code), vim.log.levels.WARN)
				end
			end)
		end,
	})

	if job_id <= 0 then
		vim.notify("Failed to start Godot", vim.log.levels.ERROR)
	end
end

function M.select_and_open()
	local files = M.get_tcsn_files()
	if #files == 0 then
		vim.notify("No .gd files found in the current directory", vim.log.levels.WARN)
		return
	end

	vim.ui.select(files, {
		prompt = "Choose a Godot script:",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if not choice then
			return
		end
		M.run_godot_async(choice)
	end)
end

function M.set_up_godot()
	local project_root = vim.fn.getcwd()
	if vim.fn.filereadable(project_root .. "/project.godot") == 1 then
		local p = M.extract_main_scene_path()
		vim.bo.makeprg = string.format("godot %s", p)
		vim.keymap.set("n", "<leader>rr", function()
			M.select_and_open()
		end)
	end
end
return M

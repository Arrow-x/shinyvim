_G.shinyvim = {}

shinyvim.autoformat = true
shinyvim.ts_context_toggle = true

function shinyvim.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

-- other custom logic
function shinyvim.tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\n'
		elseif type(v) == "table" then
			toprint = toprint .. shinyvim.tprint(v, indent + 2) .. ",\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

function shinyvim.get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(shinyvim.root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

function shinyvim.show_only_one_sign_in_sign_column()
	---custom namespace
	local ns = vim.api.nvim_create_namespace("severe-diagnostics")

	---reference to the original handler
	local orig_signs_handler = vim.diagnostic.handlers.signs

	local function filter_diagnostics(diagnostics)
		if not diagnostics then
			return {}
		end

		-- find the "worst" diagnostic per line
		local most_severe = {}
		for _, cur in pairs(diagnostics) do
			local max = most_severe[cur.lnum]

			-- higher severity has lower value (`:h diagnostic-severity`)
			if not max or cur.severity < max.severity then
				most_severe[cur.lnum] = cur
			end
		end

		-- return list of diagnostics
		return vim.tbl_values(most_severe)
	end
	---Overriden diagnostics signs helper to only show the single most relevant sign
	---@see `:h diagnostic-handlers`
	vim.diagnostic.handlers.signs = {
		show = function(_, bufnr, _, opts)
			-- get all diagnostics from the whole buffer rather
			-- than just the diagnostics passed to the handler
			local diagnostics = vim.diagnostic.get(bufnr)

			local filtered_diagnostics = filter_diagnostics(diagnostics)

			-- pass the filtered diagnostics (with the
			-- custom namespace) to the original handler
			orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
		end,

		hide = function(_, bufnr)
			orig_signs_handler.hide(ns, bufnr)
		end,
	}
end

shinyvim.show_only_one_sign_in_sign_column()

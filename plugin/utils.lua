_G.shinyvim = {}

shinyvim.autoformat = true
shinyvim.ts_context_toggle = true

function shinyvim.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

-- other custom logic
function shinyvim.tprint(tbl, indent)
	if not tbl then
		return
	end
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
	---:h diagnostic-handlers`
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

function shinyvim.foldexpr()
	local buf = vim.api.nvim_get_current_buf()
	if vim.b[buf].ts_folds == nil then
		-- as long as we don't have a filetype, don't bother
		-- checking if treesitter is available (it won't)
		if vim.bo[buf].filetype == "" then
			return "0"
		end
		if vim.bo[buf].filetype:find("dashboard") or vim.bo[buf].filetype == "oil" then
			vim.b[buf].ts_folds = false
		else
			vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
		end
	end
	return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

shinyvim.show_only_one_sign_in_sign_column()

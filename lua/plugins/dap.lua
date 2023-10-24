return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		dap.adapters.coreclr = {
			type = "executable",
			command = "/home/arrowx/.local/share/nvim/mason/bin/netcoredbg",
			args = { "--interpreter=vscode" },
		}
		vim.g.dotnet_build_project = function()
			local default_path = vim.fn.getcwd() .. "/"
			if vim.g["dotnet_last_proj_path"] ~= nil then
				default_path = vim.g["dotnet_last_proj_path"]
			end
			local path = vim.fn.input("Path to your *proj file", default_path, "file")
			vim.g["dotnet_last_proj_path"] = path
			local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
			print("")
			print("Cmd to execute: " .. cmd)
			local f = os.execute(cmd)
			if f == 0 then
				print("\nBuild: ✔️ ")
			else
				print("\nBuild: ❌ (code: " .. f .. ")")
			end
		end

		vim.g.dotnet_get_dll_path = function()
			local request = function()
				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end

			if vim.g["dotnet_last_dll_path"] == nil then
				vim.g["dotnet_last_dll_path"] = request()
			else
				if
					vim.fn.confirm(
						"Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
						"&yes\n&no",
						2
					) == 1
				then
					vim.g["dotnet_last_dll_path"] = request()
				end
			end

			return vim.g["dotnet_last_dll_path"]
		end

		local config = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
						vim.g.dotnet_build_project()
					end
					return vim.g.dotnet_get_dll_path()
				end,
			},
		}
		dap.configurations.cs = config
	end,
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup({
					layouts = {
						{
							elements = {
								"scopes",
								"breakpoints",
								"stacks",
								"watches",
							},
							size = 40,
							position = "left",
						},
						{
							elements = {
								"repl",
								"console",
							},
							size = 10,
							position = "bottom",
						},
					},
				})

				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
				all_references = false, -- show virtual text on all all references of the variable (not only definitions)
				filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
				-- experimental features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			},
		},
		{
			"mfussenegger/nvim-dap-python",
			config = function()
				require("dap-python").setup("~/.local/share/virtualenvs/debugpy/bin/python")
			end,
		},
	},
	keys = {
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Breakpoint",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "inspect REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").disconnect({ terminateDebuggee = true })
			end,
			desc = "Stop dap",
		},
	},
}

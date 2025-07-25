return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
			keys = {
				{
					"<leader>bt",
					function()
						require("dapui").toggle()
					end,
					desc = "Toggle dapui UI",
				},
				{
					"<leader>b?",
					function()
						require("dapui").eval(nil, { enter = true })
					end,
				},
			},
			config = function()
				local dap, dapui = require("dap"), require("dapui")
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
			lazy = true,
			config = function()
				require("dap-python").setup("~/.local/share/virtualenvs/debugpy/bin/python")
			end,
		},
		{
			-- Ensure C/C++ debugger is installed
			"williamboman/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "codelldb" } },
		},
	},
	config = function()
		local dap = require("dap")
		local icons = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		}

		for name, sign in pairs(icons) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			)
		end
		dap.adapters.godot = { type = "server", host = "127.0.0.1", port = 6006 }
		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}

		if not dap.adapters["codelldb"] then
			require("dap").adapters["codelldb"] = {
				type = "executable",
				command = "codelldb",
			}
		end
		for _, lang in ipairs({ "c", "cpp" }) do
			dap.configurations[lang] = {
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},

				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},

				{
					name = "GDextension",
					type = "codelldb",
					request = "launch",
					program = "~/.local/bin/godot",
					args = {
						"--path",
						"${workspaceFolder}/demo/",
						"-s",
					},
					cwd = "${workspaceFolder}",
					console = "internalConsole",
				},
			}
		end
	end,
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<F9>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Breakpoint",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<S-F11>",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<S-F5>",
			function()
				require("dap").disconnect({ terminateDebuggee = true })
			end,
			desc = "Stop dap",
		},
		{
			"<leader>bc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>bb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Breakpoint",
		},
		{
			"<leader>bo",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>bi",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>br",
			function()
				require("dap").repl.open()
			end,
			desc = "inspect REPL",
		},
		{
			"<leader>bs",
			function()
				require("dap").disconnect({ terminateDebuggee = true })
			end,
			desc = "Stop dap",
		},
	},
}

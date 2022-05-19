local status_ok, _ = pcall(require, "dap")
if not status_ok then
	return
end

require("user.dap.dap-python")
require("user.dap.dap-ui")
require("user.dap.dap-ui-virtualtext")

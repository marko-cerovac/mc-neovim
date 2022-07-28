local dap = require("dap")
dap.adapters.cppdbg = {
  type = "executable",
  command = "/home/marko/.vscode-oss/extensions/ms-vscode.cpptools-1.7.1/debugAdapters/bin/OpenDebugAD7",
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
	-- args = function ()
	-- 	local string = vim.fn.input("Program arguments: ")
	-- 	local cmd_args = {}
	-- 	for substring in string:gmatch("%S+") do
	-- 		table.insert(cmd_args, substring)
	-- 	end
	-- 	return cmd_args
	-- end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
  }
}
-- C, Cpp and Rust debugger
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Java debugger
--[[ dap.configurations.java = {
	-- You need to extend the classPath to list your dependencies.
	-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
	classPaths = {},

	-- If using multi-module projects, remove otherwise.
	-- projectName = "yourProjectName",

	javaExec = "/bin/java",
	mainClass = "your.package.name.MainClassName",

	-- If using the JDK9+ module system, this needs to be extended
	-- `nvim-jdtls` would automatically populate this property
	modulePaths = {},
	name = "Launch YourClassName",
	request = "launch",
	type = "java"
} ]]
--[[ dap.configurations.java = {
     -- You need to extend the classPath to list your dependencies.
     -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
    classPaths = {},

    -- If using multi-module projects, remove otherwise.
    projectName = "yourProjectName",

    javaExec = "/bin/java",
    mainClass = "your.package.name.MainClassName",

    -- If using the JDK9+ module system, this needs to be extended
    -- `nvim-jdtls` would automatically populate this property
    modulePaths = {},
    name = "Launch Main",
    request = "launch",
    type = "java"
} ]]

-- Define debugg signs
-- vim.fn.sign_define("DapBreakpoint", {text="ﱣ ", texthl = "DapBreakpoint", numhl = ""})
-- vim.fn.sign_define("DapStopped", {text="喇", texthl = "DapStopped", numhl = ""})
vim.fn.sign_define("DapBreakpoint", {text=" ", texthl = "DapBreakpoint", numhl = ""})
-- vim.fn.sign_define("DapBreakpoint", {text="ﭦ ", texthl = "DapBreakpoint", numhl = ""})
vim.fn.sign_define("DapStopped", {text=" ", texthl = "DapStopped", numhl = ""})

-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

local wrap = function (text)
	return "<cmd>lua require('dap')." .. text .. "()<CR>"
end

require("which-key").register({
	d = {
		name = "debugg",
		b = { wrap("toggle_breakpoint"),	"toggle breakpoint" },
		c = { wrap("continue"),				"continue" },
		h = { wrap("step_out"),				"step out" },
		l = { wrap("step_into"),			"step into" },
		j = { wrap("step_over"),			"step over" },
		p = { wrap("pause"),				"pause" },
		-- r = { wrap("repl.open"),			"open repl" },
		q = { wrap("terminate"),				"quit" },
		-- i = { ":lua require('dap.ui.widgets').hover()<CR>",	"evaluate expression" },
		g = { wrap("run_to_cursor"),		"run to cursor" },
		x = { wrap("clear_breakpoints"), 	"clear breakpoints" },
		-- r = {wrap(repl.toggle()<CR><C-w>l", "toggle repl"},
		-- g = { wrap("session"),				"get Session" },
		-- i = {wrap(.widgets").hover()<CR>", "hover"},
		-- p = {"", "scopes"},
		-- e = {"", "set exception"}
	},
}, { prefix = "<leader>" })

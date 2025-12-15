-- ~/.config/nvim/after/ftplugin/cpp.lua
local project_root = vim.fn.getcwd()

vim.bo.errorformat = "%f:%l:%c: %m"

if vim.fn.filereadable(project_root .. "/CMakeLists.txt") == 1 then
	-- CMake project
	vim.bo.makeprg = "cmake --build build/Desktop-Debug --target all"
elseif vim.fn.filereadable(project_root .. "/SConstruct") == 1 then
	-- Scons project
	vim.bo.makeprg = "scons target=template_debug debug_symbols=yes"
else
	-- Default: compile current file with g++
	vim.bo.makeprg = "clang++ -g -std=c++2a -Wall -Wextra *.cpp -o main"
end

local M = {}


-- 获取当前文件目录 
-- e.g: /User/home
M.get_current_path = function()
	local current_file = vim.fn.expand('%:p:h')
	return current_file
end

-- 获取路径的目录
M.get_path_dir = function(path)
	return vim.fn.fnamemodify(path, ':h')
end

-- 获取指定 buffer 目录, bufnr 为空,则返回当前 buffer 目录
M.get_buffer_cwd = function(bufnr)
	if bufnr == nil then
		bufnr = vim.api.nvim_get_current_buf()
	end
	local filepath = vim.api.nvim_buf_get_name(bufnr)

	local dir = vim.fn.fnamemodify(filepath, ":h")
	return dir
end

-- 获取路径结构的数组 /x/y/z -> {'/x/y/z', '/x/y', '/x', '/'}
M.get_path_array = function(path)
	local array = {}
	table.insert(array, path)
	local current_path = path
	while (#current_path ~= 1) do
		current_path = M.get_path_dir(current_path)
		table.insert(array, current_path)

	end
	table.insert(array, '/')
	return array
end

return M

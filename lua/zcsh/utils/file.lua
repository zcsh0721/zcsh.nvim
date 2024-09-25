local M = {}
-- 读取文件内容
M.read_from_file = function(filepath)
	-- 尝试打开文件
	local file = io.open(filepath, "r")
	if not file then
		print("Error: Cannot open file " .. filepath)
		return
	end

	-- 读取文件内容
	local content = file:read("*a") -- 读取整个文件
	file:close()                   -- 关闭文件

	-- 返回文件内容
	return content
end

-- 一行一行读取文件
M.read_line_from_file = function(filepath)
	-- 尝试打开文件
	local file = io.open(filepath, "r")
	if not file then
		print("Error: Cannot open file " .. filepath)
		return
	end

	local result = {}
	for line in file:lines() do
		table.insert(result, line)
	end
	return result
end

-- 从数组中写入文件 一个元素一行
M.write_file_from_arr = function(path, arr)
	-- 打开文件用于写入
	local file = io.open(path, "w")

	-- 检查文件是否成功打开
	if not file then
		print("无法打开文件")
		return
	end

	-- 遍历写入
	for _, value in pairs(arr) do
		file:write(value .. "\n") -- 写入键和值，并在每对后添加换行符
	end

	-- 关闭文件
	file:close()
end
-- 文件是否存在, 不是文件返回false ,不存在则返回nil
M.is_exist_file = function(file_path)
	local stat = vim.loop.fs_stat(file_path)
	return stat and stat.type == "file"
end

-- 目录是否存在, 不是目录返回false, 不存在返回 nil
M.is_exist_dir = function(dir_path)
	local stat = vim.loop.fs_stat(dir_path)
	return stat and stat.type == "directory"
end

-- 创建目录
M.create_directory = function(path)
	-- 检查路径是否存在
	local ok, err = os.rename(path, path)
	if not ok then
		-- 尝试创建目录
		local status, err = os.execute("mkdir -p " .. path)
		if not status then
			error("Failed to create directory: " .. path .. ", error: " .. err)
		end
	end
end

-- 创建文件,如果目录不存在,也会创建目录
M.create_file = function(path)
	-- 检查文件路径中的目录是否存在，如果不存在则创建
	local dir_path = vim.fn.fnamemodify(path, ':h')
	if not vim.loop.fs_stat(dir_path) then
		M.create_directory(dir_path)
	end
	if M.is_exist_file(path) then
		return
	end
	-- 创建文件
	local file = io.open(path, 'w')
	if not file then
		error("Failed to create file: " .. path)
	end
	file:close()
end

-- 往指定文件头写入新行, 并去重(即去掉相同行)
-- file_path: 文件路径
-- line: 新行内容
M.write_first_and_duplicate_removal = function(file_path, line)
	local all_line = M.read_line_from_file(file_path)
	all_line = require('zcsh.utils.table').remove_elem(all_line, line)
	table.insert(all_line, 1, line)
	M.write_file_from_arr(file_path, all_line)
end
return M

local M = {}
local path_util = require('zcsh.utils.path')
local string_util = require('zcsh.utils.string')
local file_util = require('zcsh.utils.file')
-- 启动项目级别的缓存
local function start_project_cache(project_root_path)
	if not project_root_path then
		return
	end

	local cache_path = project_root_path .. '/.cache/zcsh/'
	local change_file_history_file = cache_path .. 'change_file_historyt'
	local open_file_history_file = cache_path .. 'open_file_historyt'
	-- create cache file
	file_util.create_file(change_file_history_file)
	-- 创建一个 Neovim 自动命令组
	vim.api.nvim_create_augroup("ZcshFileChangeGroup", { clear = true })

	-- 在组中创建一个自动命令，监听 BufWritePost 事件
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = "ZcshFileChangeGroup",
		pattern = "*", -- 监听所有文件类型
		callback = function()
			-- 获取当前缓冲区的文件路径
			local filepath = vim.fn.expand('%:p') -- %:p 表示当前文件的全路径
			file_util.write_first_and_duplicate_removal(change_file_history_file, filepath)
		end,
	})
	file_util.create_file(open_file_history_file)
end

-- 获取项目根目录, 未找到返回nil
-- 参数: 需要判断是否是根目录的标识数组 例如: {'.git/', 'pom.x'}
M.get_project_root = function()
	local current_path = path_util.get_current_path()
	local path_array = path_util.get_path_array(current_path)


	for _, path_item in pairs(path_array) do
		for _, id in ipairs(vim.g.zcsh_config.project.root_dir_identifications) do
			if string_util.ends_with(id, '/') then
				-- 存在此目录即表示项目根目录
				if file_util.is_exist_dir(path_item .. '/' .. id) then
					--start_project_cache(path_item)
					vim.g.zcsh_config.project.root = path_item
					return path_item
				end
			else
				-- 存在此文件即表示根目录
				if file_util.is_exist_file(path_item .. id) then
					--start_project_cache(path_item)
					return path_item
				end
			end
		end
	end
	return nil
end

M.init = function()

end

return M

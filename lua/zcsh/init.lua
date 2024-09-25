local M              = {}
local utils = require('zcsh.utils')

-- 全局默认配置文件
local default_config = require('zcsh.default_config')


M.setup = function()
	if vim.g.zcsh_init then
		return
	end
	vim.g.zcsh_init = 1

	-- 项目级配置地址
	local project_config_path = '/.config/zcsh/config.yaml'
	
	-- 先获取默认配置

	vim.g.zcsh_config = default_config
	-- 项目级别配置覆盖默认配置
	local project_root = utils.project.get_project_root()
	if project_root and utils.file.is_exist_file(project_root .. project_config_path) then
		local project_config = utils.file.read_from_file(project_root .. project_config_path)
		if project_config then
			local project_config_tbl = utils.string.parse_yaml(project_config)
			vim.g.zcsh_config = vim.tbl_deep_extend('force', vim.g.zcsh_config, project_config_tbl)
		end
	end

end
-- 显示当前配置
M.show_config = function()
	print(vim.inspect(vim.g.zcsh_config))
end
return M

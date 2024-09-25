local M = {}

-- 判断插件是否存在, 如果存在则返回插件 module , 如果不存在则返回nil
M.is_exist_plguin = function(plugin_name)
	local status, module = pcall(require, plugin_name)
	if status then
		return module
	end
	return nil
end

-- 获取依赖的lua 版本
M.get_lua_version = function()
	local lua_version = _VERSION:match("[%d%.]+")
	return lua_version
end

return M

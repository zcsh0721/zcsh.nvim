-- 加载 Luarocks 的路径

local M = {}

-- parse_json
M.parse_json = function(content)
	return vim.fn.json_decode(content)
end

-- parse yaml
M.parse_yaml = function(content)
	local yaml = require('lyaml')
	local yaml_data = yaml.load(content)
	return yaml_data
end

-- 是否指定字符串结尾
M.ends_with = function(str, ending)
	return ending == "" or string.sub(str, -string.len(ending)) == ending
end

-- 是否指定字符串开始
M.starts_with = function(str, start)
	return str:sub(1, #start) == start
end

-- 按指定字符分割字符串
M.split = function(str, split_char)
	if not str or not split_char then
		return {}
	end
	local start = 1
	local arr = {}
	while true do
		local pos, endpos = string.find(str, split_char, start)
		if not pos then break end
		table.insert(arr, string.sub(str, start, pos - 1))
		start = endpos + 1
	end

	table.insert(arr, string.sub(str, start))
	return arr
end

return M

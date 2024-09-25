local M = {}

-- string to json
M.parse_json = function(json)
	return vim.fn.json_decode(json)
end

return M

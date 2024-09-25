local M = {}

-- 获取当前 buffer 的id
M.get_current_buf_id = function()
	return vim.api.nvim_get_current_buf()
end


return M

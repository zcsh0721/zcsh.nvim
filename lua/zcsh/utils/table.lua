local M = {}

-- 删除元素
M.remove_elem = function(arr, elem)
	local new_t = {}
	for i = 1, #arr do
		if arr[i] ~= elem then
			table.insert(new_t, arr[i])
		end
	end
	return new_t
end

return M

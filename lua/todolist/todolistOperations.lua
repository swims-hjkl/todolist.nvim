local path = require("plenary.path")
local TodoList = require("todolist.todolistItem")


M = {}

M.add_todo = function()
	local description = vim.fn.input("Enter todo one line description: ")
	if (description == nil) or (description == "") then
		return nil
	end
	local todo_list_item = TodoList:newItem(description)
	table.insert(M.data, todo_list_item)
	return todo_list_item.id
end


M.delete_todo = function(id)
	for index, item in ipairs(M.data) do
		if (item.id == id) then
			table.remove(M.data, index)
		end
	end
end

M.save_todos_to_storage = function(file_path)
	local output = {}
	for _, item in ipairs(M.data) do
		table.insert(output, item:get_item())
	end
	path.new(file_path):write(vim.fn.json_encode(output), "w")
end

return M

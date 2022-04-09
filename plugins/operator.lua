local M = {}
local api

local admins_file_path = "admins.dat" -- admins list filepath

local function set_operator(client, args)
	local cl = api.call_function("get_client_by_name", args[2])
	
	if cl then
		local cl_data = api.get_data("clients_data")[cl]
		
		api.call_function("chat_function", "<color=#979393><outline=#F5E55E>[I]Игрок "..cl_data.name.." назначен оператором.</outline></color>")
		api.call_function("set_permissions_group", cl, "admin")
		
		local file = io.open(admins_file_path, "a")
		file:write("\n"..cl_data.name.."\n"..cl_data.uuid.."\n")
		file:close()
	else
		api.call_function("chat_message", "[I]Игрок не найден!", "error", true, client)
	end
end

function M.init(_api)
	api = _api
	api.register_command("/op", set_operator)
end

return M
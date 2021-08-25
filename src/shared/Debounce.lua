--//Hopefully you find this module in some way usefull 

--//Created by AllAllLol1\\
--//Version 2.5\\

local Cooldown = {}
local CooldownData = {}

function Cooldown.Add(tableName, valueName, cooldown, callback, args) -- This function will insert a table for each diffirent player with diffirent cooldown values for diffirent valueName
	if tonumber(cooldown) ~= nil then
		if CooldownData[tableName] then
			table.insert(CooldownData[tableName], valueName)
			CooldownData[tableName][valueName] = {["StartTime"] = os.clock(), ["Time"] = cooldown, ["TimeLeft"] = cooldown, ["Function"] = callback, ["Arguments"] = args}
			return true
		else
			CooldownData[tableName] = {[valueName] = {["StartTime"] = os.clock(), ["Time"] = cooldown, ["TimeLeft"] = cooldown, ["Function"] = callback, ["Arguments"] = args}}
			return true
		end
	end
	return false
end

function Cooldown.Check(tableName, valueName) --This function will check [CooldownList] table in order to know if the value already exists, if it does returns false
	if CooldownData[tableName] then
		if CooldownData[tableName][valueName] then
			local timeLeft = CooldownData[tableName][valueName]["TimeLeft"]
			return false, timeLeft --If you want to round timeLeft into just seconds without miliseconds do math.floor(timeLeft)
		else
			return true
		end
	else
		return true
	end
end

local NewUpdateThread = coroutine.wrap(function() --Countdown timer for all of the cooldowns, a NewUpdateThread will NOT be created everytime you require() the module. Unless it's required from both sides client and server, then 2 threads will be running.
	local RunService = game:GetService("RunService")
	
	while RunService.Heartbeat:Wait() do
		for TableOrder,Table in next, CooldownData do
			for TableName,TableValues in pairs(Table) do
				if TableValues["StartTime"] and TableValues["Time"] and TableValues["TimeLeft"] then
					local currentTime = os.clock()
					local timePassed = currentTime - TableValues["StartTime"]
					local timeLeft = TableValues["Time"] - timePassed
					if TableValues["Time"] >= timePassed then
						TableValues["TimeLeft"] = timeLeft
					else
						TableValues["TimeLeft"] = 0
						
						local callback = coroutine.wrap(function() --New thread is created, so it won't slow down the for loop
							if TableValues["Function"] then
								if TableValues["Arguments"] then
									TableValues["Function"](TableValues["Arguments"]) --Run the callback function with argument(s)
								else 
									TableValues["Function"]() --Run the callback function
								end
							end
						end)
						
						pcall(function()
							callback()
						end)
						
						CooldownData[TableOrder][TableName] = nil --Remove the cooldown from table
						
						if #CooldownData[TableOrder] == 0 then --Remove the table from CooldownList if its empty (	just to keep the table clean :]  )
							CooldownData[TableOrder] = nil
						end
					end
				end
			end
		end
	end
end)

NewUpdateThread()

return Cooldown

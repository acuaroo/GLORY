--|| SERVICES ||--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local classManager = require(ReplicatedStorage:WaitForChild("Modules").ClassManager)

--|| MAIN ||--
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        local messageSplit = string.split(message, " ")
        if messageSplit[1] == "/load" then
            classManager:LoadClassOnCharacter(player, messageSplit[2])
        end
    end)
end)
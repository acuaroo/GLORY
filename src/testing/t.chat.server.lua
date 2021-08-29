--|| SERVICES ||--
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local classManager = require(ServerStorage:WaitForChild("Modules").ClassManager)
local loadAttack = ReplicatedStorage:WaitForChild("Remotes").LoadAttack

--|| MAIN ||--
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        local messageSplit = string.split(message, " ")
        if messageSplit[1] == "/load" then
            local _, animationData, newHumanoid, a1, a2, a3 = classManager:LoadClassOnCharacter(player, messageSplit[2])
            loadAttack:FireClient(player, animationData, newHumanoid, a1, a2, a3, messageSplit[2])

        elseif messageSplit[1] == "/remove" then
            classManager:RemoveClassOnCharacter(player)
        end
    end)
end)
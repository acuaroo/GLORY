--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

--|| VARS ||--
local requestAttack = ReplicatedStorage:WaitForChild("Functions").RequestAttack

local loadAttack = ReplicatedStorage:WaitForChild("Remotes").LoadAttack
local removeAttack = ReplicatedStorage:WaitForChild("Remotes").RemoveAttack

local uisConnected = nil

--|| FUNCTIONS ||--
local function sendAttack(newHumanoid: Humanoid, class: string, attackId: string)
    local attackSent = requestAttack:InvokeServer(newHumanoid, class, attackId)
    -- print(attackSent)
end

--|| MAIN ||--
loadAttack.OnClientEvent:Connect(function(newHumanoid: Humanoid, class: string)
    uisConnected = UserInputService.InputBegan:Connect(function(input: InputObject, typing: any)
        if typing then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sendAttack(newHumanoid, class, "Attack1")
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            sendAttack(newHumanoid, class, "Attack2")
        elseif input.KeyCode == Enum.KeyCode.E then
            sendAttack(newHumanoid, class, "Attack3")
        end
    end)
end)

removeAttack.OnClientEvent:Connect(function()
    uisConnected:Disconnect()
    uisConnected = nil
end)

Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if uisConnected == nil then return end
    uisConnected:Disconnect()
    uisConnected = nil
end)
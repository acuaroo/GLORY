--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

--|| VARS ||--
local loadAttack = ReplicatedStorage:WaitForChild("Remotes").LoadAttack
local removeAttack = ReplicatedStorage:WaitForChild("Remotes").RemoveAttack
local requestAttack = ReplicatedStorage:WaitForChild("Remotes").RequestAttack
local uisConnected = nil

--|| FUNCTIONS ||--
local function requestAttackFunction(attackNum, class)
    local request = requestAttack:InvokeServer(attackNum, class)
    if request then
        --| Proceed with attack anim
    elseif not request then
        --| Player's attack is invalid
    else 
        print("An error has occured on the server...")
    end
end

--|| MAIN ||--
loadAttack.OnClientEvent:Connect(function(animationData: table, newHumanoid: Humanoid, a1: table, a2: table, a3: table, class: table)
    uisConnected = UserInputService.InputBegan:Connect(function(input: InputObject, typing: any)
        if typing then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            requestAttackFunction("Attack1", class)
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            requestAttackFunction("Attack2", class)
        elseif input.KeyCode == Enum.KeyCode.E then
            requestAttackFunction("Attack3", class)
        end
    end)
end)

removeAttack.OnClientEvent:Connect(function()
    uisConnected:Disconnect()
    uisConnected = nil
end)
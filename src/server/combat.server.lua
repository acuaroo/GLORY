--|| SERVICES ||--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local requestAttack = ReplicatedStorage:WaitForChild("Remotes").RequestAttack
local debounceModule = require(ServerStorage:WaitForChild("Modules").Debounce)
local attackModule = require(ServerStorage:WaitForChild("Modules").Attack)

--|| MAIN ||--
requestAttack.OnServerInvoke = function(player, attack, class)
    local result, timeLeft  = debounceModule.Check(player.Name, "Attack")
    
    if result then 
        --| Player is ready to attack
        local requiredClass = require(ServerStorage:WaitForChild("Modules").classes[class])
        print(requiredClass.ClassData[attack].Cooldown)

        attackModule:StartAttack(player, player.Character[requiredClass.ClassData[attack].Part], requiredClass.ClassData[attack], attack, requiredClass.ClassData.Animations)
        debounceModule.Add(player.Name, "Attack", requiredClass.ClassData[attack].Cooldown)

        return true
    else
        print("Slowdown!")
        return false, timeLeft
        --| Player is on cooldown
    end
end

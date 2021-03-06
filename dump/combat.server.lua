--|| SERVICES ||--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local requestAttack = ReplicatedStorage:WaitForChild("Remotes").RequestAttack
local debounceModule = require(ServerStorage:WaitForChild("Modules").Debounce)
local attackModule = require(ServerStorage:WaitForChild("Modules").Attack)
local validAttacksByClient = {
    ["Attack1"] = false,
    ["Attack2"] = false,
    ["Attack3"] = false,
}

--|| MAIN ||--
requestAttack.OnServerInvoke = function(player, attack, class)
    if validAttacksByClient[attack] == nil then 
        --| Ban Wave Add
        return player:Kick("big noob")
    end

    local result, timeLeft  = debounceModule.Check(player.Name, attack)
    
    if result then 
        --| Player is ready to attack
        local requiredClass = require(ServerStorage:WaitForChild("Modules").classes[class])

        attackModule:StartAttack(player, player.Character[requiredClass.ClassData[attack].Part], requiredClass.ClassData[attack], attack, requiredClass.ClassData.Animations)
        debounceModule.Add(player.Name, attack, requiredClass.ClassData[attack].Cooldown)

        return true
    else
        print("Slowdown!")
        return false
        --| Player is on cooldown
    end
end

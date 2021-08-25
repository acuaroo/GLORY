--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local requestAttack = ReplicatedStorage:WaitForChild("Remotes").RequestAttack
local debounceModule = require(ReplicatedStorage:WaitForChild("Modules").Debounce)

--|| FUNCTIONS ||--
function attackFunction(classData, attack) 
    print("Attacked with "..classData[attack].Damage.." Damage!")
end
--|| MAIN ||--
requestAttack.OnServerInvoke = function(player, attack, class)
    local result, timeLeft  = debounceModule.Check(player.Name, "Attack")
    
    if result then 
        --| Player is ready to attack
        local requiredClass = require(ReplicatedStorage:WaitForChild("Modules").classes[class])

        if requiredClass == nil then return nil end

        debounceModule.Add(player.Name, "Attack", requiredClass.ClassData[attack].Cooldown, attackFunction, {requiredClass.ClassData, attack})

        return true
    else
        print("Slowdown!")
        return false
        --| Player is on cooldown
    end
end

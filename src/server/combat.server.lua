--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

--|| VARS ||--
local requestAttack = ReplicatedStorage:WaitForChild("Functions").RequestAttack
local classManager = require(ServerStorage:WaitForChild("Modules").ClassManager)
local debounce = require(ServerStorage:WaitForChild("Modules").Debounce)
local raybox = require(ReplicatedStorage:WaitForChild("Modules").Raybox)

local validAttackIds = {
    ["Attack1"] = 1,
    ["Attack2"] = 1,
    ["Attack3"] = 1
}

--|| FUNCTIONS ||--
local function attackFunction(player: Player, attackId: string, attackData: table, animationData: table)
    local parems = RaycastParams.new()
    parems.FilterDescendantsInstances = {player.Character}
    parems.FilterType = Enum.RaycastFilterType.Blacklist

    local hitbox = raybox.new(player.Character[attackData.RaycastPart])
    hitbox.RaycastParams = parems --- Define our RaycastParams

    hitbox:HitStop()

    local animation = Instance.new("Animation")
    animation.Parent = player.Character.Humanoid
    animation.AnimationId = animationData[attackId]
    
    local animLoaded = player.Character.Humanoid.Animator:LoadAnimation(animation)
    animLoaded.Priority = Enum.AnimationPriority.Action

    animLoaded:Play()
    task.wait(animLoaded.Length/2)
    hitbox:HitStart()

    hitbox.OnHit:Connect(function(hit: BasePart, humanoid: Humanoid)
        local victimsClass = humanoid.Parent:FindFirstChild("ClassValue")
        local victimsClassData = require(ServerStorage:WaitForChild("Modules").classes[victimsClass.Value]).ClassData

        if humanoid.Parent:FindFirstChild("Blocking") then
            local blockingPart = humanoid.Parent:FindFirstChild("Blocking")
            blockingPart.Health.Value -= 1

            if blockingPart.Health.Value == 0 then
                blockingPart:Destroy()
                -- Stun
                print("Stun")
            end
        else
            humanoid:TakeDamage(attackData.Damage)

            if attackData.Properties.Knockback ~= 0 then
                print("Knockback")
            elseif attackData.Properties.Stun ~= 0 then
                print("Stun")
            end
        end
    end)

    animLoaded.Stopped:Wait()
    hitbox:HitStop()
end

--|| MAIN ||--
requestAttack.OnServerInvoke = function(player: Player, newHumanoid: Humanoid, class: string, attackId: string)
    local playerClass = classManager:CheckClassOnPlayer(player)

    if not playerClass then return player:Kick("big noob") end
    if not playerClass == class then return player:Kick("big noob") end

    if validAttackIds[attackId] == nil then return player:Kick("big noob") end

    local result, _  = debounce.Check(player, attackId)

    if result then
        local requiredClass = require(ServerStorage:WaitForChild("Modules").classes[playerClass]).ClassData
        local attackData = requiredClass.Attacks[attackId]

        debounce.Add(player, attackId, attackData.Cooldown)

        attackFunction(player, attackId, attackData, requiredClass.Animations)
        return "Attacked using "..attackId.." which dealt "..attackData.Damage
    else
        return "Player is on cooldown!"
    end
end
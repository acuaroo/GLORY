--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local RaycastHitbox = require(ReplicatedStorage:WaitForChild("Modules").Raybox)

local attackModule = {}

--|| FUNCTIONS ||--
function attackModule:StartAttack(player: Player, hitbox: Instance, attackData: table, attackNum: string, animationData: table) 
    local attackHitbox = RaycastHitbox.new(hitbox)

    local parems = RaycastParams.new()
    parems.FilterDescendantsInstances = {player.Character}
    parems.FilterType = Enum.RaycastFilterType.Blacklist

    attackHitbox.RaycastParams = parems
    attackHitbox:HitStart()

    --| Proceed with attack anim
    local animation = Instance.new("Animation")
    animation.Parent = player.Character.Humanoid
    animation.AnimationId = animationData[attackNum]
    
    local animLoaded = player.Character.Humanoid:LoadAnimation(animation)
    animLoaded.Priority = Enum.AnimationPriority.Action

    animLoaded:Play()

    attackHitbox.OnHit:Connect(function(obj: Instance, humanoid: Humanoid)
        print(obj.Name)
        humanoid:TakeDamage(attackData.Damage)
        -- Deal stun, effects, etc
    end)

    animLoaded.Stopped:Wait()
    attackHitbox:Destroy()

    return 
end

--|| EXPORTING ||--
return attackModule
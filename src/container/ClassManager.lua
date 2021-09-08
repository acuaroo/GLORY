--|| SERVICES ||--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local classModule = {}
local removeAttack = ReplicatedStorage:WaitForChild("Remotes").RemoveAttack

--|| FUNCTIONS ||--
function classModule:LoadClassOnPlayer(player: Player, class: string) 
    local foundClass = nil

    for _, selectedClass in pairs(script.Parent.classes:GetChildren()) do
        if selectedClass.Name == class then 
            foundClass = selectedClass
            break
        end
    end

    if foundClass == nil then return warn("WRN: No class found by the name "..class) end

    local foundClassModule = require(foundClass)
    local animationData = foundClassModule.ClassData.Animations

    local newCharacter = ServerStorage:WaitForChild("ClassModels")[foundClassModule.ClassData.Character]:Clone()
    newCharacter.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    newCharacter.Name = player.Name
	player.Character = newCharacter
	newCharacter.Parent = workspace
    -- newCharacter.Parent = workspace
    -- newCharacter:MakeJoints()
    -- newCharacter:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)
    player.Character = newCharacter

    local classValue = Instance.new("StringValue")
    classValue.Name = "ClassValue"
    classValue.Parent = player.Character
    classValue.Value = class

    player.Character:WaitForChild("Animate").Disabled = true
    player.Character:WaitForChild("Animate").walk.WalkAnim.AnimationId = animationData.Walking
    -- player.Character:WaitForChild("Animate").idle.IdleAnim.AnimationId = animationData.Idle
    
    task.wait(0.1)
    player.Character:WaitForChild("Animate").Disabled = false

    ReplicatedStorage:WaitForChild("Remotes").ChangeCamera:FireClient(player);

    local humanoid = player.Character:WaitForChild("Humanoid")

    humanoid.WalkSpeed = foundClassModule.ClassData.Speed
    humanoid.MaxHealth = foundClassModule.ClassData.Health
    humanoid.Health = foundClassModule.ClassData.Health
    humanoid.JumpPower = foundClassModule.ClassData.Jump

    local animationFolder = Instance.new("Folder")
    animationFolder.Name = "AnimationFolder"
    animationFolder.Parent = humanoid

    local attackAnimation1 = Instance.new("Animation")
    attackAnimation1.Parent = animationFolder
    attackAnimation1.AnimationId = foundClassModule.ClassData.Animations.Attack1

    local attackAnimation2 = Instance.new("Animation")
    attackAnimation2.Parent = animationFolder
    attackAnimation2.AnimationId = foundClassModule.ClassData.Animations.Attack2

    return print("Given player's class has been added"), humanoid, animationFolder
end

function classModule:RemoveClassOnPlayer(player: Player)
    if not player.Character:FindFirstChild("ClassValue") then return warn("WRN: No class is loaded onto the given player") end
    player.Character.ClassValue:Destroy()
    player:LoadCharacter()
    removeAttack:FireClient(player)
    return print("Given player's class has been removed")
end

function classModule:CheckClassOnPlayer(player: Player) 
    if player.Character:FindFirstChild("ClassValue") then
        return player.Character:FindFirstChild("ClassValue").Value
    else
        return false
    end
end

--|| EXPORTING ||--
return classModule
--|| SERVICES ||--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| VARS ||--
local classModule = {}

--|| FUNCTIONS ||--
function classModule:LoadClassOnCharacter(player: Player, class: string) 
    local foundClass = nil

    for _, selectedClass in pairs(script.Parent.classes:GetChildren()) do
        if selectedClass.Name == class then 
            foundClass = selectedClass
            break
        end
    end

    if foundClass == nil then return warn("WRN: No class found by the name %s", class) end

    local foundClassModule = require(foundClass)
    local animationData = foundClassModule.ClassData.Animations

    local newCharacter = ServerStorage:WaitForChild("ClassModels")[foundClassModule.ClassData.Character]:Clone()

    newCharacter.Name = player.Name
    newCharacter.Parent = workspace
    newCharacter:MakeJoints()
    newCharacter:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)

    player.Character = newCharacter
    player.Character:WaitForChild("Animate").Disabled = true
    task.delay()
    player.Character:WaitForChild("Animate").Disabled = false

    ReplicatedStorage:WaitForChild("Remotes").ChangeCamera:FireClient(player);

    local humanoid = player.Character:WaitForChild("Humanoid")

    humanoid.WalkSpeed = foundClassModule.ClassData.Speed
    humanoid.MaxHealth = foundClassModule.ClassData.Health
    humanoid.Health = foundClassModule.ClassData.Health
    humanoid.JumpPower = foundClassModule.ClassData.Jump
end

--|| EXPORTING ||--
return classModule
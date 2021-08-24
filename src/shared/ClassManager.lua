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

    if foundClass == nil then return warn("WRN: No class found by the name "..class) end

    local foundClassModule = require(foundClass)
    local animationData = foundClassModule.ClassData.Animations

    local newCharacter = ServerStorage:WaitForChild("ClassModels")[foundClassModule.ClassData.Character]:Clone()
    newCharacter.Name = player.Name
    newCharacter.Parent = workspace
    newCharacter:MakeJoints()
    newCharacter:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)

    player.Character = newCharacter

    local classValue = Instance.new("StringValue")
    classValue.Name = "ClassValue"
    classValue.Parent = player.Character
    classValue.Value = class

    player.Character:WaitForChild("Animate").Disabled = true
    task.wait(0.1)
    player.Character:WaitForChild("Animate").Disabled = false

    ReplicatedStorage:WaitForChild("Remotes").ChangeCamera:FireClient(player);

    local humanoid = player.Character:WaitForChild("Humanoid")

    humanoid.WalkSpeed = foundClassModule.ClassData.Speed
    humanoid.MaxHealth = foundClassModule.ClassData.Health
    humanoid.Health = foundClassModule.ClassData.Health
    humanoid.JumpPower = foundClassModule.ClassData.Jump

    return animationData, humanoid
end

function classModule:RemoveClassOnCharacter(player: Player) do
    if not player.Character:FindFirstChild("ClassValue") then return warn("WRN: No class is loaded onto the given player") end
    player.Character.ClassValue:Destroy()
    player:LoadCharacter()
    return print("Given player's class has been removed")
end

--|| EXPORTING ||--
return classModule
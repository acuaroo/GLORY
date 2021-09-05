--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--|| VARS ||--
local damagedFolder = ReplicatedStorage:WaitForChild("Assets").Damaged
local changeCamera = ReplicatedStorage:WaitForChild("Remotes").ChangeCamera
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local currentCamera = workspace.CurrentCamera

local humanoid = character:WaitForChild("Humanoid")

local WEIGHT = 1

local force = nil
local direction = nil
local val1 = 0
local val2 = 0

--|| MAIN ||--
changeCamera.OnClientEvent:Connect(function()
    if currentCamera.CameraSubject == nil then
        repeat RunService.RenderStepped:Wait() until currentCamera.CameraSubject ~= nil
    end
    currentCamera.CameraType = Enum.CameraType.Custom
    currentCamera.CameraSubject = player.Character

    local newCharacter = player.Character or player.CharacterAdded:Wait()

    local head = newCharacter:WaitForChild("Head")
    local humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
    local torso = newCharacter:WaitForChild("Torso")
    local subject = ReplicatedStorage:WaitForChild("Assets").Subject:Clone()

    subject.Position = head.Position
    currentCamera.CameraSubject = subject

    local rootJoint = humanoidRootPart.RootJoint
    local leftHipJoint = torso["Left Hip"]
    local rightHipJoint = torso["Right Hip"]

    local rootJointC0 = rootJoint.C0
    local leftHipJointC0 = leftHipJoint.C0
    local rightHipJointC0 = rightHipJoint.C0

    local function updateSubject()
        subject.Position = subject.Position:Lerp(head.Position,1/WEIGHT)
	
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local lookXZ = Vector3.new(currentCamera.CFrame.LookVector.X,0, currentCamera.CFrame.LookVector.Z)
            humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + lookXZ)
        end

        force = humanoidRootPart.AssemblyLinearVelocity * Vector3.new(1,0,1)

        if force.Magnitude > 0.001 then
            --| This represents the direction
            direction = force.Unit	
            val1 = humanoidRootPart.CFrame.RightVector:Dot(direction)
            val2 = humanoidRootPart.CFrame.LookVector:Dot(direction)
        else
            val1 = 0
            val2 = 0
        end
    
        --| The values being multiplied are how much you want to rotate by
    
        rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad(val2 * 5), math.rad(-val1 * 5), 0), 0.2) -- 14, 22
        leftHipJoint.C0 = leftHipJoint.C0:Lerp(leftHipJointC0 * CFrame.Angles(math.rad(val1 * 5), 0, 0), 0.2) -- 10
        rightHipJoint.C0 = rightHipJoint.C0:Lerp(rightHipJointC0 * CFrame.Angles(math.rad(-val1 * 5), 0, 0), 0.2)
    end

    RunService:BindToRenderStep("UpdateSubject", Enum.RenderPriority.Camera.Value, updateSubject)
end)

humanoid.HealthChanged:Connect(function(newHealth)
    if newHealth <= 50 then
        for _, effect in pairs(damagedFolder:GetChildren()) do
            effect.Parent = game.Lighting
        end

        if newHealth <= 25 then
            game.Lighting["DamagedBlur"].Size = 10
            game.Lighting["DamagedTint"].TintColor = Color3.fromRGB(255, 176, 178)
        end 
    end
end)

humanoid.Died:Connect(function()
    game.Lighting["DamagedBlur"].Size = 25
    game.Lighting["DamagedTint"].TintColor = Color3.fromRGB(8, 8, 8) 
    player.CharacterAdded:Wait()
    game.Lighting:ClearAllChildren()
end)

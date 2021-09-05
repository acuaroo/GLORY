--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--|| VARS ||--
local changeCamera = ReplicatedStorage:WaitForChild("Remotes").ChangeCamera
local player = Players.LocalPlayer
local currentCamera = workspace.CurrentCamera

local WEIGHT = 0.1

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
    local subject = ReplicatedStorage:WaitForChild("Assets").Subject:Clone()

    subject.Position = head.Position
    currentCamera.CameraSubject = subject

    local function updateSubject()
        subject.Position = subject.Position:Lerp(head.Position,1/WEIGHT)
	
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local lookXZ = Vector3.new(currentCamera.CFrame.LookVector.X,0, currentCamera.CFrame.LookVector.Z)
            humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + lookXZ)
        end
    end

    RunService:BindToRenderStep("UpdateSubject", Enum.RenderPriority.Camera.Value, updateSubject)
end)

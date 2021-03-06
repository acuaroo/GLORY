--|| SERVICES ||--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--|| VARS ||--
local changeCamera = ReplicatedStorage:WaitForChild("Remotes").ChangeCamera
local player = Players.LocalPlayer
local currentCamera = workspace.CurrentCamera

--|| MAIN ||--
changeCamera.OnClientEvent:Connect(function()
    if currentCamera.CameraSubject == nil then
        repeat RunService.RenderStepped:Wait() until currentCamera.CameraSubject ~= nil
    end
    
    currentCamera.CameraType = Enum.CameraType.Custom
    currentCamera.CameraSubject = player.Character
end)

-- --|| SERVICES ||--
-- local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- --|| VARS ||--
-- local RaycastHitbox = require(ReplicatedStorage:WaitForChild("Modules").Raybox)

-- --|| MAIN ||--
-- local hitbox = RaycastHitbox.new(workspace:WaitForChild("acuaro_test")["Right Arm"])

-- hitbox:HitStart()

-- hitbox.OnHit:Connect(function(obj: Instance, humanoid: Humanoid)
--     humanoid:TakeDamage(10)
--     task.wait(0.1)
--     hitbox:HitStop()
--     hitbox:HitStart()
-- end)
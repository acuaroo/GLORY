--|| VARS ||--
local mainModule = {}

--|| FUNCTIONS ||--
function mainModule:ClearAllFrames(holder: GuiObject, storage: Folder, tween: boolean, tweenInfo: table)
    if not tween then 
        for _, frame: Frame in pairs(holder:GetChildren()) do
            frame.Parent = storage
        end
    else
        for _, frame: Frame in pairs(holder:GetChildren()) do
            frame:TweenPosition(UDim2.new(0, 0, -1, 0), tweenInfo):Wait()
            frame.Parent = storage
        end
    end

    return true
end


local RunService = game:GetService("RunService")

local Raydetection = {}
Raydetection.__index = Raydetection

function Raydetection._new(part)
    local new = setmetatable({}, Raydetection)
    
    new.Parent = part
    new.Length = 1
    new.RayParams = RaycastParams.new()

    return new
end
function Raydetection.newDirectional(part)
    
end
function Raydetection.newOmnidirectional(part)
    
end

function Raydetection:StartCast(frames)
    
end

function Raydetection:Cleanup()
    
end

return Raydetection
local RunService = game:GetService("RunService")

local Raydetection = {}
Raydetection.__index = Raydetection

--Enum of a part CFrame directions
Raydetection.CastDirEnum = {
    "Front",
    "Back",
    "Left",
    "Right",
    "Up",
    "Down"
}
--[[
    Constructor methods
]]
function Raydetection._new(part)
    local new = setmetatable({}, Raydetection)
    
    new.BasePart = part
    new.Length = 1
    new.RayParams = RaycastParams.new()

    new._eCastEnded = Instance.new("BindableEvent")
    new.CastEnded = new._eCastEnded.Event

    return new
end
function Raydetection.newDirectional(part, dir)
    local new = Raydetection._new(part)

    if table.find(Raydetection.CastDirEnum, dir) then
    else
        dir = "Front"
        warn("Invalid direction when creating Raydetection.newDirectional")
    end
    new.RayDir = dir

    --Method that is called every frame in :StartCast()
    --Mainly for raycasting
    function new:_Cast()
        
    end

    return new
end
--TODO
function Raydetection.newOmnidirectional(part)
    local new = Raydetection._new(part)

    --Method that is called every frame in :StartCast()
    --Mainly for raycasting
    function new:_Cast() --TODO
        
    end

    return new
end


function Raydetection:StartCast(frames)
    
end

function Raydetection:Cleanup()
    
end

return Raydetection
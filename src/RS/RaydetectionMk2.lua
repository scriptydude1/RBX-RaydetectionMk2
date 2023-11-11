--part.CFrame = part.CFrame * CFrame.new(0, 0, -5)
local RunService = game:GetService("RunService")

local Raydetection = {}
Raydetection.__index = Raydetection

--Enum of a part CFrame directions
Raydetection.CastDirEnum = {
    ["Front"] = CFrame.new(0, 0, -1),
    ["Back"] = CFrame.new(0, 0, 1),
    ["Left"] = CFrame.new(-1, 0, 0),
    ["Right"] = CFrame.new(1, 0, 0),
    ["Down"] = CFrame.new(0, -1, 0),
    ["Up"] = CFrame.new(0, 1, 0)

}

function Raydetection._fillAttach(part, volume)
    --Grabs the half of the size, makes it negative, and then fills it out with attachments from one to another end
    for x = (part.Size.X / 2) * -1, part.Size.X / 2, volume do
        for y = (part.Size.Y / 2) * -1, part.Size.Y / 2, volume do
            for z = (part.Size.Z / 2) * -1, part.Size.Z / 2, volume do
                local attachment = Instance.new("Attachment")
                attachment.Name = "RD"
                attachment.CFrame = CFrame.new(x, y, z)
                attachment.Parent = part
            end
        end
    end
end
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
function Raydetection.newDirectional(part, dir, attachVolume)
    local new = Raydetection._new(part)

    new.FromPart = part

    if Raydetection.CastDirEnum[dir] then
    else
        dir = "Front"
        warn("Invalid direction when creating Raydetection.newDirectional. Switching to Front")
    end
    new.RayDir = Raydetection.CastDirEnum[dir]

    new.Attachments = Raydetection._fillAttach(new.BasePart, attachVolume)

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
local RunService = game:GetService("RunService")

local function visualRay(result, origin, dir)
	--Credits to Ducky_akaDirt
	local distance = (origin - result.Position).Magnitude
	local p = Instance.new("Part")
	p.Parent = workspace
	p.Anchored = true
	p.CanCollide = false
	p.Color = Color3.new(1, 0, 0.0156863)
	p.Transparency = 0.75
	p.Size = Vector3.new(0.1, 0.1, distance)
    p.CFrame = CFrame.lookAt(origin, result.Position)*CFrame.new(0, 0, -distance/2)
	
	task.delay(0.5, function()
        p:Destroy()
    end)
end

local Raydetection = {}
Raydetection.__index = Raydetection

--Enum of a part CFrame directions
Raydetection.CastDirEnum = {
    ["Front"] = Vector3.new(-1,0,0),
    ["Back"] = Vector3.new(1,0,1),
    ["Left"] = Vector3.new(0,0,-1),
    ["Right"] = Vector3.new(0,0,1),
    ["Down"] = -Vector3.new(0,-1,0),
    ["Up"] = Vector3.new(0,1,0)

}
--optimizes attachment placement.
local function isSided(x, y, z, vectorSize)
    local side = false
    x, y, z = math.abs(x), math.abs(y), math.abs(z)

    if x == vectorSize.X or y == vectorSize.Y or z == vectorSize.Z then
        side = true
    end

    return side
end
--Grabs the half of the size, makes it negative, and then fills it out with attachments from one to another end
function Raydetection._fillAttach(part, volume)
    local attachments = {}
    for x = (part.Size.X / 2) * -1, part.Size.X / 2, volume do
        for y = (part.Size.Y / 2) * -1, part.Size.Y / 2, volume do
            for z = (part.Size.Z / 2) * -1, part.Size.Z / 2, volume do
                local vectorSize = Vector3.new(part.Size.X / 2, part.Size.Y / 2, part.Size.Z / 2)
                if isSided(x,y,z,vectorSize) then
                    local attachment = Instance.new("Attachment")
                    attachment.Name = "RD"
                    attachment.CFrame = CFrame.new(x, y, z)
                    attachment.Parent = part

                    table.insert(attachments, attachment)
                end
            end
        end
    end
    return attachments
end
--[[
    Constructor methods
]]
function Raydetection._new(part)
    local new = setmetatable({}, Raydetection)
    
    new.BasePart = part
    new.Length = 1
    new.Attachments = {}

    local rayparams = RaycastParams.new()
	rayparams.FilterDescendantsInstances = {part}
	rayparams.FilterType = Enum.RaycastFilterType.Exclude
	new.RayParams = rayparams

    new._eHit = Instance.new("BindableEvent")
    new.Hit = new._eHit.Event

    new._eCastStopped = Instance.new("BindableEvent")
    new.CastStopped = new._eCastStopped.Event

    return new
end
function Raydetection.newDirectional(part, dir, attachVolume)
    local new = Raydetection._new(part)

    if Raydetection.CastDirEnum[dir] then
    else
        dir = "Front"
        warn("Invalid direction when creating Raydetection.newDirectional. Switching to Front")
    end

    new.RayDir = dir
    new:SetFromPart(part)

    new.Attachments = Raydetection._fillAttach(new.BasePart, attachVolume)
    
    function new:_Cast()
        local result

        local lookVector = self.CastDirEnum[self.RayDir]
        lookVector = Vector3.new(lookVector.X * self.Length, lookVector.Y * self.Length, lookVector.Z * self.Length) 
        for i, attachment in pairs(self.Attachments) do
            --local dir = lookVector
            local dir = lookVector
            local origin = attachment.WorldCFrame.Position

            local ray = workspace:Raycast(origin, dir, self.RayParams)
            if ray then
                visualRay(ray, origin, dir)
                result = ray
            end
        end

        return result
    end

    return new
end
--TODO
function Raydetection.newOmnidirectional(part, attachVolume)
    local new = Raydetection._new(part)

    new.Attachments = Raydetection._fillAttach(new.BasePart, attachVolume)
    
    function new:_Cast() --TODO
        
    end

    return new
end


function Raydetection:StartCast(frames, cleanOnCast)
    self:SetFromPart(self.FromPart) --recalculating vectors

    if not self["_Cast"] then error("_Cast method not found!") end
    task.spawn(function()
        for i = frames, 0, -1 do
            RunService.Heartbeat:Wait()
            
            local castResult = self:_Cast()
            if castResult then
                self._eHit:Fire(castResult)
            end
        end
        if cleanOnCast then
            self:Cleanup()
        end

        self._eCastStopped:Fire()
    end)
end

function Raydetection:SetFromPart(part)
    self.FromPart = part
    self.CastDirEnum = {
        ["Front"] = part.CFrame.LookVector,
        ["Back"] = -(part.CFrame.LookVector),
        ["Left"] = -(part.CFrame.RightVector),
        ["Right"] = part.CFrame.RightVector,
        ["Down"] = -(part.CFrame.UpVector),
        ["Up"] = part.CFrame.UpVector
    }
end

function Raydetection:Cleanup()
    if #self.Attachments >= 1 then
        for i, v in pairs(self.Attachments) do
            v:Destroy()
        end
    end
end

return Raydetection
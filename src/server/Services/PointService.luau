local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.knit)

local PointService = Knit.CreateService {
  Name = "PointService",
}

function PointService:Hello()
  print("Hello from PointService")
end

function PointService:KnitInit()
  print("PointService has initialized")
end

return PointService
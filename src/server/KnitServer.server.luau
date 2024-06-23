local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.knit)

Knit.AddServices(script.Parent:WaitForChild("Services"))

Knit.Start():catch(
  function (err)
    warn("Knit failed to start")
    warn(tostring(err))
  end
):await()

print("Knit Server Started")

local PointService = Knit.GetService("PointService")
PointService:Hello()
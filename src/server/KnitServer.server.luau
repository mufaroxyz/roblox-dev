local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Knit = require(ReplicatedStorage.Packages.knit)
local Services = ServerScriptService.Server:WaitForChild("Services")
assert(Services, "Services missing")

Knit.AddServices(Services)

Knit.Start():catch(
  function (err)
    warn("Knit failed to start")
    warn(tostring(err))
  end
):await()

print("Knit Server Started")
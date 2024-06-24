local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts

local Knit = require(ReplicatedStorage.Packages.knit)
local Controllers = StarterPlayerScripts.Client:WaitForChild("Controllers")
assert(Controllers, "Controllers missing")

Knit:Start():catch(warn):await()

print("Knit client started!")
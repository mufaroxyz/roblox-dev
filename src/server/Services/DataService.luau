local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local PlayerModel = require(ReplicatedStorage.Shared.Models.PlayerModel)
local Knit = require(ReplicatedStorage.Packages.knit)
local Signal = require(Knit.Util.Signal)
local Enviroment = require(ServerScriptService.Server.Utils.Environment)
local ProfileService = require(ServerScriptService.Server.Utils.ProfileService)

local fn = {}
local DataService = Knit.CreateService {
  Name = "DataService",
}

DataService.Env = Enviroment:GetEnvironment()
DataService.DataLoaded = Signal.new()

local ProfileStore = ProfileService.GetProfileStore(DataService.Env.dbContext, PlayerModel.DefaultPlayerData)
---@diagnostic disable-next-line: undefined-type
local Profiles: { [Player]: ProfileService.Profile<PlayerModel.PlayerDataModel> } = {}

function DataService:KnitStart()
  Players.PlayerAdded:Connect(fn.PlayerAdded)
  Players.PlayerRemoving:Connect(function(player)
    if Profiles[player] then
      Profiles[player]:Release()
    end
  end)

  for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(fn.PlayerAdded, player)
  end
end

function DataService:GetPlayer(player: Player)
  return Profiles[player] or nil
end

fn.PlayerAdded = function(player: Player, self: boolean?)
  local userId = player.UserId
  local profile = ProfileStore:LoadProfileAsync(tostring(userId))

  profile:ListenToRelease(function()
    Profiles[player] = nil
    player:Kick("Couldn't load profile")
  end)

  if profile ~= nil then
    profile:AddUserId(userId)
    profile:Reconcile()

    if player:IsDescendantOf(Players) == true then
      Profiles[player] = profile
      if self == true then
        DataService.DataLoaded:Fire(player)
      end
    else
      profile:Release()
    end
  else
    player:Kick("Couldn't load profile")
  end
end

return DataService
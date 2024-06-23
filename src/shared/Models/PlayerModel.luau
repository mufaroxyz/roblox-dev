export type PlayerDataModel = {
  level: number,
  experience: number,
}

local DEFAULT_PLAYER_DATA: PlayerDataModel = {
  level = 1,
  experience = 0,
}

local shared = {}

shared.DefaultPlayerData = DEFAULT_PLAYER_DATA

return shared
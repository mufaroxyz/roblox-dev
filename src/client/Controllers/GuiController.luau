local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Knit = require(ReplicatedStorage.Packages.knit)

local GuiController = Knit.CreateController {
  Name = "GuiController",
}

GuiController.Guis = {
  LoadingScreen = PlayerGui:WaitForChild("LoadingScreen"),
  DataInfo = PlayerGui:WaitForChild("DataInfo"),
}

function GuiController:KnitInit()
  for _, gui in pairs(self.Guis) do
    gui.Visible = false
  end
end

function GuiController:LoadUI(guiName: string)
  local gui = self.Guis[guiName]
  if gui then
    gui.Visible = true
  end
end

function GuiController:HideUI(guiName: string)
  local gui = self.Guis[guiName]
  if gui then
    gui.Visible = false
  end
end

return GuiController
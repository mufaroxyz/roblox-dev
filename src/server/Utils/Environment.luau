local RunService = game:GetService("RunService")

local shared = {}

function shared:GetEnvironment()
  local dbContext = RunService:IsStudio() and "development" or "production"

  return {
    dbContext = dbContext,
  }
end

return shared